require "parslet"
require "date"

require_relative "util/hash_deep_merge"
require_relative "config"
require_relative "errors"
require_relative "parsing/litter_file"

module Litter
  # Parses a file. See Parser::LitterFile#initialize and #parse for details.
  def self.parse(...)
    file = Parsing::LitterFile.new(...)
    file.parse
  end
end
