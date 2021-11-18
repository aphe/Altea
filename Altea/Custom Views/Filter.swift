//
//  Filter.swift
//  Altea
//
//  Created by Afriyandi Setiawan on 20/11/21.
//

import SwiftUI

struct Filter: View {
    var hospitalNames: [String] = []
    var specializations: [String] = []
    @State private var showHospitalPicker = false
    @State private var showSpecializationPicker = false
    @Binding var hospital: String
    @Binding var specialization: String
    var body: some View {
        HStack {
            Rectangle().stroke()
                .background(
                     HStack {
                        Text(hospital)
                             .font(.subheadline)
                        Image(systemName: "arrowtriangle.down.fill")
                    }
                )
                .onTapGesture {
                    showHospitalPicker.toggle()
                }
                .sheet(isPresented: $showHospitalPicker) {
                    ListPicker(dismiss: $showHospitalPicker, selected: $hospital, list: hospitalNames)
                }
            Spacer()
            Rectangle().stroke()
                .background(
                     HStack {
                        Text(specialization)
                             .font(.subheadline)
                        Image(systemName: "arrowtriangle.down.fill")
                    }
                )
                .onTapGesture {
                    showSpecializationPicker.toggle()
                }
                .sheet(isPresented: $showSpecializationPicker) {
                    ListPicker(dismiss: $showSpecializationPicker, selected: $specialization, list: specializations)
                }
        }
        .frame(height: 30)
        .padding(.horizontal)
    }
}

struct Filter_Previews: PreviewProvider {
    static var previews: some View {
        Filter(hospitalNames: [], specializations: [], hospital: .constant(""), specialization: .constant(""))
    }
}
