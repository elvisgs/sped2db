module Sped2DB
  class Registro
    attr_reader :nome, :pai, :campos, :valores

    def initialize(linha, metadados)
      @linha = linha
      @metadados = metadados
      @valores = dividir_linha_em_valores linha
      @nome = @valores.shift.upcase

      validar_registro

      @pai = @metadados[@nome]['pai']
      @campos = @metadados[@nome]['campos']

      validar_campos

      corrigir_caracteres_especiais
      corrigir_datas

      @hash = to_h
    end

    def to_h
      valores = @valores.map { |v| v.empty? ? nil : v }
      @campos.map(&:to_sym).zip(valores).to_h
    end

    def [](key)
      @hash[key.to_sym]
    end

    private

    def dividir_linha_em_valores(linha)
      linha.chomp.sub(/^\|/, '').sub(/\|$/, '').gsub('\\', '\\\\\\\\').split('|', -1)
    end

    def corrigir_caracteres_especiais
      @valores.map! do |c|
        c.strip!
        c.sub!(/,/, '.') if eh_decimal? c
        c.gsub!(/'/, "''")
        c
      end
    end

    def eh_decimal?(str)
      str =~ /^-?\d+,\d+$/
    end

    def corrigir_datas
      @campos.each_with_index do |campo, i|
        if campo.start_with?('dt_', 'dat_')
          @valores[i] = formatar_data @valores[i]
        end
      end

      @valores[0] = '0' if @nome == 'C495' && @valores[0] == ''
    end

    def formatar_data(d)
      d != '' ? Date.strptime(d, '%d%m%Y').strftime('%Y-%m-%d') : ''
    end

    def validar_registro
      msg = "Registro #{@nome} nao suportado"
      raise SpedError.new msg, @linha unless @metadados.key? @nome
    end

    def validar_campos
      msg = "Linha contem #{@valores.size + 1} campo(s), "
      msg << "mas #{@campos.size + 1} eram esperado(s)"
      raise SpedError.new msg, @linha if @valores.size != @campos.size
    end
  end
end
