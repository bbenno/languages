# frozen_string_literal: true

require 'test_helper'

class TestLanguages < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Languages::VERSION
  end

  ::Languages::TYPES.each do |type|
    define_method "test_it_provides_languages_of_type_#{type}" do
      languages = ::Languages.public_send(type)

      assert_kind_of Enumerable, languages
      assert_instance_of ::Languages::Language, languages.first
    end
  end

  ::Languages::SCOPES.each do |scope|
    define_method "test_it_provides_languages_of_scope_#{scope}" do
      methodname = "#{scope}_language" unless scope.end_with? 'language'
      languages = ::Languages.public_send("#{methodname || scope}s")

      assert_kind_of Enumerable, languages
      assert_instance_of ::Languages::Language, languages.first
    end
  end

  def test_alpha2_has_string_length_2
    assert(::Languages.all.map(&:alpha2).compact.all? { |a| a.size == 2 })
  end

  def test_alpha3_has_string_length_2
    assert(::Languages.all.map(&:alpha3).compact.all? { |a| a.size == 3 })
  end

  %i[iso639_1 iso639_2b iso639_2t iso639_3 name].each do |attr|
    define_method "test_#{attr}_is_unique" do
      assert_nil(::Languages.all.map(&:"#{attr}").compact.tally.detect { |_, c| c > 1 })
    end
  end
end
