//
//  API.swift
//  PokeApp
//
//  Created by Intellisys on 23/2/21.
//

import UIKit.UIImage
import Alamofire
import AlamofireImage

final class APIManager {
    
    static let shared: APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    private let scheme = "https"
    private let base = "pokeapi.co"
    private let apiPath = "api"
    private let apiVersion = "v2"
    private var urlComponents: URLComponents!
    
    private init() {
        urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = base
    }
    
    func getWithPagination<T>(path: String, queryItems: [URLQueryItem], completion: @escaping (Result<APIResponse<T>, Error>) -> Void) where T: Codable {
            
        makeResponse(path: path, queryItems: queryItems)
            .responseDecodable(of: APIResponse<T>.self) { response in
        
            if let error = response.error {
                print("Error")
                completion(.failure(error))
            } else {
                if response.value == nil {
                    completion(.failure(NSError(domain: "Value is empty", code: -1, userInfo: nil)))
                } else {
                    completion(.success(response.value!))
                }
            }
        }
    }
    
    func getWithoutPagination<T>(path: String, queryItems: [URLQueryItem], completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        makeResponse(path: path, queryItems: queryItems)
            .responseDecodable(of: T.self) { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                if response.value == nil {
                    completion(.failure(NSError(domain: "Value is empty", code: -1, userInfo: nil)))
                } else {
                    completion(.success(response.value!))
                }
            }
        }
    }
    
    func getWithoutPagination<T>(url: String, completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        makeResponse(url: url)
            .responseDecodable(of: T.self) { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                if response.value == nil {
                    completion(.failure(NSError(domain: "Value is empty", code: -1, userInfo: nil)))
                } else {
                    completion(.success(response.value!))
                }
            }
        }
    }
    
    private func makeResponse(path: String, queryItems: [URLQueryItem]) -> DataRequest {
         urlComponents.queryItems = queryItems
               urlComponents.path = "/\(apiPath)/\(apiVersion)/\(path)"
               return AF.request(urlComponents.url!, method: .get) { urlRequest in
                   urlRequest.timeoutInterval = 30
               }
               .validate(statusCode: 200...300)
               .validate(contentType: ["application/json"])
    }
    
    private func makeResponse(url: String) -> DataRequest {
               return AF.request(url, method: .get) { urlRequest in
                   urlRequest.timeoutInterval = 30
               }
               .validate(statusCode: 200...300)
               .validate(contentType: ["application/json"])
    }
    
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        AF.request(url, method: .get).responseImage { (response) in
            completion(response.value ?? UIImage(named: "pokeballImage")!)
        }
    }
}
