//
//  CuttlyResponse.swift
//  ShortURLBuilder
//
//  Created by Ching-Wen Terry TAN on 13/08/2024.
//

import Foundation

struct CuttlyResponse: Codable {
    struct Response: Codable {
        let shortLink: String
    }
    let url: Response
}
