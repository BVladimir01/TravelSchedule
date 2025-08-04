//
//  ThreadSelectionView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//


import SwiftUI


struct ThreadSelectionView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel: ThreadsViewModel
    
    init(origin: Station, destination: Station, viewModel: ThreadsViewModel) {
        self.viewModel = viewModel
        viewModel.configure(origin: origin, destination: destination)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 16) {
                titleLabel
                ForEach(viewModel.threads, id: \.self) { thread in
                    NavigationLink {
                        CarrierDetailView(carrier: thread.carrier)
                    } label: {
                        rowView(for: viewModel.threadUIModel(for: thread))
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            specifyTimeButton
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
        }
        .onAppear {
            viewModel.fetchThreads()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButton()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    private var titleLabel: some View {
        Text(viewModel.navigationBarTitle)
            .foregroundStyle(.ypBlack)
            .font(.system(size: 24, weight: .bold))
    }
    
    private var specifyTimeButton: some View {
        NavigationLink{
            TimeSpecifierView(selection: $viewModel.timeSpecification,
                              allowsTransfers: $viewModel.allowTransfers)
        } label: {
            Text("Уточнить время")
                .foregroundStyle(.ypWhiteUniversal)
                .font(.system(size: 17, weight: .bold))
                .overlay(alignment: .trailing) {
                    if viewModel.isSearchSpecified {
                        Circle()
                            .fill(.ypRed)
                            .frame(width: 8, height: 8)
                            .offset(x: 12)
                    } else {
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.ypBlue)
                }
        }
    }
    
    private func rowView(for thread: ThreadUIModel) -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 8) {
                logoImage(url: thread.carrierLogoURL ?? "")
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
            }
            .padding(.horizontal, 14)
            .padding(.top, 14)
            .padding(.bottom, 4)
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
            .padding(14)
        }
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(.ypLightGray)
        }
        .overlay(alignment: .topTrailing) {
            Text(thread.departureDate)
                .foregroundStyle(.ypBlackUniversal)
                .font(.system(size: 12, weight: .regular))
                .padding(.top, 15)
                .padding(.trailing, 7)
            
        }
    }
    
    private var divider: some View {
        Rectangle()
            .fill(.ypGray)
            .frame(height: 1)
            .frame(maxWidth: .infinity)
    }
    
    private func logoImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .tint(.ypBlackUniversal)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                Image(systemName: "photo.circle")
                    .resizable()
                    .scaledToFit()
            @unknown default:
                ProgressView()
            }
        }
    }
    
}


#Preview {
//    ThreadSelectionView(origin: Location(city: "some city",
//                                         station: "some station"),
//                        destination: Location(city: "Test city",
//                                              station: "test station"))
}
