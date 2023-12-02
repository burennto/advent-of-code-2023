require 'minitest/autorun'

require_relative '../../lib/solution_base'

class SolutionTest < Minitest::Test
  def setup
    @solution = Day2::Solution.new
  end

  def test_sample_one
    assert_equal 8, @solution.sample_one
  end

  def test_sample_two
    assert_equal 2286, @solution.sample_two
  end

  def test_part_one
    assert_equal 2439, @solution.part_one
  end

  def test_part_two
    assert_equal 63711, @solution.part_two
  end
end

module Day2
  class Solution < SolutionBase
    def sample_one
      sample_input_one.split("\n").sum do |line|
        game = Game.new(line)
        game.possible? ? game.id : 0
      end
    end

    def sample_two
      sample_input_two.split("\n").sum do |line|
        game = Game.new(line)
        game.minimum_cubes.values.reduce(&:*)
      end
    end

    def part_one
      actual_input.split("\n").sum do |line|
        game = Game.new(line)
        game.possible? ? game.id : 0
      end
    end

    def part_two
      actual_input.split("\n").sum do |line|
        game = Game.new(line)
        game.minimum_cubes.values.reduce(&:*)
      end
    end
  end

  class Game
    PATTERN_ID = /^Game\s(?<id>\d+)/
    PATTERN_SETS = /^Game \d+: (?<sets>.*)/

    CUBES_RED = 12
    CUBES_GREEN = 13
    CUBES_BLUE = 14

    attr_reader :line, :bag

    def initialize(line)
      @line = line
    end

    def id
      line.match(PATTERN_ID)[:id].to_i
    end

    def sets
      line.match(PATTERN_SETS)[:sets].split(';').map(&:strip)
    end

    def moves(set)
      set.split(',').map(&:strip)
    end

    def possible?
      sets.each do |set|
        bag = { red: CUBES_RED, green: CUBES_GREEN, blue: CUBES_BLUE, }

        moves(set).each do |move|
          count, color = move.split(' ')
          bag[color.to_sym] -= count.to_i
          return false if bag[color.to_sym] < 0
        end
      end

      true
    end

    def minimum_cubes
      bag = { red: 0, green: 0, blue: 0, }

      sets.each do |set|
        moves(set).each do |move|
          count, color = move.split(' ')
          bag[color.to_sym] = count.to_i if count.to_i > bag[color.to_sym]
        end
      end

      bag
    end
  end
end
