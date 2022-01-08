//
//  Enums.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 8/1/22.
//

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum ContentType: String {
    case json = "application/json"
    case formURLEncoded = "application/x-www-form-urlencoded"
}

public enum StatusCode: Int {
    case ok = 200
    case created = 201
    case accepted = 202
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
}

public enum HTTPClientError: Error {
    case encoding
    case decoding
    case httpError(StatusCode)
    case unknown(String)
}
