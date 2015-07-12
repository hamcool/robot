require 'minitest/autorun'
require_relative 'table'

class RobotTest < Minitest::Test

  def setup
    @table = Table.new
  end

  def test_table_valid_moves
    # check can move north if not going past edge
    assert @table.validMove(0,1,"N",1), "fail in bounds moving north"
    # check is out of bounds if move north over edge
    assert !@table.validMove(0,0,"N",1), "fail out of bounds moving north"
    # check can move west if not going past edge
    assert @table.validMove(1,0,"W",1), "fail in bounds moving west"
    # check can move north if not going past edge
    assert !@table.validMove(0,0,"W",1), "fail out of bounds moving west"
    # check can move south if not going past edge
    assert @table.validMove(0,0,"S",1), "fail in bounds moving south"
    # check is out of bounds if move south over edge
    assert !@table.validMove(0,4,"S",1), "fail out of bounds moving south"
    # check can move east if not going past edge
    assert @table.validMove(0,0,"E",1), "fail in bounds moving east"
    # check is out of bounds if move east past edge
    assert !@table.validMove(4,0,"E",1), "fail out of bounds moving east"
  end
end