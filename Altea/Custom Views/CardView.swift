//
//  CardView.swift
//  Altea
//
//  Created by Afriyandi Setiawan on 20/11/21.
//

import SwiftUI

struct CardView: View {
    var item: Datum
    
    var body: some View {
        HStack {
            ImageFromURL(withURL: item.photo.url)
            Spacer()
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                    ForEach(item.hospital) { hospital in
                        HStack(spacing: 5) {
                            Text(hospital.name)
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text("-")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text(item.specialization.name)
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                    Spacer()
                    Text(item.about
                            .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                            .replacingOccurrences(of: "&nbsp;", with: " ")
                    )
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Spacer()
                    HStack {
                        Spacer()
                        Text(item.price.formatted)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }.padding(10)
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
        )
        .padding(.vertical)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(item: Datum(doctorID: "", name: "dr. Budi", slug: "", isPopular: true, about: "dokter kita semua", overview: "", photo: Photo(sizeFormatted: "", url: "", formats: Formats(thumbnail: "", large: "", medium: "", small: "")), sip: "", experience: "", price: Price(raw: 10, formatted: "Rp 2M"), specialization: Specialization(id: "", name: "Mantri Suntik"), hospital: [Hospital(id: "", name: "Sehat", image: Photo(sizeFormatted: "", url: "", formats: Formats(thumbnail: "", large: "", medium: "", small: "")), icon: Photo(sizeFormatted: "", url: "", formats: Formats(thumbnail: "", large: "", medium: "", small: "")))], aboutPreview: ""))
    }
}
