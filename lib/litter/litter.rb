require_relative "parser"


module Litter
  # Parses a file or string.
  # @param string [String] the string to be parsed. If nil, path is used instead.
  # @param path [String] the path of the file to be parsed.
  def self.parse(string, path: nil)
    string ||= File.read(path)

    Parser.new.parse(string)
  end
end
