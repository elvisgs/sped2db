require 'spec_helper'

module Sped2DB
  describe Registro do
    context 'initialize' do
      it 'lanca excecao se registro for invalido' do
        line = '|XXXX|111|222|'
        metadata = YAML.load_file 'meta/metadata-fiscal-v011.yml'

        expect do
          Registro.new line, metadata
        end.to raise_error(SpedError)
      end

      it 'lanca excecao se numero de valores for diferente do numero de campos' do
        line = '|0200|1|PREGO|a|a|KG|00|1|aaa|24|1111|10|xxx|xxx|'
        metadata = YAML.load_file 'meta/metadata-fiscal-v011.yml'

        expect do
          Registro.new line, metadata
        end.to raise_error(SpedError)
      end
    end

    it 'deve acessar campos pelo metodo []' do
      line = '|0200|1|PREGO|a|a|KG|00|1|aaa|24|1111|10||'
      metadata = YAML.load_file 'meta/metadata-fiscal-v011.yml'

      reg = Registro.new line, metadata

      expect(reg[:cod_item]).to eq '1'
      expect(reg[:descr_item]).to eq 'PREGO'
      expect(reg[:aliq_icms]).to eq '10'
    end

    it 'deve desconsiderar \n no final da linha' do
      line = "|0200|1|PREGO|a|a|KG|00|1|aaa|24|1111|10||\n"
      metadata = YAML.load_file 'meta/metadata-fiscal-v011.yml'

      reg = Registro.new line, metadata

      expect(reg.valores.length).to eq 12 # o primeiro campo não conta, é identificador
    end

    it 'deve desconsiderar \r\n no final da linha' do
      line = "|0200|1|PREGO|a|a|KG|00|1|aaa|24|1111|10||\r\n"
      metadata = YAML.load_file 'meta/metadata-fiscal-v011.yml'

      reg = Registro.new line, metadata

      expect(reg.valores.length).to eq 12 # o primeiro campo não conta, é identificador
    end
  end
end
