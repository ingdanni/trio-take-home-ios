//
//  HTTPClient.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 8/1/22.
//

import Foundation

open class HTTPClient {
    
    private let baseURL: String
    private let apiKey: String
    
    private var urlSession: URLSession {
        URLSession.shared
    }
    
    public init(configuration: HTTPClientConfiguration) {
        baseURL = configuration.baseURL
        apiKey = configuration.apiKey
    }
    
    public func request<T: Codable>(resource: Resource,
                                    body: [String: AnyObject]? = nil,
                                    headers: [String: String]? = nil,
                                    type: T.Type,
                                    completion: @escaping (Result<T, HTTPClientError>) -> Void) {

        let url = baseURL + resource.resource.route
        
        #if DEBUG
        print(url)
        #endif
        
        let requestURL = URL(string: url)
        
        var request = URLRequest(url: requestURL!, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = resource.resource.method.rawValue
        request.setValue(resource.resource.contentType?.rawValue, forHTTPHeaderField: "Content-Type")
        
        if let requestHeaders = headers {
            for (key, value) in requestHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = body,
            resource.resource.method == .post || resource.resource.method == .put {
            
            switch resource.resource.contentType {
            case .json:
                do {
                    let httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
                    request.httpBody = httpBody
                } catch {
                    completion(.failure(.encoding))
                }
                
            case .formURLEncoded:
                let query = body.map { "\($0)=\($1)" }.joined(separator: "&")
                request.httpBody = query.data(using: .utf8)
            default:
                break
            }
        }
        
        let task = urlSession.dataTask(with: request, completionHandler: { data, response, error in

            if let response = response as? HTTPURLResponse {

                if 400..<403 ~= response.statusCode {
                    if let data = data {
                        do {
                            let decodedResponse = try JSONDecoder().decode(type, from: data)
                            completion(.success(decodedResponse))
                        } catch {
                            let statusCode = StatusCode(rawValue: response.statusCode)!
                            
                            completion(.failure(.httpError(statusCode)))
                        }
                    } else {
                        completion(.failure(.unknown("Unknown error ocurred.")))
                    }
                }

                if 200..<300 ~= response.statusCode, let data = data {
                    do {
                        let decodedResponse = try JSONDecoder().decode(type, from: data)
                        completion(.success(decodedResponse))
                    } catch {
                        switch error {
                        case let DecodingError.dataCorrupted(context):
                            print("Data corrupted: \(context.debugDescription)")
                        case let DecodingError.keyNotFound(key, context):
                            print("Key not found: \(key), \(context.debugDescription), \(context.codingPath)")
                        case let DecodingError.valueNotFound(value, context):
                            print("Value not found: \(value), \(context.debugDescription), \(context.codingPath)")
                        case let DecodingError.typeMismatch(type, context):
                            print("Type mismatch: \(type), \(context.debugDescription), \(context.codingPath)")
                        default:
                            print(error.localizedDescription)
                            break
                        }
                        
                        completion(.failure(.decoding))
                    }
                }
            }

            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
            }
        })

        task.resume()
    }
}
