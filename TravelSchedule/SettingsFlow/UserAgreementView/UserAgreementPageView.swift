//
//  UserAgreementPageView.swift
//  TravelSchedule
//
//  Created by Vladimir on 11.08.2025.
//

import SwiftUI


struct UserAgreementPageView: View {
    
    var body: some View {
        NavigationStack {
            UserAgreementView()
                .navigationTitle("Пользовательское соглашение")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationBackButton()
                    }
                }
                .toolbar(.hidden, for: .tabBar)
        }
    }
    
}
