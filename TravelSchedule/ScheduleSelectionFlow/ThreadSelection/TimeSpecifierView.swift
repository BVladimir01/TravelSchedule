//
//  TimeSpecifierView.swift
//  TravelSchedule
//
//  Created by Vladimir on 31.07.2025.
//

import SwiftUI


struct TimeSpecifierView: View {
    
    @Binding private var selection: Set<TimeInterval>
    @Binding private var allowsTransfers: Bool
    
    private let timeIntervals = [TimeIntervals.morning, TimeIntervals.day, TimeIntervals.evening, TimeIntervals.night]
    private let mapper = TimeIntervalMapper()
    
    init(selection: Binding<Set<TimeInterval>>, allowsTransfers: Binding<Bool>) {
        self._selection = selection
        self._allowsTransfers = allowsTransfers
    }
    
    var body: some View {
        VStack(spacing: 16) {
            timeSpecification
            Spacer()
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
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButton()
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
    
    private func stringRepresentation(of interval: TimeInterval) -> String {
        let uiModel = mapper.map(interval)
        return "\(uiModel.description) \(uiModel.start) - \(uiModel.end)"
    }
    
    
}
