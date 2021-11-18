//
//  AlteaResponse.swift
//  Altea
//
//  Created by Afriyandi Setiawan on 18/11/21.
//

import Foundation

import Foundation

// MARK: - AlteaResponse
struct AlteaResponse: Codable {
    let status: Bool
    let message: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let doctorID, name, slug: String
    let isPopular: Bool
    let about, overview: String
    let photo: Photo
    let sip, experience: String
    let price: Price
    let specialization: Specialization
    let hospital: [Hospital]
    let aboutPreview: String

    enum CodingKeys: String, CodingKey {
        case doctorID = "doctor_id"
        case name, slug
        case isPopular = "is_popular"
        case about, overview, photo, sip, experience, price, specialization, hospital
        case aboutPreview = "about_preview"
    }
}

extension Datum: Identifiable {
    var id: UUID { return UUID() }
}

// MARK: - Hospital
struct Hospital: Codable, Identifiable {
    let id: String
    let name: String
    let image, icon: Photo
}

// MARK: - Photo
struct Photo: Codable {
    let sizeFormatted: String
    let url: String
    let formats: Formats

    enum CodingKeys: String, CodingKey {
        case sizeFormatted = "size_formatted"
        case url, formats
    }
}

// MARK: - Formats
struct Formats: Codable {
    let thumbnail, large, medium, small: String
}

// MARK: - Price
struct Price: Codable {
    let raw: Int
    let formatted: String
}


// MARK: - Specialization
struct Specialization: Codable {
    let id, name: String
}
