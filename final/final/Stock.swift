//
//  Stock.swift
//  final
//
//  Created by Adarsh Rao on 12/2/20.
//  Copyright © 2020 Adarsh Rao. All rights reserved.
//

import Foundation

struct Company: Codable {
    let symbol: String;
    let name: String;
    let sector: String;
}

struct Analysis: Codable {
    let buy: Int;
    let hold: Int;
    let sell: Int;
    let strongBuy: Int;
    let strongSell: Int;
}

struct fullCompany {
    let company: Company;
    let analysis: Analysis;
}
