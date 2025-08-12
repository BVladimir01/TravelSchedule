//
//  UserAgreementUIKitWebView.swift
//  TravelSchedule
//
//  Created by Vladimir on 11.08.2025.
//

import UIKit
import WebKit

final class UserAgreementUIKitWebView: UIView {
    
    private let webView = WKWebView()
    private let request = URLRequest(url: URL(string: "https://yandex.ru/legal/practicum_offer/ru/")!)

    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(webView)
        webView.load(request)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
