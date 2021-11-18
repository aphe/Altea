//
//  ImageDownloader.swift
//  Altea
//
//  Created by Afriyandi Setiawan on 20/11/21.
//

import Foundation
import UIKit
import Combine

final class ImageDownloader: ObservableObject {
    @Published var image: UIImage = UIImage()
    private var url: URL
    private let apiClient = APIClient()
    private var cancelable: AnyCancellable?
    
    init(stringImageURL: String) {
        guard let url = URL(string: stringImageURL) else {
            preconditionFailure("Should be valid url string")
        }
        self.url = url
    }
    
    func request() {
        cancelable = doRequest()
            .mapError({ (error) -> Error  in
                debugPrint(error)
                return error
            })
            .sink(receiveCompletion: { _ in
                debugPrint("completed")
            }, receiveValue: { response in
                guard let image = UIImage(data: response) else {
                    debugPrint("Invalid image data")
                    return
                }
                self.image = image
            })
    }
    
    private func doRequest() -> AnyPublisher<Data, Error> {
        let request = URLRequest(url: self.url)
        return apiClient.download(request)
    }
}
