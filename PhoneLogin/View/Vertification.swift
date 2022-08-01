//
//  Vertification.swift
//  PhoneLogin
//
//  Created by 大和田一裕 on 2022/08/01.
//

import SwiftUI

struct Vertification: View {
    
    @StateObject var otpModel: OTPViewModel = .init()
    @FocusState var activeField: OTPField?
    
    var body: some View {
        VStack {
            OTPField()
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle("認証")
        .onChange(of: otpModel.otpFields) { newValue in
            OTPCondition(value: newValue)
        }
    }
    
    func OTPCondition(value: [String]){
        for index in 0..<5 {
            if value[index].count == 1 && activeStateForIndex(index: index) == activeField {
                activeField = activeStateForIndex(index: index + 1)
            }
        }
        
        for index in 1...5{
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeField = activeStateForIndex(index: index - 1)
            }
        }
        
        
        for index in 0..<6{
            if value[index].count > 1 {
                otpModel.otpFields[index] = String(value[index].last!)
            }
        }
    }
    
    
    @ViewBuilder
    func OTPField() -> some View {
        HStack(spacing: 14) {
            ForEach(0..<6, id: \.self){ index in
                VStack(spacing: 8) {
                    TextField("", text: $otpModel.otpFields[index])
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                    .multilineTextAlignment(.center)
                    .focused($activeField, equals: activeStateForIndex(index: index))
                
                Rectangle()
                        .fill(activeField == activeStateForIndex(index: index) ? .blue : .gray.opacity(0.3))
                    .frame(height: 4)
                }
            }
            .frame(width: 40)
        }
    }
    
    func activeStateForIndex(index: Int) -> OTPField {
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        case 3: return .field4
        case 4: return .field5
        default: return .field6
        }
    }
}

struct Vertification_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


enum OTPField {
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
}
