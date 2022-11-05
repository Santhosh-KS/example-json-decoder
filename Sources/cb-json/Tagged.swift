import Foundation

public struct Tagged<Tag, RawValue> {
  public var rawValue: RawValue
}

extension Tagged:Decodable where RawValue:Decodable {
  public init(from decoder: Decoder) throws {
    self.init(rawValue: try .init(from: decoder))
  }
}

extension Tagged:Equatable where RawValue:Equatable {
  public static func == (lhs: Tagged, rhs: Tagged) -> Bool {
    lhs.rawValue == rhs.rawValue
  }
}

extension Tagged: ExpressibleByUnicodeScalarLiteral where RawValue: ExpressibleByUnicodeScalarLiteral {
  public typealias UnicodeScalarLiteralType = RawValue.UnicodeScalarLiteralType
  
  public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
    self.init(rawValue: RawValue(unicodeScalarLiteral: value))
  }
}

extension Tagged: ExpressibleByExtendedGraphemeClusterLiteral where RawValue: ExpressibleByExtendedGraphemeClusterLiteral {
  public typealias ExtendedGraphemeClusterLiteralType = RawValue.ExtendedGraphemeClusterLiteralType
  
  public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
    self.init(rawValue: RawValue(extendedGraphemeClusterLiteral: value))
  }
}

extension Tagged:ExpressibleByStringLiteral where RawValue:ExpressibleByStringLiteral {
  public typealias StringLiteralType = RawValue.StringLiteralType
  
  public init(stringLiteral value: RawValue.StringLiteralType) {
    self.init(rawValue: RawValue(stringLiteral: value))
  }
}

extension Tagged:ExpressibleByIntegerLiteral where
RawValue:ExpressibleByIntegerLiteral {
  
  public typealias IntegerLiteralType = RawValue.IntegerLiteralType
  
  public init(integerLiteral value: RawValue.IntegerLiteralType) {
    self.init(rawValue: RawValue(integerLiteral: value))
  }
}
