//
//  Builder.swift
//  PokeApp
//
//  Created by Intellisys on 23/2/21.
//

import Foundation

protocol Builder: AnyObject {
    associatedtype TypeBuilder
    var object: TypeBuilder! { get set }
    func build() -> TypeBuilder
}
