//
//  CarrierDetailView.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import SwiftUI


// MARK: - CarrierDetailView
struct CarrierDetailView: View {
    
    // MARK: - Private Properties
    
    private let carrier: Carrier
    
    // MARK: - Initializers
    
    init(carrier: Carrier) {
        self.carrier = carrier
    }
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            VStack(spacing: 16) {
                logoImage
                    .frame(height: 104)
                infoView
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButton()
            }
        }
    }
    
    private var infoView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(carrier.title)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlack)
            VStack {
                rowView(title: "E-Mail", headline: carrier.email ?? "")
                rowView(title: "Телефон", headline: carrier.phone ?? "")
            }
        }
    }
    
    private func rowView(title: String, headline: String) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.ypBlack)
                Text(headline)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypBlue)
            }
            Spacer()
        }
        .padding(.vertical, 12)
    }
    
    @ViewBuilder
    private var logoImage: some View {
        let stub = Image(systemName: "photo.circle")
            .resizable()
            .scaledToFit()
        if carrier.logoURL == nil {
            stub
        } else {
            AsyncImage(url: URL(string: carrier.logoURL ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .tint(.ypBlack)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(.serverError)
                        .resizable()
                        .scaledToFit()
                default:
                    Image(.serverError)
                        .resizable()
                        .scaledToFit()
                }
            }
        }
    }
    
}


#Preview {
    CarrierDetailView(carrier: Carrier(title: "РЖД", email: "i.lozgkina@yandex.ru", phone: "7 (904) 329-27-71", logoURL: "https://company.rzd.ru/api/media/resources/1603629"))
}
