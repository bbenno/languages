# frozen_string_literal: true

module Languages
  # Language family or group defined in ISO 639-5
  class LanguageFamily
    include Comparable

    attr_reader :iso639_5, :name, :name_fr

    alias alpha3 iso639_5

    def initialize(csv_attributes)
      @iso639_5 = csv_attributes.fetch(:code).to_sym
      @name = csv_attributes.fetch(:name)
      @name_fr = csv_attributes.fetch(:name_fr)
    end

    def to_s
      name.to_s
    end

    def ==(other)
      other.class == self.class && other.iso639_5 == iso639_5
    end

    alias eql? ==

    def hash
      iso639_5.hash
    end

    def <=>(other)
      iso639_5 <=> other.iso639_5
    end
  end
end
