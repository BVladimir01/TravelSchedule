//
//  ThreadDetailView.swift
//  TravelSchedule
//
//  Created by Vladimir on 11.08.2025.
//

import SwiftUI

struct ThreadDetailView: View {
    
    private let thread: ThreadUIModel
    
    init(thread: ThreadUIModel) {
        self.thread = thread
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            carrierAndTransfersInfo
                .padding(.horizontal, 14)
                .padding(.top, 14)
                .padding(.bottom, 4)
            timeInfo
                .padding(14)
        }
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(.ypLightGray)
        }
        .overlay(alignment: .topTrailing) {
            departureDate
                .padding(.top, 15)
                .padding(.trailing, 7)
            
        }
    }
    
    private var carrierAndTransfersInfo: some View {
        HStack(spacing: 8) {
            logoImage(url: thread.carrierLogoURL)
                .frame(width: 38, height: 38)
            VStack(alignment: .leading, spacing: 2) {
                Text(thread.carrierTitle)
                    .foregroundStyle(.ypBlackUniversal)
                    .font(.system(size: 17, weight: .regular))
                if thread.hasTransfers {
                    Text("Пересадка")
                        .foregroundStyle(.ypRed)
                        .font(.system(size: 12, weight: .regular))
                }
            }
            .padding(.trailing, 57)
        }
    }
    
    @ViewBuilder
    private func logoImage(url: String?) -> some View {
        let stub = Image(systemName: "photo.circle")
            .resizable()
            .scaledToFit()
        if url == nil {
            stub
        } else {
            AsyncImage(url: URL(string: url ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .tint(.ypBlackUniversal)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    stub
                @unknown default:
                    stub
                }
            }
        }
    }
    
    private var timeInfo: some View {
        HStack(spacing: 5) {
            HStack(spacing: 4) {
                Text(thread.departureTime)
                    .foregroundStyle(.ypBlackUniversal)
                    .font(.system(size: 17, weight: .regular))
                divider
            }
            Text(thread.duration)
                .foregroundStyle(.ypBlackUniversal)
                .font(.system(size: 12, weight: .regular))
            HStack(spacing: 4) {
                divider
                Text(thread.arrivalTime)
                    .foregroundStyle(.ypBlackUniversal)
                    .font(.system(size: 17, weight: .regular))
            }
        }
    }
    
    private var divider: some View {
        Rectangle()
            .fill(.ypGray)
            .frame(height: 1)
            .frame(maxWidth: .infinity)
    }
    
    private var departureDate: some View {
        Text(thread.departureDay)
            .foregroundStyle(.ypBlackUniversal)
            .font(.system(size: 12, weight: .regular))
    }
    
}
