//
//  UserDetailEntryPoint.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 17.01.22.
//

import Foundation

enum UserDetailEntryPoint {
    case author
    case photo
    
    var title: String {
        switch self {
        case .author: return "Author"
        case .photo: return "More Photo"
        }
    }
}
