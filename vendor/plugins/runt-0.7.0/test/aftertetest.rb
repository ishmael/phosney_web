#!/usr/bin/env ruby

require 'baseexpressiontest'

# Unit tests for AfterTE class
# Author:: Matthew Lipper

class AfterTETest < BaseExpressionTest

  include TExpr

  def test_include_inclusive
    expr = AfterTE.new(@pdate_20071030, true)
    assert !expr.include?(@date_20050101), "Should not include an earlier date"
    assert expr.include?(@pdate_20071114), "Should include a later date"
    assert expr.include?(@pdate_20071030), "Should include the same date"
  end

  def test_include_non_inclusive
    expr = AfterTE.new(@pdate_20071030)
    assert !expr.include?(@date_20050101), "Should not include an earlier date"
    assert expr.include?(@pdate_20071114), "Should include a later date"
    assert !expr.include?(@pdate_20071030), "Should not include the same date"
  end

  def test_to_s
    expr = AfterTE.new(@pdate_20071114)
    assert_equal "after #{Runt.format_date(@pdate_20071114)}", expr.to_s
  end

end
