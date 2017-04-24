//
//  CartViewController.swift
//  Swift_MVP
//
//  Created by Agus Cahyono on 4/23/17.
//  Copyright © 2017 balitax. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
	
	// OUTLETS
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var emptyView: UIView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	

	// VARIABLES
	private let cartPresenter = CartPresenter(cartService: CartService())
	var cartToDisplay         = [CartViewData]()
	var tempCartToDisplay     = [CartViewData]()
	var refreshControll		  = UIRefreshControl()
	var objects 			  = NSMutableArray()
	var leftBarButton: ENMBadgedBarButtonItem?
	var count 				  = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.dataSource = self
		activityIndicator.hidesWhenStopped = true
		
		cartPresenter.attachView(view: self)
		cartPresenter.getCarts()
		
		self.tableView.refreshControl = refreshControll
		self.refreshControll.addTarget(self, action: #selector(self.initPullRefresh(_:)), for: .valueChanged)
		
		self.setUpLeftBarButton()
		

	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
	}
	
	func initPullRefresh(_ refresh: UIRefreshControl) {
		
		let delayTime = DispatchTime.now() + 2
		DispatchQueue.main.asyncAfter(deadline: delayTime) {
			
			self.cartToDisplay = self.tempCartToDisplay
			
			self.count = self.cartToDisplay.count
			self.leftBarButton?.badgeValue = "\(self.count)"
			
			self.tableView.reloadData()
			refresh.endRefreshing()
			
		}

		
		
	}
	
	func setUpLeftBarButton() {
		
		let image = UIImage(named: "cart")
		let button = UIButton(type: .custom)
		if let knownImage = image {
			button.frame = CGRect(x: 0.0, y: 0.0, width: knownImage.size.width, height: knownImage.size.height)
		} else {
			button.frame = CGRect.zero;
		}
		
		button.setBackgroundImage(image, for: UIControlState())
		
		let newBarButton = ENMBadgedBarButtonItem(customView: button, value: "5")
		leftBarButton = newBarButton
		navigationItem.leftBarButtonItem = leftBarButton
	}
	
	func formatCurrency(value: Double) -> String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.maximumFractionDigits = 2;
		formatter.locale = Locale(identifier: "id_ID")
		var result = formatter.string(from: value as NSNumber);
		result = result?.replacingOccurrences(of: "Rp", with: "Rp. ")
		return result!
	}
	
	func deleteData(index: Int) {
		
		self.tableView.beginUpdates()
		cartToDisplay.remove(at: index)
		
		let indexPath = IndexPath(row: index, section: 0)
		self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
		
		count = cartToDisplay.count
		leftBarButton?.badgeValue = "\(count)"
		
		self.tableView.endUpdates()
	}
	
}

extension CartViewController: CartView {
	
	func startLoading() {
		activityIndicator.startAnimating()
	}
	
	func finishLoading() {
		activityIndicator.stopAnimating()
	}
	
	func setCarts(carts: [CartViewData]) {
		cartToDisplay = carts
		tempCartToDisplay = carts
		self.tableView.isHidden = false
		self.emptyView.isHidden = true
		
		count = cartToDisplay.count
		leftBarButton?.badgeValue = "\(count)"
		
		self.tableView.reloadData()
	}
	
	func setEmptyCarts() {
		self.tableView.isHidden = true
		self.emptyView.isHidden = false
	}
	
}


extension CartViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cartToDisplay.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cart")
		let cartViewData = cartToDisplay[indexPath.row]
		
		cell.textLabel?.text = cartViewData.namaBarang
		cell.detailTextLabel?.text = self.formatCurrency(value: cartViewData.hargaBarang)
		
		return cell
		
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		
		if editingStyle == .delete {
			self.deleteData(index: indexPath.row)
		}
		
	}
	
	
}






























































