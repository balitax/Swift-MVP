//
//  CartPresenter.swift
//  Swift_MVP
//
//  Created by Agus Cahyono on 4/23/17.
//  Copyright © 2017 balitax. All rights reserved.
//

import Foundation

class CartPresenter {
	
	private let cartService: CartService
	weak private var cartView: CartView?
	
	init(cartService: CartService) {
		self.cartService = cartService
	}
	
	func attachView(view: CartView) {
		cartView = view
	}
	
	func detachView() {
		cartView = nil
	}
	
	func getCarts() {
		
		self.cartView?.startLoading()
		cartService.getCarts { [weak self] carts in
			self?.cartView?.finishLoading()
			if carts.count == 0 {
				self?.cartView?.setEmptyCarts()
			} else {
				let mappedCarts = carts.map({ data in
					return CartViewData(namaBarang: data.namaBarang , hargaBarang: data.hargaBarang)
				})
				self?.cartView?.setCarts(carts: mappedCarts)
			}
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
