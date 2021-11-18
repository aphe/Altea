//
//  API.swift
//  Altea
//
//  Created by Afriyandi Setiawan on 18/11/21.
//

import Foundation
import Combine

struct FilterDefaultValue {
    static let hospital = "Hospital"
    static let specialization = "Specialzation"
}


/// Main View Model
final class MainViewModel : ObservableObject{
    
    /// Based response from URL
    private var response: AlteaResponse? {
        didSet {
            datum = response?.data ?? []
        }
    }
    private var cancelable: AnyCancellable?
    private let apiClient = APIClient()
    private var url: URL
    private var originData: [Datum] = []
    private var hospitalList: [Hospital] = [] {
        didSet {
            if hospitalNameList.isEmpty {
                hospitalNameList = hospitalList.compactMap({ hospital in
                    hospital.name
                }).unique().sorted()
                hospitalNameList.append("Reset")
            }
        }
    }
    private var specializationList: [Specialization] = [] {
        didSet {
            if specializationNameList.isEmpty {
                specializationNameList = specializationList.compactMap({ specialization in
                    specialization.name
                }).unique().sorted()
                specializationNameList.append("Reset")
            }
        }
    }
    /// Check if hospital filter active based on the text value of it.
    private var hospitalActive: Bool {
        get {
            selectedHospital != FilterDefaultValue.hospital
        }
    }
    
    /// Check if specialization filter active based on the text value of it.
    private var specializationActive: Bool {
        get {
            selectedSpecialization != FilterDefaultValue.specialization
        }
    }
    
    /// If the hospital list and specialization coming from another end point,
    /// we need to separate this.
    @Published var datum: [Datum] = [] {
        didSet {
            if originData.isEmpty {
                originData = datum
            }
            hospitalList = fetchhHospital()
            specializationList = fetchSpecialization()
        }
    }
    @Published var resultEmpty: Bool = false
    @Published var hideLoading: Bool = true
    @Published var hospitalNameList: [String] = []
    @Published var specializationNameList: [String] = []
    @Published var selectedHospital: String = FilterDefaultValue.hospital {
        didSet {
            if specializationActive {
                filterSpecialization()
            }
            filterHospital(specializationActive: specializationActive)

        }
    }
    @Published var selectedSpecialization: String = FilterDefaultValue.specialization {
        didSet {
            if hospitalActive {
                filterHospital()
            }
            filterSpecialization(hospitalActive: hospitalActive)
        }
    }
    
    init(stringURL: String) {
        guard let url = URL(string: stringURL) else {
            preconditionFailure("Should be valid url string")
        }
        self.url = url
    }
    
    func request() {
        hideLoading.toggle()
        cancelable = doRequest()
            .mapError({ (error) -> Error  in
                debugPrint(error)
                return error
            })
            .sink(receiveCompletion: { _ in
                debugPrint("completed")
            }, receiveValue: { response in
                self.hideLoading.toggle()
                self.response = response
            })
    }
    
    private func doRequest() -> AnyPublisher<AlteaResponse, Error> {
        let request = URLRequest(url: self.url)
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    /// Fetch List of `Hospital`
    ///
    /// This should be coming from another end point so we can create another view model for it.
    /// - Returns: array of `Hospital`
    private func fetchhHospital() -> [Hospital] {
        datum.flatMap({ datum in
            datum.hospital
        })
    }
    
    /// Fetch List of `Specialization`
    ///
    /// This should be coming from another end point so we can create another view model for it.
    /// - Returns: array of `Specialization`
    private func fetchSpecialization() -> [Specialization] {
        datum.compactMap({ datum in
            datum.specialization
        })
    }
    
    /// Do filter of `datum` based on `selectedSpecialization`
    /// 
    /// - Parameter hospitalActive: check if `hospitalActive` is active
    private func filterSpecialization(hospitalActive: Bool = false) {
        if selectedSpecialization == "Reset" {
            selectedSpecialization = FilterDefaultValue.specialization
            if hospitalActive {
                return
            }
            datum = originData
        } else if selectedSpecialization != FilterDefaultValue.specialization {
            var datas = originData
            if hospitalActive {
                datas = datum
            }
            let filtered = datas.filter { datum in
                datum.specialization.name == selectedSpecialization
            }
            if !filtered.isEmpty {
                datum = filtered
                resultEmpty = false
                return
            } else {
                resultEmpty = true
            }
        }
    }
    /// Do filter of `datum` based on `selectedHospital`
    ///
    /// - Parameter specializationActive: check if `selectedSpecialization` is active
    private func filterHospital(specializationActive: Bool = false) {
        if selectedHospital == "Reset" {
            selectedHospital = FilterDefaultValue.hospital
            if specializationActive {
                return
            }
            datum = originData
        } else if selectedHospital != FilterDefaultValue.hospital {
            var datas = originData
            if specializationActive {
                datas = datum
            }
            let filtered = datas.filter { datum in
                datum.hospital.contains { hospital in
                    hospital.name == selectedHospital
                }
            }
            if !filtered.isEmpty {
                datum = filtered
                resultEmpty = false
               return
            } else {
                resultEmpty = true
            }
        }
    }
    
    /// Search doctor based on query search
    ///
    /// This should be coming from another end point so we can create another view model for it.
    /// - Parameter query: part of string that need to be search
    func searchDoctor(query: String) {
        if query.isEmpty {
            datum = originData
            filterData()
            return
        }
        filterData()
        datum = datum.filter({ datum in
            datum.name.contains(query)
        })
        resultEmpty = datum.isEmpty
        func filterData() {
            filterHospital(specializationActive: specializationActive)
            filterSpecialization(hospitalActive: hospitalActive)
        }
    }
}
