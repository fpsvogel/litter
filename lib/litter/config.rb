module Litter
  # Builds a hash config.
  class Config
    using Util::HashDeepMerge

    attr_reader :hash

    # @param custom_config [Hash] a custom config which overrides the defaults,
    #   e.g. { parser: { date_sep: '-' } }
    def initialize(custom_config = {})
      @hash = default_config.deep_merge(custom_config)
    end

    private

    # The default config, excluding Regex config (see further down).
    # @return [Hash]
    def default_config
      {
        parser:
          {
            date_sep: '/',
            loc_char: '@',
            qty_char: '*',
            tag_char: '#',
          },
      }
    end
  end
end
