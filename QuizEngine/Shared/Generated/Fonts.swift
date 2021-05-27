// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSFont
  internal typealias Font = NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
  internal typealias Font = UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum Fonts {

  // MARK: - System font
  internal enum SFUIDisplay {
    internal static let ultraLight = SystemFontConvertible(weight: .ultraLight)
    internal static let thin = SystemFontConvertible(weight: .thin)
    internal static let light = SystemFontConvertible(weight: .light)
    internal static let regular = SystemFontConvertible(weight: .regular)
    internal static let medium = SystemFontConvertible(weight: .medium)
    internal static let semibold = SystemFontConvertible(weight: .semibold)
    internal static let bold = SystemFontConvertible(weight: .bold)
    internal static let heavy = SystemFontConvertible(weight: .heavy)
    internal static let black = SystemFontConvertible(weight: .black)
  }

  // No fonts found
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct SystemFontConvertible {
  internal let weight: UIFont.Weight

  internal init(weight: UIFont.Weight) {
    self.weight = weight
  }

  internal func font(size: CGFloat) -> Font! {
    return UIFont.systemFont(ofSize: size, weight: weight)
  }
}

