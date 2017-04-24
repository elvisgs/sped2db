require 'spec_helper'

module Sped2DB
  describe DbTools do
    db_name = File.expand_path('testdb.sqlite3')
    let(:db_file) { Sequel.sqlite(db_name) }
    let(:db_memory) { Sequel.sqlite(':memory:') }

    after(:each) do
      db_file.disconnect if db_file
      db_memory.disconnect if db_memory
      File.delete(db_name) if File.exist? db_name
    end

    it 'exists? retorna true se BD existir' do
      layout = Layout.new :fiscal, '011'
      db_tools = DbTools.new db_file, layout

      expect(db_tools.exists?).to be true
    end

    context 'create_tables' do
      it 'executa migrations do layout fiscal versao 009' do
        layout = Layout.new :fiscal, '009'
        db_tools = DbTools.new db_memory, layout

        expect { db_tools.create_tables }.not_to raise_exception
      end

      it 'executa migrations do layout fiscal versao 010' do
        layout = Layout.new :fiscal, '010'
        db_tools = DbTools.new db_memory, layout

        expect { db_tools.create_tables }.not_to raise_exception
      end

      it 'executa migrations do layout fiscal versao 011' do
        layout = Layout.new :fiscal, '011'
        db_tools = DbTools.new db_memory, layout

        expect { db_tools.create_tables }.not_to raise_exception
      end

      it 'executa migrations do layout contrib versao 002' do
        layout = Layout.new :contrib, '002'
        db_tools = DbTools.new db_memory, layout

        expect { db_tools.create_tables }.not_to raise_exception
      end

      it 'executa migrations do layout contrib versao 003' do
        layout = Layout.new :contrib, '003'
        db_tools = DbTools.new db_memory, layout

        expect { db_tools.create_tables }.not_to raise_exception
      end
    end
  end
end
