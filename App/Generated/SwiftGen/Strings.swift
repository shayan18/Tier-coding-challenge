// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Vehicle {
    internal enum Request {
      /// Something went wrong, please check your internet connection
      internal static let error = L10n.tr("Localizable", "Vehicle.request.error")
      /// Vehicles fetched successfully
      internal static let success = L10n.tr("Localizable", "Vehicle.request.success")
    }
  }

  internal enum Global {
    internal enum Action {
      /// Add
      internal static let add = L10n.tr("Localizable", "global.action.add")
      /// Cancel
      internal static let cancel = L10n.tr("Localizable", "global.action.cancel")
      /// OK
      internal static let confirm = L10n.tr("Localizable", "global.action.confirm")
      /// Delete
      internal static let delete = L10n.tr("Localizable", "global.action.delete")
      /// Done
      internal static let done = L10n.tr("Localizable", "global.action.done")
      /// Login
      internal static let login = L10n.tr("Localizable", "global.action.login")
      /// Logout
      internal static let logout = L10n.tr("Localizable", "global.action.logout")
      /// No
      internal static let no = L10n.tr("Localizable", "global.action.no")
      /// Got it!
      internal static let understood = L10n.tr("Localizable", "global.action.understood")
      /// Yes
      internal static let yes = L10n.tr("Localizable", "global.action.yes")
    }
    internal enum Title {
      /// Error
      internal static let error = L10n.tr("Localizable", "global.title.error")
      /// Password
      internal static let password = L10n.tr("Localizable", "global.title.password")
      /// Success
      internal static let success = L10n.tr("Localizable", "global.title.success")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
