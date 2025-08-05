//
//  ThreadSelectionView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//


import SwiftUI


// MARK: ThreadSelectionView
struct ThreadSelectionView: View {
    
    // MARK: - Private Properties - State
    
    @ObservedObject private var viewModel: ThreadsViewModel
    
    // MARK: - Private Properties
    
    @Environment(\.dismiss) private var dismiss
    private let threadFormatter = ThreadModelUIMapper()
    
    // MARK: - Initializers
    
    init(viewModel: ThreadsViewModel) {
        self.viewModel = viewModel
        viewModel.performInitialFetch()
    }
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            Group {
                switch viewModel.loadingState {
                case .error(let error):
                    ErrorView(errorType: error)
                default:
                    content
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButton()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    
    private var content: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: .zero) {
                titleLabel
                    .padding(.horizontal, 16)
                if viewModel.displayedThreads.count > 0 {
                    ScrollView {
                        listOfThreads
                            .padding(.horizontal, 16)
                            .padding(.bottom, 80)
                        Spacer()
                    }
                } else {
                    listEmptyView
                        .frame(maxHeight: .infinity)
                }
            }
            specifyTimeButton
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
        }
        .overlay {
            if viewModel.loadingState == .loading {
                loaderView
                    .tint(.ypBlack)
            }
        }
    }
    
    private var listOfThreads: some View {
        LazyVStack(spacing: 16) {
            ForEach(viewModel.displayedThreads, id: \.self) { thread in
                NavigationLink {
                    CarrierDetailView(carrier: thread.carrier)
                } label: {
                    rowView(for: threadFormatter.map(thread))
                }
                .onAppear {
                    guard let lastThread = viewModel.displayedThreads.last else { return }
                    if thread == lastThread {
                        viewModel.fetchThreads()
                    }
                }
            }
        }
    }
    
    private var loaderView: some View {
        ProgressView()
            .tint(.ypBlack)
            .scaleEffect(2)
    }
    
    private var listEmptyView: some View {
        Text("Вариантов нет")
            .foregroundStyle(.ypBlack)
            .font(.system(size: 24, weight: .bold))
    }
    
    private var titleLabel: some View {
        Text(viewModel.navigationBarTitle)
            .foregroundStyle(.ypBlack)
            .font(.system(size: 24, weight: .bold))
    }
    
    private var specifyTimeButton: some View {
        NavigationLink{
            TimeSpecifierView(selection: $viewModel.timeSpecifications,
                              allowsTransfers: $viewModel.allowTransfers,
                              timeIntervals: viewModel.allTimeIntervals)
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
            Text(thread.departureDay)
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
    
}


#Preview {
//    ThreadSelectionView(origin: Location(city: "some city",
//                                         station: "some station"),
//                        destination: Location(city: "Test city",
//                                              station: "test station"))
}
