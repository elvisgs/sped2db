require 'spec_helper'
require 'rspec/mocks'

module Sped2DB
  describe Extractor do
    let(:db) { Sequel.sqlite(':memory:') }
    after(:each) { db.disconnect if db }

    context 'new' do
      it 'com arquivos sped fiscal ok' do
        file = 'spec/files/fiscal/sped_fiscal.txt'

        extractor = Extractor.new [file], db

        expect(extractor).not_to be nil
        expect(extractor.layout.type).to be :fiscal
        expect(extractor.layout.version).to eq '010'
      end

      it 'com arquivos sped contrib ok' do
        file = 'spec/files/contrib/sped_contrib.txt'

        extractor = Extractor.new [file], db

        expect(extractor).not_to be nil
        expect(extractor.layout.type).to be :contrib
        expect(extractor.layout.version).to eq '003'
      end
    end

    context 'import' do
      it 'com arquivos sped fiscal ok' do
        files = ['spec/files/fiscal/sped_fiscal.txt']
        layout = Layout.new :fiscal, '010'
        DbTools.new(db, layout).create_tables
        extractor = Extractor.new files, db

        expect { extractor.import }.not_to raise_exception
        expect(db[:reg_0000].count).to be 1
      end

      it 'com arquivos sped contrib ok' do
        files = ['spec/files/contrib/sped_contrib.txt']
        layout = Layout.new :contrib, '003'
        DbTools.new(db, layout).create_tables
        extractor = Extractor.new files, db

        expect { extractor.import }.not_to raise_exception
        expect(db[:reg_0000].count).to be 1
      end

      it 'dispara evento :process_file_start' do
        files = %w[spec/files/fiscal/sped_fiscal.txt spec/files/fiscal/sped_fiscal.txt]
        layout = Layout.new :fiscal, '010'
        DbTools.new(db, layout).create_tables
        extractor = Extractor.new(files, db)
        result = []
        extractor.on :process_file_start do |file, index|
          result[index] = file
        end

        extractor.import

        expect(result[0]).to eq files[0]
        expect(result[1]).to eq files[1]
      end

      it 'dispara evento :process_file_end' do
        files = %w[spec/files/fiscal/sped_fiscal.txt spec/files/fiscal/sped_fiscal.txt]
        layout = Layout.new :fiscal, '010'
        DbTools.new(db, layout).create_tables
        extractor = Extractor.new(files, db)
        result = []
        extractor.on :process_file_end do |file, index|
          result[index] = file
        end

        extractor.import

        expect(result[0]).to eq files[0]
        expect(result[1]).to eq files[1]
      end

      it 'dispara evento :progress' do
        files = %w[spec/files/fiscal/sped_fiscal.txt]
        layout = Layout.new :fiscal, '010'
        DbTools.new(db, layout).create_tables
        extractor = Extractor.new(files, db)
        result = []
        extractor.on :progress do |progress, file, index|
          result[index] = { file: file, progress: progress }
        end

        extractor.import

        expect(result[0][:file]).to eq files[0]
        expect(result[0][:progress] > 0).to be true
      end

      it 'seta cnpj_pai quando layout = fiscal' do
        files = ['spec/files/fiscal/sped_fiscal.txt']
        layout = Layout.new :fiscal, '010'
        DbTools.new(db, layout).create_tables
        extractor = Extractor.new files, db

        extractor.import

        expect(db[:reg_0000].first[:cnpj_pai]).to eq '10848620000139'
        expect(db[:reg_0001].first[:cnpj_pai]).to eq '10848620000139'
        expect(db[:reg_c100].first[:cnpj_pai]).to eq '10848620000139'
      end

      it 'seta cnpj_pai quando layout = contrib' do
        files = ['spec/files/contrib/sped_contrib.txt']
        layout = Layout.new :contrib, '003'
        DbTools.new(db, layout).create_tables
        extractor = Extractor.new files, db

        extractor.import

        expect(db[:reg_0000].first[:cnpj_pai]).to be nil
        expect(db[:reg_0001].first[:cnpj_pai]).to be nil
        expect(db[:reg_0140].first[:cnpj_pai]).to eq '99999999000191'
        expect(db[:reg_d100].first[:cnpj_pai]).to eq '99999999000191'
      end
    end
  end
end
