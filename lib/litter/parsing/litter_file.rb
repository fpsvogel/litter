require_relative "parser"
require_relative "transform"

module Litter
  module Parsing
    class LitterFile
      attr_reader :string, :config

      # @param path [String] the path of the file to be parsed; if nil, uses file instead.
      # @param path [File] the file to be parsed.
      # @param config [Hash] custom config that overrides defaults in config.rb.
      def initialize(path = nil, file: nil, config: {})
        validate_path_or_file(path, file)

        @string = path ? File.read(path) : file.read
        @config = Config.new(config || {}).hash
      end

      # Parses the file.
      # @return [Hash] a hash of items and their finds; see parse_test.rb for an example.
      def parse
        parsed = Parser.new(config[:parser]).parse(string)
        hashes = Transform.new.apply(parsed)

        hashes
      end

      private

      # Checks on the given file path.
      # @raise [FileError] if the given path is invalid.
      # @raise [ArgumentError] if both path and file are nil.
      def validate_path_or_file(path, file)
        return true if file && file.respond_to?(:read)

        if path
          if !File.exist?(path)
            raise FileError, "File not found! #{path}"
          elsif File.directory?(path)
            raise FileError, "A file is expected, but the path given is a directory: #{path}"
          end
        else
          raise ArgumentError, "Either a string or a file path must be provided."
        end
      end
    end
  end
end
