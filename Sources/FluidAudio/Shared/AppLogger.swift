import Foundation
import OSLog

/// Lightweight logger that writes to Unified Logging and, optionally, to console.
/// Use this instead of `OSLog.Logger` so CLI runs can surface logs without `print`.
public struct AppLogger: Sendable {
    /// Default subsystem for all loggers in FluidAudio.
    /// Keep this consistent; categories should vary per component.
    /// Note: Set this before creating any logger instances.
    nonisolated(unsafe) public static var defaultSubsystem: String = "com.fluidinference"

    public enum Level: Int, Sendable {
        case debug = 0
        case info
        case notice
        case warning
        case error
        case fault
    }

    private let osLogger: Logger
    private let subsystem: String
    private let category: String

    /// Designated initializer allowing a custom subsystem if needed.
    public init(subsystem: String, category: String) {
        self.osLogger = Logger(subsystem: subsystem, category: category)
        self.subsystem = subsystem
        self.category = category
    }

    /// Convenience initializer that uses the shared default subsystem.
    public init(category: String) {
        self.init(subsystem: AppLogger.defaultSubsystem, category: category)
    }

    // MARK: - Public API

    public func debug(_ message: String) {
        log(.debug, message)
    }

    public func info(_ message: String) {
        log(.info, message)
    }

    public func notice(_ message: String) {
        log(.notice, message)
    }

    public func warning(_ message: String) {
        log(.warning, message)
    }

    public func error(_ message: String) {
        log(.error, message)
    }

    public func fault(_ message: String) {
        log(.fault, message)
    }

    // Wander's private narration must never enter unified logging or stderr,
    // including word-level G2P failures and upstream error descriptions.
    // Keep the logger API so upstream updates remain straightforward.
    private func log(_ level: Level, _ message: String) {}
}
