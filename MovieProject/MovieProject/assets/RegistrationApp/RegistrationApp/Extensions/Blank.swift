//
//  File.swift
//  RegistrationApp
//
//  Created by asmaaashraf on 7/10/19.
//  Copyright © 2019 ThirdDoploma. All rights reserved.
//

import Foundation
extension String {
    var isBlank: Bool {
        return self == nil || self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
   
    }
}
