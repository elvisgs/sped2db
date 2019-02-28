module Sped2DB
  class Layout
    VERSIONS = {
      fiscal: %w[009 010 011],
      contrib: %w[002 003 004 005]
    }.freeze

    attr_reader :type, :version

    def initialize(type, version)
      raise ArgumentError, 'type is nil' if type.nil?
      type = type.to_sym

      layouts = VERSIONS.keys.join(', ')
      raise ArgumentError, "type must be one of #{layouts}" unless
        VERSIONS.key? type

      raise ArgumentError, 'version is nil' if version.nil?

      versions = VERSIONS[type].join(', ')
      raise ArgumentError, "version must be one of #{versions}" unless
        versions.include? version

      @type = type
      @version = version
    end

    def to_s
      "SPED #{type.to_s.capitalize} v#{version}"
    end
  end
end
