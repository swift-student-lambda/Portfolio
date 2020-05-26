//
//  NetworkClient.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/26/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation
import SSNetworking

private let baseURL = URL(string: "http://localhost:8080")!

class NetworkClient {
    func fetchAllProjects(completion: @escaping (Result<[ProjectRepresentation], NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("projects")
        URLSession.shared.dataResultTask(with: URLRequest(url: url)) { result in
            completion(ProjectRepDecoder().decode(result))
        }.resume()
    }
}
