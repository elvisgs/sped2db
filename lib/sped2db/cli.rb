module Sped2DB
  class CLI
    include Utils

    DEFAULT_CONFIG_FILE = 'sped2db.yml'.freeze
    CONFIG_NOT_PROVIDED = 'Arquivo de configuração não encontrado
                           e opção -c não especificada'.freeze
    CONFIG_INVALID = 'Arquivo de configuração ou URI inválido(a)'.freeze
    SPED_PATH_INVALID = 'Caminho de arquivo(s) SPED inválido'.freeze
    SPED_FILES_NOT_FOUND = 'O caminho especificado não é ou não contém arquivo(s) SPED'.freeze

    attr_reader :opts

    def initialize(io = $stdout, extractor = nil, db_tools = nil)
      @io = io
      @extractor = extractor
      @db_tools = db_tools
      @exe = 'sped2db'
    end

    def run(args)
      @args = args
      @opts = parse_args(args)

      process_opts
    end

    private

    def parse_args(args)
      Slop.parse(args) do |o|
        o.banner = "Uso: #{@exe} [opções] <caminho sped>"
        o.separator 'Opções:'
        o.string '-c', '--config',
                 'Arquivo de configuração ou URI de conexão (default: ./sped2db.yml)'
        o.string '-n', '--dbname', 'Nome do BD (sobrescreve config)'
        o.string '-u', '--user', 'Nome do usuário do BD (sobrescreve config)'
        o.string '-p', '--passwd', 'Senha do usuário (sobrescreve config)'
        o.bool '-e', '--continue-on-error', 'Continua se encontrar erro (default: false)',
               default: false
        o.on('-v', '--version') { show_version }
        o.on('-h', '--help') { show_help(o) }
      end
    end

    def process_opts
      show_help if @args.nil? || @args.empty?
      show_error CONFIG_NOT_PROVIDED unless exist_config?

      db_config = fetch_db_config
      db_opts = fetch_db_opts
      @sped_files = fetch_sped_files
      @layout = get_layout @sped_files.first

      @io.puts "SPED #{@layout.type.to_s.capitalize} v#{@layout.version}"

      @db = Sequel.connect(db_config, db_opts)
      bootstrap_db
      import
    rescue => e
      @io.puts format_error(e)
    ensure
      @db.disconnect unless @db.nil?
    end

    def fetch_db_config
      config = opts[:config] || DEFAULT_CONFIG_FILE
      config_hash = YAML.load_file(config) if File.exist?(config)
      config_hash || config
    end

    def fetch_db_opts
      db_name = opts[:dbname]
      user = opts[:user]
      passwd = opts[:passwd]
      db_opts = {}
      db_opts.update(database: db_name) unless db_name.nil?
      db_opts.update(user: user) unless user.nil?
      db_opts.update(password: passwd) unless passwd.nil?
      db_opts
    end

    def fetch_sped_files
      path = opts.args[0]
      show_error SPED_PATH_INVALID if path.nil?
      show_error SPED_PATH_INVALID unless file_or_dir?(path)

      sped_files = Find.find(path).select { |f| sped_file?(f) }
      show_error SPED_FILES_NOT_FOUND if sped_files.size.zero?

      sped_files
    end

    def bootstrap_db
      @db_tools ||= DbTools.new(@db, @layout)

      if @db_tools.exists?
        @io.puts 'Banco de dados existente'
      else
        @io.puts 'Criando Banco de dados'
        @db_tools.create_database
      end

      @io.puts 'Criando tabelas'
      @db_tools.create_tables
    end

    def import
      @extractor ||= Extractor.new@sped_files, @db, continue_on_error: opts.continue_on_error?
      @files_count = @sped_files.size

      configure_progress_listeners

      @extractor.import
    end

    def configure_progress_listeners
      progressbar = nil
      io = @io
      files_count = @files_count
      format_error = method(:format_error)

      @extractor.on :process_file_start do |file, index|
        file = File.basename(file)
        io.puts format("\n[%03d/%03d] %s", index + 1, files_count, file)
        progressbar = ProgressBar.create(title: 'Progresso', format: '[%B] %p%%', output: io)
      end
      @extractor.on :progress do |progress|
        progressbar.progress = progress if progress > progressbar.progress
      end
      @extractor.on(:process_file_end) { progressbar.finish }
      @extractor.on :error do |e|
        progressbar.stop
        io.puts format_error[e]
      end
    end

    def show_version
      @io.puts Sped2DB::VERSION
      exit
    end

    def show_help(opts = nil)
      @io.puts opts || @opts
      @io.puts "\nExemplos:"

      @io.puts "\n# Usa configurações de conexão do sped2db.yml no diretório"
      @io.puts '# atual e carrega arquivo ~/sped.txt no BD teste'
      @io.puts "#{@exe} -n teste ~/sped.txt"

      @io.puts "\n# Usa configurações de conexão contidas em ~/database.yml"
      @io.puts '# com usuário john, senha 123 e carrega arquivo ~/sped.txt'
      @io.puts "#{@exe} -c ~/database.yml -u john -p 123 ~/sped.txt"

      @io.puts "\n# Usa URI de conexão e carrega todos os arquivos SPED do"
      @io.puts '# diretório ~/sped-files/, mesmo se algum tiver erros'
      @io.puts "#{@exe} -c postgres://localhost/teste -e ~/sped-files/"
      exit
    end

    def format_error(e)
      msg = "Erro: #{e.class}: #{e.message}\n#{e.backtrace.first}\n"
      msg << "Linha #{e.lineno}: #{e.line}" if e.instance_of? SpedError
      msg
    end

    def show_error(msg)
      @io.puts "Erro: #{msg}"
      @io.puts "Para mais detalhes: #{@exe} --help"
      exit 1
    end

    def exist_config?
      !opts[:config].nil? || File.exist?(DEFAULT_CONFIG_FILE)
    end

    def file_or_dir?(path)
      File.file?(path) || File.directory?(path)
    end
  end
end
