module Litter
  module Parsing
    # Example output from the example in parse_test.rb.
    # Note: what looks like strings followed by "@" are actually Parslet::Slice.
    #
    # [{:date=>"2023/03/08"@0,
    #   :location=>"west wildwood"@12,
    #   :items=>
    #    [{:name=>"car mat"@26},
    #     {:name=>"folding chair "@34, :quantity=>"2"@49, :tag=>"kept"@52},
    #     {:name=>"concrete-filled bucket "@57, :location=>"bridge"@81}]},
    #  {:date=>"2023/4/1"@89,
    #   :items=>
    #    [{:name=>"concrete-filled bucket "@98, :quantity=>"2"@122, :location=>"west wildwood "@125, :tag=>"TODO"@140},
    #     {:name=>"shopping cart "@145, :location=>"bridge"@160},
    #     {:name=>"car mat "@167, :tag=>"kept"@176}]}]
    #
    class Parser < Parslet::Parser
      attr_reader :config

      # @param config [Hash] the parser config, such as Config#default_config[:parser]
      def initialize(config)
        @config = config
        super()
      end

      rule(:newline) { str("\n") }
      rule(:space) { match('\s').repeat(1) }
      rule(:date_sep) { str(config.fetch(:date_sep)) }
      rule(:loc_char) { str(config.fetch(:loc_char)) }
      rule(:qty_char) { str(config.fetch(:qty_char)) }
      rule(:tag_char) { str(config.fetch(:tag_char)) }
      rule(:not_tag) { match( "[^\\n\\#{config.fetch(:tag_char)}]") }
      rule(:not_special) {
        match("[^\\n\\#{config[:qty_char]}\\#{config[:loc_char]}\\#{config[:tag_char]}]")
      }

      rule(:year) { match('[0-9]').repeat(4,4) }
      rule(:day_or_month) { match('[0-9]').repeat(1,2) }
      rule(:date) { (year >> date_sep >> day_or_month >> date_sep >> day_or_month).as(:date) }

      rule(:location) { space.maybe >> loc_char >> not_tag.repeat(1).as(:location)}
      rule(:date_line) { date >> location.maybe >> newline }

      rule(:name) { not_special.repeat(1).as(:name) }
      rule(:quantity) { qty_char >> match('[0-9]').repeat(1).as(:quantity) }
      rule(:tag) { space.maybe >> tag_char >> match('[^\n]').repeat(1).as(:tag) }
      rule(:item) { name >> quantity.maybe >> location.maybe >> tag.maybe }

      rule(:items) { (item >> newline).repeat.as(:items) }
      rule(:entry) { date_line >> items >> newline.repeat }

      rule(:document) { entry.repeat }

      root :document
    end
  end
end
