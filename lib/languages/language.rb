# frozen_string_literal: true

module Languages
  # Language defined in ISO 639-3
  class Language
    include Comparable

    attr_reader :iso639_1, :iso639_2b, :iso639_2t, :iso639_3, :scope, :type, :name, :macrolanguage # , :comment

    def initialize(csv_attributes) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
      @iso639_3 = csv_attributes.fetch(:id).to_sym
      @iso639_2b = csv_attributes.fetch(:part2b)&.to_sym
      @iso639_2t = csv_attributes.fetch(:part2t)&.to_sym
      @iso639_1 = csv_attributes.fetch(:part1)&.to_sym
      @scope = SCOPES.detect { |s| s.chr.upcase == csv_attributes.fetch(:scope) }&.to_sym
      @type = TYPES.detect { |t| t.chr.upcase == csv_attributes.fetch(:language_type) }&.to_sym
      @name = csv_attributes.fetch(:ref_name)
      # @comment = csv_attributes.fetch(:comment)
    end

    alias iso639_2 iso639_2t
    alias iso639_5 iso639_2

    alias alpha2 iso639_1
    alias alpha3_bibliographic iso639_2b
    alias alpha3_terminology iso639_2t

    def to_s
      name.to_s # Enforce return of String, even if name is nil
    end

    TYPES.each do |type|
      define_method "#{type}?" do
        self.type == type.to_sym
      end
    end

    SCOPES.each do |scope|
      # prevent ambiguity of scope "special" and type "special"
      method_name = scope.end_with?('language') ? scope : "#{scope}_language"

      define_method "#{method_name}?" do
        self.scope == scope.to_sym
      end
    end

    def ==(other)
      other.class == self.class && other.iso639_3 == iso639_3
    end

    alias eql? ==

    def hash
      iso639_3.hash
    end

    def <=>(other)
      other.iso639_3 <=> iso639_3
    end

    def alpha3
      iso639_3 || iso639_2t || iso639_2b
    end
  end
end
