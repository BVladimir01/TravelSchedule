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
    }
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            switch viewModel.loadingState {
            case .error(let error):
                ErrorView(errorType: error)
            default:
                content
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
            VStack(spacing: 16) {
                titleLabel
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
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
                    ThreadDetailView(thread: threadFormatter.map(thread))
                }
                .task {
                    guard let lastThread = viewModel.displayedThreads.last else { return }
                    if thread == lastThread {
                        await viewModel.fetchThreads()
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
        Text("\(viewModel.origin.title) → \(viewModel.destination.title)")
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
    
}


#Preview {
//    ThreadSelectionView(origin: Location(city: "some city",
//                                         station: "some station"),
//                        destination: Location(city: "Test city",
//                                              station: "test station"))
}
