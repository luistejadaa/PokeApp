//
//  QueryFilter.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

import Foundation

struct QueryFilter {
    let field: String
    let value: String
    let filterType: FilterType
}

enum FilterType {
    case equalTo
}
