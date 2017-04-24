module Sped2DB
  class Extractor
    include EventEmitter
    include Utils

    attr_reader :layout

    def initialize(sped_files, db, opts = {})
      @sped_files = sped_files
      @db = db
      @continue_on_error = opts.fetch(:continue_on_error, false)
      @layout = get_layout(sped_files.first)
      @metadata = load_metadata
      @ids = {}
    end

    def import
      @sped_files.each_with_index { |f, i| process_file(f, i) }
    end

    private

    def load_metadata
      metadata_file = "metadata-#{@layout.type}-v#{layout.version}.yml"
      metadata_path = File.expand_path("../../../meta/#{metadata_file}", __FILE__)
      YAML.load_file(metadata_path)
    end

    def process_file(f, index)
      emit :process_file_start, f, index

      total_lines = count_lines f
      sped = File.open(f, 'r:CP850:UTF-8')
      @cnpj_pai = nil

      @db.transaction(rollback: :reraise) do
        sped.each_line do |line|
          process_line(line, sped.lineno)

          progress = ((sped.lineno * 100) / total_lines).round
          emit :progress, progress, f, index
        end
      end

      emit :process_file_end, f, index
    rescue => e
      raise unless @continue_on_error
      emit :error, e, f, index
    ensure
      sped.close unless sped.nil?
    end

    def process_line(line, lineno)
      reg = Registro.new line, @metadata
      reg_table = @db[table_name(reg)]

      @cnpj_pai = get_cnpj_pai(reg)
      id = next_id(reg)
      id_pai = @ids[reg.pai] || (@layout == :contrib ? 1 : 0)

      values = { id: id, id_pai: id_pai, cnpj_pai: @cnpj_pai }
      values.update reg.to_h

      reg_table.insert values
    rescue SpedError => e
      e.line = line
      e.lineno = lineno
      raise e
    end

    def get_cnpj_pai(reg)
      cnpj = @cnpj_pai
      name = reg.nome

      if @layout == :fiscal && name == '0000'
        cnpj = reg[:cnpj]
      elsif @layout == :contrib
        cnpj = reg[:cnpj] if name.end_with?('010') || name == '0140'
      end

      cnpj
    end

    def table_name(reg)
      "reg_#{reg.nome}".downcase.to_sym
    end

    def next_id(reg)
      reg_table = @db[table_name(reg)]
      id = @ids[reg.nome] || Integer(reg_table.max(:id) || 0)
      id += 1
      (@ids[reg.nome] = id)
    end
  end
end
