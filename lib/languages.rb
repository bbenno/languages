# frozen_string_literal: true

require 'csv'

require_relative 'languages/version'
require_relative 'languages/constants'
require_relative 'languages/language'

# Provides living, extinct, ancient, historic, and constructed languages, specified in ISO 639-3
module Languages
  @@data = CSV.read(File.join(File.dirname(__FILE__), '../data/iso-639-3.tsv'), headers: true, col_sep: "\t") # rubocop:disable Style/ClassVars
              .map { |row| row.to_h.transform_keys { |k| k.downcase.to_sym } }
              .map { |h| Language.new(h) }
              .freeze

  class << self
    TYPES.each do |type|
      define_method type do
        @@data.select { |l| l.public_send("#{type}?") }
      end
    end

    SCOPES.each do |scope|
      # prevent ambiguity of scope "special" and type "special"
      scope = "#{scope}_language" unless scope.end_with? 'language'

      define_method "#{scope}s" do
        @@data.select { |l| l.public_send("#{scope}?") }
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
      @@data.select { |l| l.name.match? pattern }
    end

    # Returns all human known languages, specified in ISO 639-3
    def all
      @@data
    end

    def names
      @@data.map(&:name)
    end

    def alpha2_codes
      @@data.map(&:alpha2).compact
    end

    def alpha3_codes
      @@data.map(&:alpha3)
    end

    private

    # Returns language associated with ISO 639-1 identifier
    # @param [Symbol] key ISO 639-1 identifier
    # @return [Language,NilClass] language with associated with the identifier; otherwise +nil+
    def get_by_alpha2(key)
      @@data.detect { |l| l.iso639_1 == key }
    end

    # Returns language associated with ISO 639-2 or ISO 639-3 identifier
    # @param [Symbol] key ISO 639-2 or ISO 639-3 identifier
    # @return [Language,NilClass] language with associated with the identifier; otherwise +nil+
    def get_by_alpha3(key)
      @@data.detect { |l| l.iso639_3 == key || l.iso639_2b == key || l.iso639_2t == key }
    end

    # Returns language associated with ISO 639-3 reference name
    # @param [String] name reference name (english)
    # @return [Language,NilClass] language with associated with the name; otherwise +nil+
    def get_by_name(name)
      @@data.detect { |l| l.name.downcase == name.downcase }
    end
  end
end
