# frozen_string_literal: true

require 'test_helper'

class TestLanguage < Minitest::Test
  def setup
    @language = ::Languages::Language.new({
                                            id: 'tlh',
                                            part2b: 'tlh',
                                            part2t: 'tlh',
                                            part1: nil,
                                            scope: 'I',
                                            language_type: 'C',
                                            ref_name: 'Klingon'
                                          })
  end

  def test_that_it_has_a_name
    assert_instance_of String, @language.name
  end

  ::Languages::TYPES.each do |type|
    define_method "test_that_respond_to_#{type}?" do
      assert_respond_to @language, "#{type}?"
    end

    define_method "test_that_#{type}?_returns_boolean" do
      result = @language.public_send("#{type}?")

      assert(result.is_a?(TrueClass) || result.is_a?(FalseClass))
    end
  end

  ::Languages::SCOPES.each do |scope|
    method_name = scope.end_with?('language') ? scope : "#{scope}_language"

    define_method "test_that_respond_to_#{method_name}?" do
      assert_respond_to @language, "#{method_name}?"
    end

    define_method "test_that_#{method_name}?_returns_boolean" do
      result = @language.public_send("#{method_name}?")

      assert(result.is_a?(TrueClass) || result.is_a?(FalseClass))
    end
  end
end
