$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'sqlite3'
require 'sped2db'
require 'rspec/expectations'

RSpec.configure do |rspec|
  rspec.around(:example) do |ex|
    begin
      ex.run
    rescue SystemExit
      # ignored
    end
  end
end

RSpec::Matchers.define :contains_error do |expected|
  match do |actual|
    actual.start_with? "Erro: #{expected}"
  end
end
