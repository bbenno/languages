# frozen_string_literal: true

require 'test_helper'

class TestLanguageFamily < Minitest::Test
  def setup
    @family = ::Languages::LanguageFamily.new(code: 'ine', name: 'Indo-European languages',
                                              name_fr: 'indo-européennes, langues')
  end

  def test_iso639_5_is_symbol
    assert_instance_of Symbol, @family.iso639_5
  end

  def test_alpha3_alias
    assert_equal @family.iso639_5, @family.alpha3
  end

  def test_name_is_string
    assert_instance_of String, @family.name
  end

  def test_name_fr_is_string
    assert_instance_of String, @family.name_fr
  end

  def test_to_s_returns_name
    assert_equal 'Indo-European languages', @family.to_s
  end

  def test_equality_depends_on_iso639_5
    other = ::Languages::LanguageFamily.new(code: 'ine', name: 'Other name', name_fr: 'autre nom')

    assert_equal @family, other
  end

  def test_comparison_is_ascending_by_iso639_5
    family_a = ::Languages::LanguageFamily.new(code: 'aav', name: 'A', name_fr: 'A')
    family_z = ::Languages::LanguageFamily.new(code: 'zzz', name: 'Z', name_fr: 'Z')

    assert_operator family_a, :<, family_z
  end

  def test_language_families_returns_array
    assert_kind_of Array, ::Languages.language_families
  end

  def test_language_families_contains_language_family_instances
    assert_instance_of ::Languages::LanguageFamily, ::Languages.language_families.first
  end

  def test_language_families_count
    assert_equal 115, ::Languages.language_families.size
  end

  def test_all_families_have_names
    assert(::Languages.language_families.all? { |f| !f.name.nil? && !f.name.empty? })
  end

  def test_all_families_have_french_names
    assert(::Languages.language_families.all? { |f| !f.name_fr.nil? && !f.name_fr.empty? })
  end

  def test_all_families_have_alpha3_code
    assert(::Languages.language_families.all? { |f| f.iso639_5.length == 3 })
  end

  def test_lookup_by_iso639_5_code
    mayan = ::Languages[:myn]

    assert_instance_of ::Languages::LanguageFamily, mayan
    assert_equal 'Mayan languages', mayan.name
  end
end
