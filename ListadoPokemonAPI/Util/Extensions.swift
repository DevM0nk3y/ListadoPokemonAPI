//
//  Extensions.swift
//  ListadoPokemonAPI
//
//  Created by Abel Lazaro on 03/09/22.
//

import Foundation

extension String {
    
    var forSorting: String {
        let simple = folding(options: [.diacriticInsensitive], locale: nil)
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        return simple.components(separatedBy: nonAlphaNumeric).joined(separator: " ")
    }
    
    func lowercased() -> String {
        var str = String()
        for (i, c) in self.enumerated() {
            if i > 0 {
                str.append(c.lowercased())
            } else {
                str.append(c)
            }
        }
        return str
    }
    
}
