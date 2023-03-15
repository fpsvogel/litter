module Litter
  module Parsing
    class Transform
      # Transforms output from Parser (an array of entry hashes) into a hash of
      # arrays containing item finds.
      # @param parsed [Array<Hash>] output from Parser.
      # @return [Hash] a hash of items and their finds; see parse_test.rb for an example.
      def apply(parsed)
        all_items = {}

        parsed.each do |entry|
          extract_entry_into_all_items(entry, all_items)
        end

        all_items
      end

      private

      # Adds the given entry's item finds to the given hash of all items.
      # @param entry [Hash] an entry (items found on a date).
      # @param all_items [Hash] all items extracted from entries so far.
      def extract_entry_into_all_items(entry, all_items)
        entry[:items].each do |item|
          name = item[:name].to_s.strip
          date = Date.parse(entry[:date])
          quantity = Integer(item[:quantity].to_s, exception: false) || 1
          location = (item[:location] || entry[:location])&.to_s&.strip
          tag = item[:tag]&.to_s

          all_items[name] ||= []
          quantity.times do
            all_items[name] << { date:, location:, tag: }
          end
        end
      end
    end
  end
end
