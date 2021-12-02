// HapticsPerformer.swift
//
// Created by CypherPoet.
// ✌️
//
    
import Foundation
import CoreHaptics
import os


public final class HapticsPerformer {
    public typealias EngineResetHandler = (() async -> Void)
    public typealias PlayerFinishHandler = (() -> Void)
    
    public var engine: CHHapticEngine!
   
    public var abilities: Abilities {
        didSet {
            switch abilities {
            case .hapticsOnly:
                engine.playsHapticsOnly = true
            case .audioEnabled:
                engine.playsHapticsOnly = false
            }
        }
    }
    
    public var engineContinuity: EngineContinuity {
        didSet {
            switch engineContinuity {
            case .stopWhenPlayersFinish:
                engine.isAutoShutdownEnabled = true
            case .continueWhenPlayersFinish:
                engine.isAutoShutdownEnabled = false
            }
        }
    }
    
    public var engineState: EngineState
    
    
    /// A callback to be executed within the performer's ``engine`` `CHHapticEngine.ResetHandler`.
    public var onEngineReset: EngineResetHandler?
    
    
    /// A callback to be executed within the performer's ``engine`` `CHHapticEngine.FinishedHandler`.
    public var onPlayersFinished: PlayerFinishHandler?
    
    
    // MARK: - Init
    public init(
        abilities: Abilities = .hapticsOnly,
        engineContinuity: EngineContinuity = .stopWhenPlayersFinish,
        onEngineReset: EngineResetHandler? = nil,
        onPlayersFinished: PlayerFinishHandler? = nil
    ) {
        self.abilities = abilities
        self.engineContinuity = engineContinuity
        self.onEngineReset = onEngineReset
        self.onPlayersFinished = onPlayersFinished

        engineState = .uninitialized
    }
    
    
    private lazy var handlePlayersFinishing: CHHapticEngine.FinishedHandler = {
        { [weak self] possibleError in
            guard let self = self else { return .stopEngine }
            
            if let error = possibleError {
                Self.logger.error("⚠️⚠️⚠️ Player finished with error: \(error.localizedDescription)")
            } else {
                Self.logger.info("✅✅✅ Player finished successfully")
                
                self.engineState = .awaitingStart
                self.onPlayersFinished?()
            }
            
            return self.engineFinishAction
        }
    }()
    
    
    private lazy var handleEngineReset: CHHapticEngine.ResetHandler = {
        { [weak self] in
            guard let self = self else { return }
            
            Task {
                await self.onEngineReset?()
                
                try await self.startEngine()
            }
        }
    }()
}


// MARK: -  Engine Lifecycle Methods
extension HapticsPerformer {
    
    public func createHapticEngine() async throws {
        do {
            engine = try CHHapticEngine()
        } catch let hapticError {
            throw Error.engineCreationFailed(error: hapticError as! CHHapticError)
        }

        
        engine.isAutoShutdownEnabled = engineContinuity == .stopWhenPlayersFinish
        engine.playsHapticsOnly = abilities == .hapticsOnly
        
        engine.stoppedHandler = handleEngineStopFromExternalEvent(reason:)
        engine.resetHandler = handleEngineReset
        
        engineState = .awaitingStart
    }
    
    
    public func destroyHapticEngine() async throws {
        try await stopEngine()
        
        engine = nil
        engineState = .uninitialized
    }

    
    /// Call at the moment in which you want haptic events to play.
    private func startEngine() async throws {
        do {
            try await engine.start()
            engineState = .started
            
            engine.notifyWhenPlayersFinished(
                finishedHandler: handlePlayersFinishing
            )
        } catch {
            throw Error.engineStartFailed(error: error as! CHHapticError)
        }
    }
}


// MARK: -  Public Methods
extension HapticsPerformer {
    
    public func playFireAndForgetPattern(
        from fileURL: URL
    ) async throws {
        try await startEngineIfNecessary()

        do {
            try engine.playPattern(from: fileURL)
        } catch {
            throw Error.engineFailedToPlayPatternFromFile(
                fileURL: fileURL,
                error: error as! CHHapticError
            )
        }
    }
    
    
    public func playFireAndForgetPattern(
        from data: Data
    ) async throws {
        try await startEngineIfNecessary()

        do {
            try engine.playPattern(from: data)
        } catch {
            throw Error.engineFailedToPlayPatternFromData(
                data: data,
                error: error as! CHHapticError
            )
        }
    }

    
    public func start(
        player: CHHapticPatternPlayer,
        atTime time: TimeInterval = CHHapticTimeImmediate
    ) async throws {
        try await startEngineIfNecessary()
        
        try player.start(atTime: time)
    }

    
    public func pause(
        player: CHHapticAdvancedPatternPlayer,
        atTime time: TimeInterval = CHHapticTimeImmediate
    ) async throws {
        do {
            try player.pause(atTime: time)
        } catch {
            throw Error.playerFailedToPause(error: error)
        }
    }
    
    
    public func restart(
        playbackFor player: CHHapticPatternPlayer
    ) async throws {
        try await startEngineIfNecessary()
        
        try player.start(atTime: 0)
    }

  
    public func resume(
        playing player: CHHapticAdvancedPatternPlayer,
        atTime time: TimeInterval = CHHapticTimeImmediate
    ) async throws {
        try await startEngineIfNecessary()
        
        try player.resume(atTime: time)
    }

    
    public func stop(
        player: CHHapticAdvancedPatternPlayer,
        atTime time: TimeInterval = CHHapticTimeImmediate
    ) async throws {
        do {
            try player.stop(atTime: time)
        } catch {
            throw Error.playerFailedToStop(error: error)
        }
    }
    
    
    public func stopEngine() async throws {
        defer { engineState = .awaitingStart }
        
        do {
            try await engine.stop()
        } catch {
            throw Error.engineFailedToStop(
                error: error as! CHHapticError
            )
        }
    }
    
    
    public func makePlayer(
        with hapticPattern: CHHapticPattern
    ) throws -> CHHapticPatternPlayer {
        return try engine.makePlayer(with: hapticPattern)
    }
    
    
    public func makePlayer(
        with hapticPattern: CHHapticPattern
    ) throws -> CHHapticAdvancedPatternPlayer {
        try engine.makeAdvancedPlayer(with: hapticPattern)
    }
}


// MARK: -  Computeds
extension HapticsPerformer {
    
    private var engineFinishAction: CHHapticEngine.FinishedAction {
        switch engineContinuity {
        case .stopWhenPlayersFinish:
            return .stopEngine
        case .continueWhenPlayersFinish:
            return .leaveEngineRunning
        }
    }
}


// MARK: -  Private Helpers
extension HapticsPerformer {
    
    private func handleEngineStopFromExternalEvent(
        reason: CHHapticEngine.StoppedReason
    ) {
        Self.logger.notice(
            """
            The engine was stopped from an external event.
            Reason: \(reason.debugMessage)
            """
        )
        
        self.engineState = .awaitingStart
    }
    
    
    public func startEngineIfNecessary() async throws {
        switch engineState {
        case .uninitialized:
            try await createHapticEngine()
            try await startEngine()
        case .awaitingStart:
            try await startEngine()
        case .started:
            break
        }
    }
}


// MARK: -  Logger
extension HapticsPerformer {
    
    private static let logger = Logger(
        subsystem: Bundle.module.bundleIdentifier!,
        category: String(describing: HapticsPerformer.self)
    )
    
}
