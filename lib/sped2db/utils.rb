module Sped2DB
  module Utils
    def get_first_line(file_path)
      file = File.open(file_path, 'r:CP850:UTF-8')
      file.readline
    ensure
      file.close unless file.nil?
    end

    def get_first_line_fields(file_path)
      get_first_line(file_path).split('|', -1)
    end

    def count_lines(file_path)
      # linux
      `wc -l "#{file_path}"`.strip.split(' ')[0].to_i
    rescue
      # windows
      `find /v /c "" "#{file_path}"`.strip.split(' ').last.to_i
    end

    def sped_file?(file_path)
      File.file?(file_path) && get_first_line_fields(file_path)[1] == '0000'
    end

    def get_layout(file_path)
      fields = get_first_line_fields(file_path)
      type = date_string?(fields[4]) ? :fiscal : :contrib
      version = fields[2]
      Layout.new type, version
    end

    def date_string?(str)
      str =~ /^\d{8}$/
    end
  end
end
