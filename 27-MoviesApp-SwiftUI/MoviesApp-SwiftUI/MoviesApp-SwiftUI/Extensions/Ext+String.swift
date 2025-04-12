//
//  Ext+String.swift
//  MoviesApp-SwiftUI
//
//  Created by Md. Faysal Ahmed on 13/4/25.
//

import Foundation

extension String {
    
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
}
