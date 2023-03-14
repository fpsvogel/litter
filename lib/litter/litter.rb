require_relative "util/blank"
require_relative "util/string_remove"
require_relative "util/hash_deep_merge"
require_relative "util/hash_to_struct"
require_relative "errors"

require_relative "config"
require_relative "parser"

module Litter
  # Parses a file or string.
  # @param string [String] the string to be parsed. If nil, path is used instead.
  # @param path [String] the path of the file to be parsed.
  # @param config [Hash] custom config that overrides defaults in config.rb.
  def self.parse(string, path: nil, config: {})
    string ||= File.read(path)
    config = Config.new(config).hash

    Parser.new(config[:parser]).parse(string)
  end
end
