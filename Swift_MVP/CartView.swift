//
//  CartView.swift
//  Swift_MVP
//
//  Created by Agus Cahyono on 4/23/17.
//  Copyright © 2017 balitax. All rights reserved.
//

import Foundation

protocol CartView: NSObjectProtocol {
	
	func startLoading()
	func finishLoading()
	func setCarts(carts: [CartViewData])
	func setEmptyCarts()
	
}
