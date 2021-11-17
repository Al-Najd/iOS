//
//    ErrorResponse.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class ErrorResponse: Error, Codable {
    var error: String?
    var errors: [RSError]?
    var message: String?
    var stack: String?
    var statusCode: Int
}
