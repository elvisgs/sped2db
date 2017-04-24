require 'spec_helper'
require 'stringio'
require 'yaml'
require 'rspec/mocks'

module Sped2DB
  describe CLI do
    let(:stdout) do
      stdout = StringIO.new
      stdout.set_encoding 'UTF-8'
      stdout
    end
    let(:extractor) { double('extractor') }
    let(:db_tools) { double('db_tools') }
    let(:cli) { CLI.new(stdout, extractor, db_tools) }

    context 'sem argumentos' do
      it 'exibe help' do
        cli.run([])

        expect(stdout.string).to start_with cli.opts.to_s
      end
    end

    context 'com opção -h' do
      it 'exibe help' do
        cli.run([])

        expect(stdout.string).to start_with cli.opts.to_s
      end
    end

    context 'com opção -v' do
      it 'exibe versão' do
        cli.run(['-v'])

        expect(stdout.string).to start_with Sped2DB::VERSION
      end
    end

    context 'sem opção -c' do
      context 'sped2db.yml não existe' do
        it 'exibe mensagem de erro' do
          args = ['spec/files/sped_fiscal.txt']
          cli.run args

          expect(stdout.string).to contains_error CLI::CONFIG_NOT_PROVIDED
        end
      end

      context 'sped2db.yml existe' do
        config_file = File.expand_path CLI::DEFAULT_CONFIG_FILE

        before do
          db_config = { adapter: 'sqlite' }
          File.open(config_file, 'w') { |f| f.write db_config.to_yaml }
        end

        after do
          File.delete(config_file) if File.exist?(config_file)
        end

        it 'prossegue sem erro' do
          args = ['spec/files/sped_fiscal.txt']
          cli.run args

          expect(stdout.string).not_to contains_error CLI::CONFIG_NOT_PROVIDED
        end
      end
    end

    context 'com opção -c' do
      config_file = File.expand_path 'test.yml'

      before do
        db_config = { adapter: 'sqlite' }
        File.open(config_file, 'w') { |f| f.write db_config.to_yaml }
      end

      after do
        File.delete(config_file) if File.exist?(config_file)
      end

      it 'exibe erro se valor informado não é arquivo nem uri' do
        args = %w[-c foo.yml spec/files/sped_fiscal.txt]
        cli.run args

        expect(stdout.string).to contains_error CLI::CONFIG_INVALID
      end

      it 'prossegue sem erro se valor informado é uri válida' do
        args = %w[-c sqlite:/ spec/files/sped_fiscal.txt]
        cli.run args

        expect(stdout.string).not_to contains_error CLI::CONFIG_INVALID
      end

      it 'prossegue sem erro se valor informado é arquivo yaml válido' do
        args = %w[-c test.yml spec/files/sped_fiscal.txt]
        cli.run args

        expect(stdout.string).not_to contains_error CLI::CONFIG_INVALID
      end
    end

    context 'com opção -n' do
      db_name = 'test.db'

      after(:each) do
        File.delete(db_name) if File.exist?(db_name)
      end

      it 'sobrescreve database da configuração' do
        args = %w[-c sqlite://foo.db -n test.db spec/files/sped_fiscal.txt]
        cli.run args

        expect(File.exist?('foo.db')).to be false
        expect(File.exist?(db_name)).to be true
      end
    end

    context 'com opções -u e -p' do
      it 'sobrescreve usuãrio/senha da configuração' do
        args = %w[-c sqlite:/ -u test -p pass spec/files/sped_fiscal.txt]
        cli.run args

        db_opts = cli.fetch_db_opts
        expect(db_opts[:user]).to eq 'test'
        expect(db_opts[:password]).to eq 'pass'
      end
    end

    context 'sem caminho sped' do
      it 'exibe erro' do
        args = %w[-c sqlite:/]
        cli.run args

        expect(stdout.string).to contains_error CLI::SPED_PATH_INVALID
      end
    end

    context 'com caminho sped' do
      it 'exibe erro se caminho inválido' do
        args = %w[-c sqlite:/ invalid/path/]
        cli.run args

        expect(stdout.string).to contains_error CLI::SPED_PATH_INVALID
      end

      it 'exibe erro se caminho não tiver arquivos SPED' do
        args = %w[-c sqlite:/ tmp/]
        cli.run args

        expect(stdout.string).to contains_error CLI::SPED_FILES_NOT_FOUND
      end

      it 'prossegue sem erro se caminho tiver arquivos SPED' do
        allow(db_tools).to receive_messages(%i[exists? create_database create_tables])
        allow(extractor).to receive_messages(%i[import on])
        args = %w[-c sqlite:/ spec/files/fiscal/]
        cli.run args

        expect(stdout.string).not_to contains_error CLI::SPED_FILES_NOT_FOUND
      end

      it 'cria BD se não existir' do
        allow(db_tools).to receive(:exists?).and_return(false)
        allow(db_tools).to receive(:create_tables)
        allow(extractor).to receive_messages(%i[import on])

        expect(db_tools).to receive(:create_database)

        args = %w[-c sqlite:/ spec/files/fiscal/]
        cli.run args
        puts stdout.string
      end

      it 'cria tabelas (executa migrations)' do
        allow(db_tools).to receive_messages(%i[exists? create_database])
        allow(extractor).to receive_messages(%i[import on])

        expect(db_tools).to receive(:create_tables)

        args = %w[-c sqlite:/ spec/files/fiscal/]
        cli.run args
      end

      it 'executa importação sem erros' do
        allow(db_tools).to receive_messages(%i[exists? create_database create_tables])
        allow(extractor).to receive(:on)

        expect(extractor).to receive(:import)

        args = %w[-c sqlite:/ spec/files/fiscal/]
        cli.run args

        expect(stdout.string).not_to include('Erro')
      end

      it 'mostra progresso' do
        cli = CLI.new stdout
        args = %w[-c sqlite:/ spec/files/fiscal/sped_fiscal.txt]

        cli.run args

        expect(stdout.string).to include('[001/001] sped_fiscal.txt')
        expect(stdout.string).to include('Progresso')
      end
    end

    it 'continua execução se opção -e estiver ativada' do
      cli = CLI.new stdout
      args = %w[-c sqlite:/ -e spec/files/fiscal]

      cli.run args

      expect(stdout.string).to include('Erro')
      expect(stdout.string).to include('[002/002] sped_fiscal.txt')
    end
  end
end
