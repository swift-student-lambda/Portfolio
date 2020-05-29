//
//  NetworkClient.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/26/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import SSNetworking
import UIKit

private let baseURL = URL(string: "http://localhost:8080")!

typealias ImageResultCompletion = ((Result<UIImage, NetworkError>) -> Void)

class NetworkClient {
    func fetchAllProjects(completion: @escaping (Result<[ProjectRep], NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("projects")
        URLSession.shared.dataResultTask(with: URLRequest(url: url)) { result in
            completion(ProjectRepDecoder().decode(result))
        }.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping ImageResultCompletion) {
        URLSession.shared.dataResultTask(with: URLRequest(url: url)) { result in
            completion(ImageResultDecoder().decode(result))
        }.resume()
    }
}
