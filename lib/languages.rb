# frozen_string_literal: true

require 'csv'

require_relative 'languages/version'
require_relative 'languages/constants'
require_relative 'languages/language'

# Provides living, extinct, ancient, historic, and constructed languages, specified in ISO 639-3
module Languages
  class << self
    TYPES.each do |type|
      define_method type do
        all.select { |l| l.public_send("#{type}?") }
      end
    end

    extend Gem::Deprecate
    deprecate :ancient, :none, 2025, 3

    SCOPES.each do |scope|
      # prevent ambiguity of scope "special" and type "special"
      scope = "#{scope}_language" unless scope.end_with? 'language'

      define_method "#{scope}s" do
        all.select { |l| l.public_send("#{scope}?") }
      end
    end

    def [](key)
      key = key.to_s.downcase
      case key.size
      when 3 then get_by_alpha3(key.to_sym)
      when 2 then get_by_alpha2(key.to_sym)
      else get_by_name(key)
      end
    end

    def search(pattern)
      raise(ArgumentError, 'Pattern must be a Regexp') unless pattern.is_a?(Regexp)

      all.select { |l| l.name.match? pattern }
    end

    # Returns all human known languages, specified in ISO 639-3
    def all
      data.values
    end

    def names
      all.map(&:name)
    end

    def alpha2_codes
      all.map(&:alpha2).compact
    end

    def alpha3_codes
      all.map(&:alpha3)
    end

    private

    # Returns language associated with ISO 639-1 identifier
    # @param [Symbol] key ISO 639-1 identifier
    # @return [Language,NilClass] language with associated with the identifier; otherwise +nil+
    def get_by_alpha2(key)
      all.detect { |l| l.iso639_1 == key }
    end

    # Returns language associated with ISO 639-2 or ISO 639-3 identifier
    # @param [Symbol] key ISO 639-2 or ISO 639-3 identifier
    # @return [Language,NilClass] language with associated with the identifier; otherwise +nil+
    def get_by_alpha3(key)
      data[key] || all.detect { |l| l.iso639_2b == key || l.iso639_2t == key }
    end

    # Returns language associated with ISO 639-3 reference name
    # @param [String] name reference name (english)
    # @return [Language,NilClass] language with associated with the name; otherwise +nil+
    def get_by_name(name)
      all.detect { |l| l.name.downcase == name.downcase }
    end

    private # rubocop:disable Lint/UselessAccessModifier

    def data
      @@data
    end

    def load_tsv_data(filename)
      CSV.read(File.join(File.dirname(__FILE__), "../data/#{filename}"), headers: true, col_sep: "\t")
    end
  end

  @@data = load_tsv_data('iso-639-3.tsv') # rubocop:disable Style/ClassVars
           .map { |row| row.to_h.transform_keys { |k| k.downcase.to_sym } }
           .each_with_object({}) { |l, h| h[l[:id].to_sym] = Language.new(l) }
           .freeze

  load_tsv_data('iso-639-3-macrolanguages.tsv')
    # Ignore deprecated mappings (i.e. row[2] = 'R')
    .each { |row| data[row[1].to_sym].instance_variable_set(:@macrolanguage, data[row[0].to_sym]) if row[2] == 'A' }
end
