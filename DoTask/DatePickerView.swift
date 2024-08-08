//
//  DatePickerView.swift
//  DoTask
//
//  Created by Mac on 08/08/2024.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var selectedDate: Date
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .padding()
            
            Button("Done") {
                dismiss()
            }
            .padding()
        }
        .frame(width: 300, height: 300)
    }
}

#Preview {
    DatePickerView(selectedDate: .constant(Date()))
}
