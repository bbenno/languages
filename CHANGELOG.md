# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.9.1] - 2024-11-21

### Fixed

- Changelog structure

## [0.9.0] - 2024-11-21

### Changed

- Update ISO 639 data incorporating approved changes of [2023 series](https://iso639-3.sil.org/sites/iso639-3/files/reports/2023%20Summary%20of%20Outcomes.pdf), [2024 Quarter 2](https://iso639-3.sil.org/sites/iso639-3/files/reports/2024%20Quarter%202%20639%20MA%20newsletter.pdf), and [2024 Quater 3](https://iso639-3.sil.org/sites/iso639-3/files/reports/2024%20Quarter%203%20639%20MA%20newsletter.pdf)
- Interface of `Languages.search` changed. See <https://github.com/bbenno/languages/pull/123> for more details.
  - Argument `case_sensitive` has been removed.
  - Argument `pattern` can no longer be String. Its type has to be `Regexp`

### Deprecated

- Deprecate `Languages.ancient` as this "type of individual languages" has been removed by the maintenance agency and (probably) merged with extinct type.

### Removed

- Support for Ruby v2.7
- Support for Ruby v3.0

## [0.8.0] - 2024-02-05

### Added

- Support / Tests for Ruby 3.3 (thanks to [@sandbergja](https://github.com/sandbergja))

## [0.7.0] - 2023-03-08

### Added

- Add `macrolanguage` reference for languages of scope `individual` that belong to a macrolanguage.
- Add overview table in README about related and similar gems.
- Add option to search language by name case insensitively.

### Fixed

- Installation instruction in README: wrong gem name, correct is `human_languages`

### Changed

- Update ISO 639 data incorporating approved [2022 changes](https://iso639-3.sil.org/sites/iso639-3/files/reports/639-3_ChangeRequests_2022_Summary.pdf).

## [0.6.0] - 2022-06-08

### Changed

- Name of gem `languages` -> `human_languages`
- Language's attribute `scope` is now a Symbol (previously String)
- Language's attribute `type` is now a Symbol (previously String)

## [0.5.0] - 2022-06-06

### Changed

- Single language lookup via `Languages[...]` is now case insensitive
- Extend README
- Repository is no REUSE compliant

## [0.4.0] - 2022-06-04

### Added

- `Languages.names` interface, providing all reference names
- `Languages.alpha2_codes` interface, providing all ISO 639-1 codes
- `Languages.alpha3_codes` interface, providing all ISO 639-3 codes

## [0.3.0] - 2022-06-04

### Added

- `Languages.search` interface, taking String or Regex pattern

## [0.2.0] - 2022-06-04

### Added

- Make Language objects comparable

### Changed

- Equality of Language objects only depends on their `iso639-3` attribute, that is unique

## [0.1.2] - 2022-06-04

### Changed

- Extend ruby signatures
- Setting `:id` aka. `iso639-3` to `nil` is no longer possible (was never intended)

### Fix

- ruby signatures

## [0.1.1] - 2022-06-04

### Changed

- Extend doc comments for Language's private methods

### Fixes

- Language's compare method `<=>`

## [0.1.0] - 2022-06-04

- Initial release
