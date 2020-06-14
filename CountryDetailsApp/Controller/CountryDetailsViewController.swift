//
//  CountryDetailsViewController.swift
//  CountryDetailsApp
//
//  Created by MyHome on 14/06/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    let countrytableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //MARK: Add TableView to Controller
        view.addSubview(countrytableView)
        
        //MARK: TableView Layout Contraints
        countrytableView.translatesAutoresizingMaskIntoConstraints = false
        countrytableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        countrytableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        countrytableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        countrytableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }


}

