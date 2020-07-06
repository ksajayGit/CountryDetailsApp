//
//  CountryDetailsViewController.swift
//  CountryDetailsApp
//
//  Created by MyHome on 14/06/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    // MARK: UI elements declaration
    let countrytableView = UITableView()
    let networkStatusLabel = UILabel()
    var refreshControl: UIRefreshControl!
    var loadingOverlay: UIView!
    var countryData: CountryViewModel?
    var serviceCall: ServiceCalls? {
        didSet{
            guard let service = serviceCall else { return }
            countryData = CountryViewModel(serviceCall: service)
            initializeClosures()
        }
    }
    var isNetworkReachable = false
    let reachability = try? Reachability()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        setupReachabilityHandler()
        setupContentView()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged(note:)),
                                               name: .reachabilityChanged,
                                               object: reachability)
        do{
            try reachability?.startNotifier()
        }catch{
            print(REACHABILITY_NOTIFIER_FAILED)
        }
    }
}

extension CountryDetailsViewController{
    // MARK: Reachability Code setup
    func setupReachabilityHandler() {
        if reachability?.connection == Reachability.Connection.unavailable {
            isNetworkReachable = false
        } else {
            isNetworkReachable = true
        }
    }
    // MARK: Reahability Change notification
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi, .cellular:
                self.isNetworkReachable = true
        case .none, .unavailable:
                self.isNetworkReachable = false
        }
        toggleNetworkStatusLabel()
    }
    // MARK: Set UI View elements
    func setupContentView() {
        // MARK: Add TableView to Controller
        view.addSubview(countrytableView)
        view.addSubview(networkStatusLabel)
        view.bringSubviewToFront(networkStatusLabel)
        //MARK: Network Status Label setp up
        networkStatusLabel.alpha = 0
        networkStatusLabel.numberOfLines = 0
        networkStatusLabel.textAlignment = .center
        networkStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        networkStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        networkStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        networkStatusLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
        networkStatusLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0).isActive = true
        // MARK: TableView Layout Contraints
        countrytableView.dataSource = self
        countrytableView.translatesAutoresizingMaskIntoConstraints = false
        countrytableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        countrytableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        countrytableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        countrytableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        // MARK: Register TableViewCell
        countrytableView.register(CountryDetailTableViewCell.self,
                                  forCellReuseIdentifier: COUNTRY_DETAIL_CELL_NAME)
        // MARK: Add Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.lightGray.withAlphaComponent(0.5)
        refreshControl.addTarget(self, action: #selector(refreshCountryData), for: UIControl.Event.valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: PULL_TO_REFRESH)
        countrytableView.addSubview(refreshControl)
        // MARK: Adding Loading overlay
        loadingOverlay = LoadingOverlayView(frame: view.frame)
        view.addSubview(loadingOverlay)
        loadingOverlay.center = view.center
        
        // MARK: getData for Country TableView
        self.getCountryDetails()
    }
    // MARK: NetworkChange label
    func toggleNetworkStatusLabel() {
        DispatchQueue.main.async {
            if self.isNetworkReachable {
                self.networkStatusLabel.text = NETWORK_ONLINE
                self.networkStatusLabel.backgroundColor = .green
            } else {
                self.networkStatusLabel.text = NETWORK_OFFLINE
                self.networkStatusLabel.backgroundColor = .red
            }
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.networkStatusLabel.alpha = 1.0
            }) { (finished) in
                UIView.animate(withDuration: 0.5, delay: 3, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self.networkStatusLabel.alpha = 0.0
                }, completion: nil)
            }
        }
    }
}

extension CountryDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryData?.countryDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: COUNTRY_DETAIL_CELL_NAME, for: indexPath) as! CountryDetailTableViewCell
        cell.countryInfo = countryData?.countryDetails?[indexPath.row]
        return cell
    }
}

extension CountryDetailsViewController{
    //MARK: Core Logic
    func initializeClosures() {
        countryData?.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                guard let _ = self?.countryData?.error else { return }
                self?.showDataLoadingErrorAlert()
            }
        }
        
        countryData?.updateLoadingStatus = { [weak self] in
            DispatchQueue.main.async {
                let _ = self?.countryData?.isLoading ?? false ? self?.showLoadingOverlay() : self?.hideLoadingOverlay()
            }
        }
        
        countryData?.didFinishFetch = { [weak self] in
            DispatchQueue.main.async {
                self?.navigationItem.title = self?.countryData?.countryname
                self?.countrytableView.reloadData()
            }
        }
    }
    // MARK: Pull to refresh method
    @objc func refreshCountryData() {
        getCountryDetails()
    }
    func getCountryDetails() {
        guard self.isNetworkReachable == true else {
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.toggleNetworkStatusLabel()
            }
            return
        }
        self.countryData?.isLoading = true
        self.countryData?.fetchCountryDetails()
    }
    // MARK: showing loading overlay
    func showLoadingOverlay() {
        self.view.bringSubviewToFront(self.loadingOverlay)
        self.countrytableView.alpha = 0
        self.loadingOverlay.alpha = 0.5
    }
    // MARK: hiding loading overlay
    func hideLoadingOverlay() {
        self.view.sendSubviewToBack(self.loadingOverlay)
        self.loadingOverlay.alpha = 0
        self.countrytableView.alpha = 1
    }
    
    func showDataLoadingErrorAlert(){
        let networkAlert = UIAlertController(title: API_CALL_ERROR_ALERT,
                                             message: self.countryData?.error?.localizedDescription,
                                             preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        networkAlert.addAction(okButton)
        self.present(networkAlert, animated: true, completion: nil)
    }
}

