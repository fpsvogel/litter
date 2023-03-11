$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require_relative "test_helper"

# TODO require the parser
# require "litter/shortcuts"

class ParseTest < Minitest::Test
  self.class.attr_reader :files, :items

  def files
    self.class.files
  end

  def items
    self.class.items
  end

  # ==== TEST INPUT
  ## TEST INPUT: # TODO
  # TODO description
  @files = {}
  # @files[:features_head] =
  # {
  # :"author" =>
  #   "Tom Holt - Goatsong",
  # :"series" =>
  #   "Tom Holt - Goatsong -- in The Walled Orchard",
  # :"series with volume" =>
  #   "Tom Holt - Goatsong -- The Walled Orchard, #1",
  # :"extra info" =>
  #   "Tom Holt - Goatsong -- paperback -- 1990",
  # :"extra info and series" =>
  #   "Tom Holt - Goatsong -- paperback -- The Walled Orchard, #1 -- 1990",
  # :"format" =>
  #   "📕Tom Holt - Goatsong",
  # :"multi items" =>
  #   "📕Tom Holt - Goatsong, 🔊Sapiens",
  # :"multi items without a comma" =>
  #   "📕Tom Holt - Goatsong 🔊Sapiens",
  # :"multi items with a long separator" =>
  #   "📕Tom Holt - Goatsong -- 🔊Sapiens",
  # :"progress" =>
  #   "50% Goatsong",
  # :"progress pages" =>
  #   "p220 Goatsong",
  # :"progress pages without p" =>
  #   "220 Goatsong",
  # :"progress time" =>
  #   "2:30 Goatsong",
  # :"dnf" =>
  #   "DNF Goatsong",
  # :"dnf with progress" =>
  #   "DNF 50% Goatsong",
  # :"dnf with multi items" =>
  #   "DNF 📕Tom Holt - Goatsong, 🔊Sapiens",
  # :"all features" =>
  #   "DNF 50% 📕Tom Holt - Goatsong -- paperback -- The Walled Orchard, #1 -- 1990, 🔊Sapiens"
  # }



  # ==== EXPECTED DATA
  # The results of parsing the above Files are expected to equal these hashes.
  @items = {}
  # @items[:features_head] = {}
  # a_basic = item_hash(author: "Tom Holt", title: "Goatsong")
  # @items[:features_head][:"author"] = [a_basic]

  # a = a_basic.deep_merge(variants: [{ series: [{ name: "The Walled Orchard" }] }])
  # @items[:features_head][:"series"] = [a]

  # a = a.deep_merge(variants: [{ series: [{ volume: 1 }] }])
  # series_with_volume = a[:variants].first.slice(:series)
  # @items[:features_head][:"series with volume"] = [a]

  # extra_info = %w[paperback 1990]
  # variants_with_extra_info = { variants: [{ extra_info: extra_info }] }
  # a = a_basic.deep_merge(variants_with_extra_info)
  # @items[:features_head][:"extra info"] = [a]

  # a = a.deep_merge(variants: [series_with_volume])
  # @items[:features_head][:"extra info and series"] = [a]

  # a_with_format = a_basic.deep_merge(variants: [{ format: :print }])
  # @items[:features_head][:"format"] = [a_with_format]

  # b = item_hash(title: "Sapiens", variants: [{ format: :audiobook }])
  # @items[:features_head][:"multi items"] = [a_with_format, b]

  # @items[:features_head][:"multi items without a comma"] = [a_with_format, b]

  # @items[:features_head][:"multi items with a long separator"] = [a_with_format, b]

  # half_progress = { experiences: [{ spans: [{ progress: 0.5 }] }] }
  # a = item_hash(title: "Goatsong", **half_progress)
  # @items[:features_head][:"progress"] = [a]

  # a = item_hash(title: "Goatsong", experiences: [{ spans: [{ progress: 220 }] }])
  # @items[:features_head][:"progress pages"] = [a]

  # @items[:features_head][:"progress pages without p"] = [a]

  # a = item_hash(title: "Goatsong", experiences: [{ spans: [{ progress: "2:30" }] }])
  # @items[:features_head][:"progress time"] = [a]

  # a = item_hash(title: "Goatsong", experiences: [{ spans: [{ progress: 0 }] }])
  # @items[:features_head][:"dnf"] = [a]

  # a = item_hash(title: "Goatsong", experiences: [{ spans: [{ progress: 0.5 }] }])
  # @items[:features_head][:"dnf with progress"] = [a]

  # a = a_with_format.deep_merge(experiences: [{ spans: [{ progress: 0 }] }])
  # b = b.deep_merge(experiences: [{ spans: [{ progress: 0 }] }])
  # @items[:features_head][:"dnf with multi items"] = [a, b]

  # full_variants = variants_with_extra_info.deep_merge(variants: [series_with_volume])
  # a = a.deep_merge(full_variants).deep_merge(half_progress)
  # b = b.deep_merge(half_progress)
  # @items[:features_head][:"all features"] = [a, b]



  # ==== THE ACTUAL TESTS
  ## TESTS: FEATURES OF SINGLE COLUMNS
  files.keys.select { |key| key.start_with?("features_") }.each do |group_name|
    files[group_name].each do |feat, file_str|
      define_method("test_#{columns_sym}_feature_#{feat}") do
        # config = with_columns(columns + [:head])
        # exp = tidy(items[group_name][feat])
        # act = Litter.parse(file_str, config: config)
        # # debugger unless exp == act
        # assert_equal exp, act,
        #   "Failed to parse this #{main_column_humanized} column feature: #{feat}"
      end
    end
  end
end
