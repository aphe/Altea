//
//  ContentView.swift
//  Altea
//
//  Created by Afriyandi Setiawan on 18/11/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MainViewModel(stringURL: "https://run.mocky.io/v3/c9a2b598-9c93-4999-bd04-0194839ef2dc")
    @State private var query: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                SearchBar(text: $query)
                Filter(hospitalNames: viewModel.hospitalNameList, specializations: viewModel.specializationNameList, hospital: $viewModel.selectedHospital, specialization: $viewModel.selectedSpecialization)
                List {
                    ForEach(viewModel.datum) { item in
                        CardView(item: item)
                    }
                }.isHidden(viewModel.resultEmpty)
                Spacer()
            }
            .onChange(of: query) { value in
                viewModel.searchDoctor(query: value)
            }
            Text("Not Found")
                .font(.title)
                .isHidden(!viewModel.resultEmpty)
            ProgressView().isHidden(viewModel.hideLoading)
        }
        .onAppear {
            viewModel.request()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
