//
//  TimeSpecifierView.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import SwiftUI


// MARK: - TimeSpecifierView
struct TimeSpecifierView: View {
    
    // MARK: - Private Properties - State
    
    @Binding private var selection: Set<TimeInterval>
    @Binding private var allowsTransfers: Bool
    
    // MARK: - Private Properties
    
    private let timeIntervals: [TimeInterval]
    private let mapper = TimeIntervalUIMapper()
    
    // MARK: - Initializers
    
    init(selection: Binding<Set<TimeInterval>>, allowsTransfers: Binding<Bool>, timeIntervals: [TimeInterval]) {
        self._selection = selection
        self._allowsTransfers = allowsTransfers
        self.timeIntervals = timeIntervals
    }
    
    // MARK: - Views
    
    var body: some View {
        VStack(spacing: 16) {
            timeSpecification
            transferSelection
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButton()
            }
        }
    }
    
    private var timeSpecification: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Время отправления")
                .font(.system(size: 24, weight: .bold))
            VStack {
                ForEach(timeIntervals, id: \.self) { interval in
                    timeIntervalSelectionRow(for: interval)
                }
            }
        }
    }
    
    private func timeIntervalSelectionRow(for interval: TimeInterval) -> some View {
        HStack {
            Text(stringRepresentation(of: interval))
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.ypBlack)
            Spacer()
            Button {
                if selection.contains(interval) {
                    selection.remove(interval)
                } else {
                    selection.insert(interval)
                }
            } label: {
                Image(selection.contains(interval) ? .checkBoxOn : .checkBoxOff)
                    .tint(.ypBlack)
            }
        }
        .padding(.vertical, 16)
    }
    
    private var transferSelection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Показывать варианты с пересадками")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlack)
            VStack {
                HStack(spacing: 4) {
                    Text("Да")
                    Spacer()
                    Button {
                        allowsTransfers = true
                    } label: {
                        Image(allowsTransfers ? .radioButtonOn : .radioButtonOff)
                            .tint(.ypBlack)
                    }
                }
                .padding(.vertical, 19)
                HStack(spacing: 4) {
                    Text("Нет")
                    Spacer()
                    Button {
                        allowsTransfers = false
                    } label: {
                        Image(allowsTransfers ? .radioButtonOff : .radioButtonOn)
                            .tint(.ypBlack)
                    }
                }
                .padding(.vertical, 19)
            }
        }
    }
    
    private func stringRepresentation(of interval: TimeInterval) -> String {
        let uiModel = mapper.map(interval)
        return "\(uiModel.description) \(uiModel.start) - \(uiModel.end)"
    }
    
    
}
