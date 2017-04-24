//
//  CartService.swift
//  Swift_MVP
//
//  Created by Agus Cahyono on 4/23/17.
//  Copyright © 2017 balitax. All rights reserved.
//

import Foundation

class CartService {
	
	// the service delivers mocked data with a delay
	func getCarts(callBack: @escaping ([Cart]) -> Void) {
		
		let carts = [
			Cart(namaBarang: "Sepatu Adidas N34", jumlahBarang: 1, beratBarang: 0.8, hargaBarang: 350000, namaPemesan: "Agus Cahyono", alamatPemesan: "Jl. Taman Bunga Merak II Kav. 67, Malang"),
			Cart(namaBarang: "Speaker Xiaomi Bluetooth", jumlahBarang: 1, beratBarang: 0.5, hargaBarang: 150000, namaPemesan: "Agus Cahyono", alamatPemesan: "Jl. Taman Bunga Merak II Kav. 67, Malang"),
			Cart(namaBarang: "Kaos Damn I Love Indonesia, XXXL", jumlahBarang: 1, beratBarang: 0.3, hargaBarang: 100000, namaPemesan: "Agus Cahyono", alamatPemesan: "Jl. Taman Bunga Merak II Kav. 67, Malang"),
		]
		
		let delayTime = DispatchTime.now() + 2
		DispatchQueue.main.asyncAfter(deadline: delayTime) {
   			callBack(carts)
		}
	}
	
}






















