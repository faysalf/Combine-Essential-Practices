//
//  Ext+String.swift
//  MoviesApp-UIKit
//
//  Created by Md. Faysal Ahmed on 6/4/25.
//

import Foundation

extension String {
    
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
}
