# frozen_string_literal: true

require 'test_helper'

class TestLanguages < Minitest::Test
  def setup
    @search_pattern = /Germ/
  end

  def test_that_it_has_a_version_number
    refute_nil ::Languages::VERSION
  end

  ::Languages::TYPES.each do |type|
    define_method "test_it_provides_scope_for_type_#{type}" do
      languages = nil

      Gem::Deprecate.skip_during do
        languages = ::Languages.public_send(type)
      end

      assert_kind_of Enumerable, languages

      # Skip object type validation for ancient languages.
      # As of 2024-11-21 there are no ancient languages present
      # and therefore we would check whether NilClass is instance of Language.
      #
      # See also:
      # https://iso639-3.sil.org/code_tables/639/data?field_iso639_cd_st_mmbrshp_639_1_tid=94671&field_iso639_language_type_tid=31
      return if type == 'ancient'

      assert_instance_of ::Languages::Language, languages.first
    end
  end

  def test_deprecation_warning_for_type_ancient
    assert_output(/.*/, /ancient is deprecated/) { ::Languages.ancient }
  end

  ::Languages::SCOPES.each do |scope|
    define_method "test_it_provides_scope_for_scope_#{scope}" do
      method_name = "#{scope}_language" unless scope.end_with? 'language'
      languages = ::Languages.public_send("#{method_name || scope}s")

      assert_kind_of Enumerable, languages
      assert_instance_of ::Languages::Language, languages.first
    end
  end

  def test_all_alpha2_codes_have_string_length_2
    assert(::Languages.all.map(&:alpha2).compact.all? { |a| a.size == 2 })
  end

  def test_all_alpha3_codes_have_string_length_3
    assert(::Languages.all.map(&:alpha3).compact.all? { |a| a.size == 3 })
  end

  def test_all_languages_have_a_type
    refute(::Languages.all.map(&:type).any?(&:nil?))
  end

  def test_all_languages_have_a_name
    refute(::Languages.all.map(&:name).any? { |n| n.nil? || n.empty? })
  end

  def test_all_languages_have_a_alpha3
    refute(::Languages.all.map(&:alpha3).any?(&:nil?))
  end

  %i[iso639_1 iso639_2b iso639_2t iso639_3 name].each do |attr|
    define_method "test_attribute_#{attr}_is_unique" do
      assert_nil(::Languages.all.map(&:"#{attr}").compact.tally.detect { |_, c| c > 1 })
    end
  end

  def test_single_language_lookup_key_can_be_string_or_symbol
    %i[de deu German].each do |key|
      assert_equal(::Languages[key], ::Languages[key.to_s])
    end
  end

  def test_single_language_lookup_returns_nil_if_not_found
    assert_nil(::Languages[:invalid])
  end

  def test_single_language_lookup_key_is_case_insensitive
    %w[de deu German].each do |key|
      assert_equal(::Languages[key], ::Languages[key.upcase])
    end
  end

  def test_search_provides_enumerable
    assert_kind_of Enumerable, ::Languages.search(@search_pattern)
  end

  def test_search_with_string_pattern_fails
    pattern = @search_pattern.source

    assert_raises(ArgumentError) { ::Languages.search(pattern) }
  end

  def test_search_with_regex_pattern
    pattern = /\AG[ea]/
    search_result = ::Languages.search(pattern)

    assert(search_result.map(&:name).all? { |n| n.match?(pattern) })
    refute((Languages.all - search_result).map(&:name).any? { |n| n.match?(pattern) })
  end

  def test_search_can_be_case_insensitive
    case_sensitive_pattern = /tib/
    case_insensitive_pattern = Regexp.new(case_sensitive_pattern.source, Regexp::IGNORECASE)

    case_sensitive_result = ::Languages.search(case_sensitive_pattern)
    case_insensitive_search_result = ::Languages.search(case_insensitive_pattern)

    # case sensitive result only contains "Celtiberian"
    # case insensitive result additionaly contains "Tibet"
    refute_equal(case_insensitive_search_result, case_sensitive_result)
  end

  def test_reference_to_macrolanguage
    language = ::Languages[:wuu]

    refute_nil(language.macrolanguage)
  end

  def test_macrolanguages_have_no_macrolanguage
    macrolanguages = ::Languages.macrolanguages

    assert_empty(macrolanguages.reject { |l| l.macrolanguage.nil? })
  end
end
