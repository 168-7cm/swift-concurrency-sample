//
//  APIClient.swift
//  swift-concurrency-sample
//
//  Created by Kou Yamamoto on 2023/01/04.
//

import Foundation

struct ResponseErrorReason {
    let statusCode: Int
    let message: String?
}

enum ApiError: Error {
    case server(ResponseErrorReason)
    case decode(Error)
    case noResponse
    case unknown
    case invalidUrl
}

final class APIClient {
    static let shared = APIClient()
    private init() {}

    func request<T: Requestable>(_ requestable: T) async throws -> T.Response {
        guard let request = requestable.urlRequest else { throw ApiError.invalidUrl }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpStatus = response as? HTTPURLResponse else { throw ApiError.noResponse }

        switch httpStatus.statusCode {
        case 200 ..< 400:
            do {
                let model = try requestable.decode(from: data)
                return model
            } catch {
                throw ApiError.decode(error)
            }
        case 400... :
            let errorResponse = makeErrorResponse(data: data, statusCode: httpStatus.statusCode)
            throw ApiError.server(errorResponse)
        default:
            throw ApiError.unknown
        }
    }

    func makeErrorResponse(data: Data, statusCode: Int) -> ResponseErrorReason {
        let errorJSON = try? JSONSerialization.jsonObject(with: data) as? [String: String]
        return ResponseErrorReason(statusCode: statusCode, message: errorJSON?["error"])
    }
}
