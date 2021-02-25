//
//  Codable+Extension.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

import Foundation

extension Encodable {
  var dictionary: [String: AnyObject]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: AnyObject] }
  }
}
