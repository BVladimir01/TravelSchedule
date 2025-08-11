//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Vladimir on 30.07.2025.
//

import SwiftUI


struct SettingsView: View {

    // MARK: - Private Properties
    
    @ObservedObject private var vm: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.vm = viewModel
    }
    
    // MARK: - Views
    
    var body: some View {
        NavigationStack {
            content
        }
    }
    
    private var content: some View {
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            VStack(spacing: .zero) {
                darkThemeToggle
                    .padding(.horizontal, 16)
                    .padding(.vertical, 19)
                Spacer()
                footer
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
            }
        }
    }
    
    private var darkThemeToggle: some View {
        HStack(spacing: .zero) {
            Toggle(isOn: $vm.isUsingDarkTheme) {
                Text("Темная тема")
                    .foregroundStyle(.ypBlack)
                    .font(.system(size: 17, weight: .regular))
            }
                .toggleStyle(.switch)
                .tint(.ypBlue)
        }
    }
    
    private var footer: some View {
        VStack(spacing: 16) {
            Group {
                Text("Приложение использует API «Яндекс.Расписания»")
                Text("Версия 1.0 (beta)")
            }
            .multilineTextAlignment(.center)
            .foregroundStyle(.ypBlack)
            .font(.system(size: 12, weight: .regular))
        }
    }
}


#Preview {
    SettingsView(viewModel: SettingsViewModel(themeStore: .shared))
}
