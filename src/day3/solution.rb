require 'minitest/autorun'

require_relative '../../lib/solution_base'

class SolutionTest < Minitest::Test
  def setup
    @solution = Day3::Solution.new
  end

  def test_sample_one
    # assert_equal 4361, @solution.sample_one
  end

def test_sample_two
    # assert_equal 467835, @solution.sample_two
  end

  def test_part_one
    # assert_equal 512794, @solution.part_one
  end

  def test_part_two
    assert_equal 67779080, @solution.part_two
  end
end

module Day3
  class Solution < SolutionBase
    def sample_one
      EngineSchematic.new(sample_input_one).part_numbers.sum
    end

    def sample_two
      EngineSchematic.new(sample_input_two)
        .gears
        .values.select { |numbers| numbers.size > 1 }
        .map { |numbers| numbers.reduce(&:*) }
        .sum
    end

    def part_one
      EngineSchematic.new(actual_input).part_numbers.sum
    end

    def part_two
      EngineSchematic.new(actual_input)
        .gears
        .values.select { |numbers| numbers.size > 1 }
        .map { |numbers| numbers.reduce(&:*) }
        .sum
    end
  end

  class EngineSchematic
    attr_reader :width, :input

    def initialize(input)
      @width = input.split("\n").first.length
      @input = input.gsub("\n", '')
    end

    def part_numbers
      current_num = ''
      surrounding_chars = []

      input.chars.each_with_index.inject([]) do |memo, (char, index)|
        if char =~ /\d/
          current_num << char

          unless (index % width) == 0
            surrounding_chars << input.chars[index-width-1]  # top left
            surrounding_chars << input.chars[index-1]        # left
            surrounding_chars << input.chars[index+width-1]  # bottom left
          end

          unless (index % width) == width - 1
            surrounding_chars << input.chars[index-width+1]  # top right
            surrounding_chars << input.chars[index+1]        # right
            surrounding_chars << input.chars[index+width+1]  # bottom right
          end

          surrounding_chars << input.chars[index-width]    # top
          surrounding_chars << input.chars[index+width]    # bottom
        else
          memo << current_num.to_i if surrounding_chars.compact.any? { |c| c !~ /[\.\d]/ }

          current_num = ''
          surrounding_chars = []
        end
        memo
      end
    end

    def gears
      current_num = ''
      gear_index = nil

      input.chars.each_with_index.inject({}) do |memo, (char, index)|
        if char =~ /\d/
          current_num << char

          if (index % width) > 0
            gear_index = index-width-1 if input.chars[index-width-1] == '*' # top left
            gear_index = index-1       if input.chars[index-1]       == '*' # left
            gear_index = index+width-1 if input.chars[index+width-1] == '*' # bottom left
          end

          if (index % width) < width-1
            gear_index = index-width+1 if input.chars[index-width+1] == '*' # top right
            gear_index = index+1       if input.chars[index+1]       == '*' # right
            gear_index = index+width+1 if input.chars[index+width+1] == '*' # bottom right
          end

          gear_index = index-width if input.chars[index-width] == '*'       # top
          gear_index = index+width if input.chars[index+width] == '*'       # bottom
        else
          if gear_index
            memo[gear_index] = [] if memo[gear_index].nil?
            memo[gear_index] << current_num.to_i
          end
          current_num = ''
          gear_index = nil
        end

        memo
      end
    end
  end
end
