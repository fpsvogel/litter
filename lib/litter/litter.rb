require "parslet"
require "date"

require_relative "util/hash_deep_merge"
require_relative "config"
require_relative "errors"
require_relative "parsing/file"

module Litter
  # Parses a file. See Parser::File#initialize and #parse for details.
  def self.parse(...)
    file = Parsing::File.new(...)
    file.parse
  end
end
