//
//  ApiService.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 14.01.22.
//

import Foundation

enum RequestURL {
    case getImagesSession
    
    var url: URL? {
        switch self {
        case .getImagesSession:
            guard let path = URL(string: "http://dev.bgsoft.biz/task/credits.json") else { return nil }
            return path
        }
    }
}

final class ApiService {
    
    func fetchReques<T: Decodable>(requestURL: RequestURL, completion: @escaping (T) -> Void) {
        guard let url = requestURL.url else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                switch requestURL {
                case .getImagesSession:
                    completion(obj)
                    print(obj)
                }
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
        }.resume()
    }
}
