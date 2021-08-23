//
//  Session.swift
//  VKClone
//
//  Created by Vlad on 23.08.2021.
//

import Foundation
class Session {
    static let instance = Session()
    private init(){}
    var token = ""
    var userID : Int = 0
}
