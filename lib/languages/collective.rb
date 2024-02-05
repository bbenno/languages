# frozen_string_literal: true

module Languages
  # Collective Language Code defined in ISO 639-5
  class Collective < Language
    # rubocop:disable Lint/MissingSuper
    def initialize(csv_attributes)
      @iso639_3 = nil
      @iso639_2b = csv_attributes['code']&.to_sym
      @iso639_2t = csv_attributes['code']&.to_sym
      @iso639_1 = nil
      @scope = :collective
      @type = :collective
      @name = csv_attributes['Label (English)']
    end
    # rubocop:enable Lint/MissingSuper
  end
end
