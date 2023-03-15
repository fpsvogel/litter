$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require_relative "test_helper"

require "litter/litter"

class ParseTest < Minitest::Test
  self.class.attr_reader :files, :items

  def files
    self.class.files
  end

  def items
    self.class.items
  end

  # ==== TEST INPUT
  @files = {}

  ## TEST INPUT: EXAMPLES
  @files[:examples] = {}
  @files[:examples][:basic] = <<~EOM.freeze
    2023/03/08 @west wildwood
    car mat
    folding chair *2 #kept
    concrete-filled bucket @bridge

    2023/4/1
    concrete-filled bucket *2 @west wildwood #TODO
    shopping cart @bridge
    car mat #kept
  EOM



  # ==== EXPECTED DATA
  # The results of parsing the above Files are expected to equal these hashes.
  @items = {}
  @items[:examples] = {}
  @items[:examples][:basic] = {
    "car mat" => [
      { date: Date.new(2023,3,8), location: "west wildwood", tag: nil },
      { date: Date.new(2023,4,1), location: nil, tag: "kept" },
    ],
    "folding chair" => [
      { date: Date.new(2023,3,8), location: "west wildwood", tag: "kept" },
      { date: Date.new(2023,3,8), location: "west wildwood", tag: "kept" },
    ],
    "concrete-filled bucket" => [
      { date: Date.new(2023,3,8), location: "bridge", tag: nil },
      { date: Date.new(2023,4,1), location: "west wildwood", tag: "TODO" },
      { date: Date.new(2023,4,1), location: "west wildwood", tag: "TODO" },
    ],
    "shopping cart" => [
      { date: Date.new(2023,4,1), location: "bridge", tag: nil },
    ],
  }



  # ==== TESTS
  ## TESTS: EXAMPLES
  files[:examples].each do |group_name, file_str|
    define_method("test_example_#{group_name}") do
      exp = items[:examples][group_name]
      act = Litter.parse(file_str)
      # debugger unless exp == act
      assert_equal exp, act,
        "Failed to parse this group of examples: #{group_name}"
    end
  end
end
