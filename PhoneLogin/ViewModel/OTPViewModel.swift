//
//  OTPViewModel.swift
//  PhoneLogin
//
//  Created by 大和田一裕 on 2022/08/01.
//

import SwiftUI

class OTPViewModel: ObservableObject {
    @Published var otpText: String = ""
    @Published var otpFields: [String] = Array(repeating: "", count: 6)
}
