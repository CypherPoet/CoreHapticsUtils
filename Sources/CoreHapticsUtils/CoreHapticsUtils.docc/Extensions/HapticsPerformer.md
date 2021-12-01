# ``CoreHapticsUtils/HapticsPerformer``

A type that controls methods for playing Core Haptics patterns and calling methods on `CHHapticPlayer` instances.

## Overview

<!--@START_MENU_TOKEN@-->Text<!--@END_MENU_TOKEN@-->

## Topics


### Configuring Performer Abilities

- ``Abilities-swift.enum``

### Configuring Engine Continuity

- ``EngineContinuity-swift.enum``

### Handling Engine Reset Events

- ``onEngineReset``

### Handling Engine Player Finish Events

- ``onPlayersFinished``

### Creating Players

- ``makePlayer(with:)-5kdjr``
- ``makePlayer(with:)-4l3zn``

### Playing Haptic Patterns

Methods that control haptic playback rely on callers passing in an instance of `CHHapticPatternPlayer` or `CHHapticAdvancedPatternPlayer`.

- ``start(player:atTime:)``  
- ``pause(player:atTime:)``
- ``resume(playing:atTime:)``
- ``restart(playbackFor:)``
- ``stop(player:atTime:)``

