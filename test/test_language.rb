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

  def test_to_s_returns_name_as_string
    assert_equal 'Klingon', @language.to_s
  end

  def test_comparison_is_ascending_by_iso639_3
    lang_a = ::Languages::Language.new(id: 'aaa', part2b: nil, part2t: nil, part1: nil,
                                       scope: 'I', language_type: 'L', ref_name: 'A')
    lang_b = ::Languages::Language.new(id: 'zzz', part2b: nil, part2t: nil, part1: nil,
                                       scope: 'I', language_type: 'L', ref_name: 'Z')

    assert_operator lang_a, :<, lang_b
  end

  def test_aliases
    assert_equal @language.iso639_3, @language.alpha3
    assert_equal @language.iso639_2t, @language.iso639_2
    assert_equal @language.iso639_2t, @language.alpha3_terminology
    assert_equal @language.iso639_2b, @language.alpha3_bibliographic
  end

  def test_alpha2_alias
    # The Klingon fixture has no ISO 639-1 code, so a real language with an alpha2 is needed.
    german = ::Languages[:deu]

    assert_equal german.iso639_1, german.alpha2
  end

  def test_equality_depends_on_iso639_3
    other_language = ::Languages::Language.new(id: 'tlh', part2b: nil, part2t: nil, part1: nil, scope: nil,
                                               language_type: nil, ref_name: nil)

    assert_equal @language, other_language
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
