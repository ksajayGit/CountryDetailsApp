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
    var refreshControl: UIRefreshControl!
    
    var countryData: CountryViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //MARK: Add TableView to Controller
        view.addSubview(countrytableView)
        countrytableView.dataSource = self
        
        //MARK: TableView Layout Contraints
        countrytableView.translatesAutoresizingMaskIntoConstraints = false
        countrytableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        countrytableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        countrytableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        countrytableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        //MARK: Register TableViewCell
        countrytableView.register(CountryDetailTableViewCell.self, forCellReuseIdentifier: "countryDetailCell")
        
        //MARK: Add Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.lightGray.withAlphaComponent(0.5)
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        countrytableView.addSubview(refreshControl)
        
        self.checkNetworkAndGetData()
    }
    
    @objc func refreshData(){
        self.checkNetworkAndGetData()
    }

}

extension CountryDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryData?.countryDetails.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryDetailCell", for: indexPath) as! CountryDetailTableViewCell
        cell.countryInfo = countryData?.countryDetails[indexPath.row]
        return cell
    }
}

extension CountryDetailsViewController{
    func checkNetworkAndGetData(){
        let reachable = Reachability.forInternetConnection()
        guard let status = reachable?.currentReachabilityStatus(),
            status != NotReachable else{
                let networkAlert = UIAlertController(title: "Network Status", message: "You are ofline! please check your network connection and pull down to refresh data.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                }
                networkAlert.addAction(okButton)
                self.present(networkAlert, animated: true, completion: nil)
                return
        }
        getCountryDetails()
    }
    
    func getCountryDetails() {
        self.view.isUserInteractionEnabled = false
        let serviceCall = ServiceCalls()
        serviceCall.getDetails {[weak self] (result: Result<Country, Error>) in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.view.isUserInteractionEnabled = true
                switch result{
                    case .success(let country):
                        self?.countryData = CountryViewModel(country: country)
                        self?.navigationItem.title = self?.countryData.countryname
                        self?.countrytableView.reloadData()
                    case .failure(let error):
                        let serviceCallAlert = UIAlertController(title: "ServiceCall Error", message: error.localizedDescription, preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                            self?.dismiss(animated: true, completion: nil)
                        }
                        serviceCallAlert.addAction(okButton)
                        self?.present(serviceCallAlert, animated: true, completion: nil)
                }
            }
        }
    }
}

