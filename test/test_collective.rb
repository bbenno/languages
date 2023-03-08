# frozen_string_literal: true

require 'test_helper'

class TestCollective < Minitest::Test
  def setup
    @collective = ::Languages::Collective.new({
                                                'code' => 'nah',
                                                'Label (English)' => 'Nahuatl languages'
                                              })
  end

  def test_that_it_has_a_name
    assert_instance_of String, @collective.name
    assert_equal 'Nahuatl languages', @collective.name
  end

  def test_that_it_has_no_alpha2
    assert_nil @collective.alpha2
  end

  def test_it_has_alpha3_bibliographic
    assert_equal :nah, @collective.alpha3_bibliographic
  end

  def test_it_has_collective_type
    assert_equal :collective, @collective.type
  end

  def test_it_has_collective_scope
    assert_equal :collective, @collective.scope
  end
end
