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

  @inputs[:comprehensive] = {}
  @inputs[:comprehensive][:file] = <<~EOM.freeze
    2023/03/08 @west wildwood
    car mat
    folding chair *2 #kept
    concrete-filled bucket @bridge

    2023/4/1
    concrete-filled bucket *2 @west wildwood #TODO
    shopping cart @bridge
    car mat #kept
  EOM

  @inputs[:all_custom_config] = {}
  @inputs[:all_custom_config][:file] = <<~EOM.freeze
    2023-4-1
    concrete-filled bucket #2 ~west wildwood !TODO
  EOM
  @inputs[:all_custom_config][:config] =
    {
      parser:
        {
          date_sep: '-',
          loc_char: '~',
          qty_char: '#',
          tag_char: '!',
        },
    }

  @inputs[:some_custom_config] = {}
  @inputs[:some_custom_config][:file] = <<~EOM.freeze
    2023-4-1
    concrete-filled bucket *2 ~west wildwood #TODO
  EOM
  @inputs[:some_custom_config][:config] =
    {
      parser:
        {
          date_sep: '-',
          loc_char: '~',
        },
    }



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

  @outputs[:all_custom_config] = {
    "concrete-filled bucket" => [
      { date: Date.new(2023,4,1), location: "west wildwood", tag: "TODO" },
      { date: Date.new(2023,4,1), location: "west wildwood", tag: "TODO" },
    ],
  }
  @outputs[:some_custom_config] = @outputs[:all_custom_config]


  # ==== TESTS
  inputs.each do |name, input_hash|
    define_method("test_#{name}") do
      file = StringIO.new(input_hash[:file])
      config = input_hash[:config]

      exp = outputs[name]
      act = Litter.parse(file:, config:)
      # debugger unless exp == act

      assert_equal exp, act,
        "Failed to parse this example: #{name}"
    end
  end
end
