Sequel.extension :migration

module Sped2DB
  class DbTools
    DEFAULT_DATABASES = {
      ado: 'master',
      mysql2: 'mysql',
      postgres: 'template1'
    }.freeze

    def initialize(db, layout)
      @db = db
      @layout = layout
    end

    def exists?
      @db.test_connection
    rescue Sequel::DatabaseConnectionError
      false
    end

    def create_database
      db_opts = @db.opts.dup
      adapter = db_opts[:adapter].to_sym

      return unless DEFAULT_DATABASES.keys.include? adapter

      db_name = db_opts[:database]
      db_opts[:database] = DEFAULT_DATABASES[adapter]

      Sequel.connect(db_opts) do |db|
        db.run "create database #{db_name}"
      end
    end

    def create_tables
      directory = "../../../migrations/#{@layout.type}/v#{@layout.version}"
      Sequel::Migrator.run @db, File.expand_path(directory, __FILE__)

      # @db.drop_table? :schema_info
    end
  end
end
