//
//  DataProduct.swift
//  cardapioSanduicheria
//
//  Created by Thiago Semão Pires on 15/07/22.
//

import Foundation


struct DataProduct: Codable {
    let products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case products = "produtos"
    }
}

struct Product: Codable {
    let name: String
    let brand: Brand?
    let code: Int
    let img: String?
    let price: String?
    let specialPrice: String?
    
    //let img: String
    //let preco: Int?
    //let preco_desconto: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "nome"
        case brand = "fabricante"
        case code = "codigo"
        case img
        case price = "preco"
        case specialPrice = "preco_desconto"
    }
}

struct Brand: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "nome"
    }
}
