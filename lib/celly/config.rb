require 'pathname'

module Celly
  module Config

    def self.load
      yaml = read_config_file
      YAML.load yaml
    end

    def self.config_file
      Pathname.new File.join(ENV['HOME'], '.cellyrc')
    end

    private

    def self.read_config_file
      if config_file.exist?
        config_file.read
      else
        raise 'Could not find ~/.cellyrc. Run `celly install`!'
      end
    end
  end
end
