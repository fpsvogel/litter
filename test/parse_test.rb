$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require_relative "test_helper"

require "litter/litter"

class ParseTest < Minitest::Test
  self.class.attr_reader :inputs, :outputs

  def inputs
    self.class.inputs
  end

  def outputs
    self.class.outputs
  end

  # ==== TEST INPUT
  @inputs = {}
  @inputs[:comprehensive] = <<~EOM.freeze
    2023/03/08 @west wildwood
    car mat
    folding chair *2 #kept
    concrete-filled bucket @bridge

    2023/4/1
    concrete-filled bucket *2 @west wildwood #TODO
    shopping cart @bridge
    car mat #kept
  EOM



  # ==== EXPECTED OUTPUT
  # The results of parsing the above input is expected to equal this output.
  @outputs = {}
  @outputs[:comprehensive] = {
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
  inputs.each do |name, file_str|
    define_method("test_#{name}") do
      exp = outputs[name]
      act = Litter.parse(file: StringIO.new(file_str))
      # debugger unless exp == act
      assert_equal exp, act,
        "Failed to parse this example: #{name}"
    end
  end
end
