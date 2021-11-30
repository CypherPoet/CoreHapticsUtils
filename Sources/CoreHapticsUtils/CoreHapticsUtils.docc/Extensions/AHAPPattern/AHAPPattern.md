# ``CoreHapticsUtils/AHAPPattern``

A `Codable` type that wraps the data description of the
[Apple Haptic and Audio Pattern (AHAP) file format](https://developer.apple.com/documentation/corehaptics/representing_haptic_patterns_in_ahap_files).


An AHAP file doesn’t need an entry for every key.

When Core Haptics loads an AHAP file, it sets missing
entries to their default value and clamps out-of-range values to
their minimum or maximum values, whichever is closer.

Furthermore, the framework ignores unsupported keys.


## Overview


## Topics

### Essentials

- ``CoreHapticsUtils/AHAPPattern/PatternElement``


### Event Parameters

- ``CoreHapticsUtils/AHAPPattern/EventParameterID``
- ``CoreHapticsUtils/AHAPPattern/DynamicParameterID``
