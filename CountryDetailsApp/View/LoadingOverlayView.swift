//
//  LoadingOverlayView.swift
//  CountryDetailsApp
//
//  Created by MyHome on 23/06/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import UIKit

class LoadingOverlayView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView() {
        backgroundColor = .black
        alpha = 0
        let activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.center = super.center
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        let loadinglabel = UILabel()
        loadinglabel.text = DATA_LOADING
        loadinglabel.textColor = .white
        loadinglabel.sizeToFit()
        loadinglabel.center = CGPoint(x: activityIndicator.center.x, y: activityIndicator.center.y + 30)
        addSubview(loadinglabel)
    }
}
