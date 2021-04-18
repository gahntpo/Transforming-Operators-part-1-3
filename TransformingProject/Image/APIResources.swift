//
//  APIResources.swift
//  TransformingProject
//
//  Created by Karin Prater on 17.04.21.
//

import Foundation
import Combine

struct APIResources {
    
    func fetch(url: URL) -> AnyPublisher<Data, APIError> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ (data, response) -> Data in
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw APIResources.APIError.badResponse(statusCode: response.statusCode)
                }else {
                    return data
                }
            })
            .mapError({ error in
                APIResources.APIError.convert(error: error)
            })
            .eraseToAnyPublisher()
    }
    
    enum APIError: Error, CustomStringConvertible {
        
        case url(URLError?)
        case badResponse(statusCode: Int)
        case unknown(Error)
        
        
        static func convert(error: Error) -> APIError {
            switch error {
            case is URLError:
                return .url(error as? URLError)
            case is APIError:
                return error as! APIError
            default:
                return .unknown(error)
            }
        }
        
        
        var description: String {
            return ""
        }
        
        
    }
    
    
    
}
