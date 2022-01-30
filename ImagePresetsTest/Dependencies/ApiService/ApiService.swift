//
//  ApiService.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 14.01.22.
//

import Foundation

final class ApiService {
    
    private let userKeys = ["EvAnEjTITAc", "8S6BkMGaLyQ", "nU5JmY-umLU", "Mq2TTSeeSoM", "zSDr1QDUnKU", "wqBYgxqNQ-A", "90nc19cte48", "JuStWr0NgID", "Gv4gipd7_DQ", "ge0_dK91YFU", "aLA5H6yhUO4", "4EmIiAwlTl0", "8US0LNrYScs", "Frtw4jsn-ck", "eYU3GveN6Ak", "RHFzMbxnyQk", "e6i5JIHJDMU", "emcio5jC35U", "wt48FXu5zN4", "wqP9VIkij9E", "I-GPElYBsyk", "nD9t5c7gbVM", "-6i6a23H5Ho", "omCpfhaiAgo", "oUGCU8pG3KM", "6o9ogx_D_zU", "taBXtNxW3NE", "DVoh_Fse9Dg", "UrNZXCdFOlg", "qBXDZPnD7_Q", "Wbu_scb-9HQ", "8Fp1Npkhudw", "THXthK7oC-U", "Sdz_1mcISKk", "lFgzCdNv5Jo", "kqLxVgI1f9k", "qbUkz3PcJaY", "dIvc4UXKAJE", "AJnaaZeWAvg", "SyODvdLIQso", "KLNIY0hW514", "oClVYJk7Cgo", "gdwS9FWy9x4", "k6mw-1o9F_w", "ymAawIHwGlk", "m3jjgFmk67M", "o11ABojB-nU", "tKiYxps9FI4", "b7RmtJH2GrI", "v1jO6pN45_4", "A8MQMyfi6Ek", "IZUF-jDSnls", "Ap_oZm8LLi4", "iYUPbPcXNQc", "qkR2QrGt0eI", "s2ItCQ-kgTY", "p7bieVmQx9c", "CennImb4CZA", "ToSVErXgj3g", "VW2UGDpbN94"]
    
    func fetchUsers(completion: @escaping ([User]) -> Void) {
        
        let urlString = "http://dev.bgsoft.biz/task/credits.json"
        guard let url = URL(string: urlString) else { return completion([]) }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                  let data = data else { return completion([]) }
            guard error == nil else { return completion([]) }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return completion([]) }
                
                var items = [User]()
                self.userKeys.forEach { key in
                    do {
                        if var dictionary = dictionary[key] as? [String: Any] {
                            dictionary["id"] = key
                            let user = try User(dictionary: dictionary)
                            items.append(user)
                        }
                        
                    } catch let jsonErr {
                        print("Error serializing json", jsonErr)
                    }
                }
                completion(items)
            } catch let jsonErr {
                print("Error serializing dictionary", jsonErr)
            }
            
        }.resume()
    }
    
}
