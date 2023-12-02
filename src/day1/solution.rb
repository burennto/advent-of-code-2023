require 'minitest/autorun'

require_relative '../../lib/solution_base'

class SolutionTest < Minitest::Test
  def setup
    @solution = Day1::Solution.new
  end

  def test_sample_one
    assert_equal 142, @solution.sample_one
  end

  def test_sample_two
    assert_equal 281, @solution.sample_two
  end

  def test_part_one
    assert_equal 54630, @solution.part_one
  end

  def test_part_two
    assert_equal 54770, @solution.part_two
  end
end

module Day1
  class Solution < SolutionBase
    DIGITS = {
      '1' => '1',
      '2' => '2',
      '3' => '3',
      '4' => '4',
      '5' => '5',
      '6' => '6',
      '7' => '7',
      '8' => '8',
      '9' => '9',
      'one' => '1',
      'two' => '2',
      'three' => '3',
      'four' => '4',
      'five' => '5',
      'six' => '6',
      'seven' => '7',
      'eight' => '8',
      'nine' => '9',
    }

    def sample_one
      sample_input_one.split("\n").sum { |line| calibration_value_simple(line) }
    end

    def sample_two
      sample_input_two.split("\n").sum { |line| calibration_value_complex(line) }
    end

    def part_one
      actual_input.split("\n").sum { |line| calibration_value_simple(line) }
    end

    def part_two
      actual_input.split("\n").sum { |line| calibration_value_complex(line) }
    end

    private

    def calibration_value_simple(line)
      digits = normalize(line).chars

      "#{digits.first}#{digits.last}".to_i
    end

    def calibration_value_complex(line)
      first = first_digit(line)
      last = last_digit(line)

      "#{first}#{last}".to_i
    end

    def normalize(line)
      line.gsub(/\D+/, '')
    end

    def first_digit(line)
      occurrences = DIGITS.reduce({}) do |memo, (number_or_word, digit)|
        index = line.index(number_or_word)
        memo[index] = digit unless index.nil?
        memo
      end

      occurrences[occurrences.keys.min]
    end

    def last_digit(line)
      occurrences = DIGITS.reduce({}) do |memo, (number_or_word, digit)|
        index = line.rindex(number_or_word)
        memo[index] = digit unless index.nil?
        memo
      end

      occurrences[occurrences.keys.max]
    end
  end
end
