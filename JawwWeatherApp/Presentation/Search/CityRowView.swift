//
//  CityRowView.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 10/06/2026.
//

import SwiftUI

struct CityRowView: View {
    let city: SearchCity

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.07))
                    .frame(width: 46, height: 46)

                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 26))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.blue)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(city.name)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)

                Text("\(city.region), \(city.country)")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }

            Spacer()
           
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 14)
        .background(Color(red: 0.12, green: 0.14, blue: 0.17))
        .cornerRadius(14)
    }

    
}
