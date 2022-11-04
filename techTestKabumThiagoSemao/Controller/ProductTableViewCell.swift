//
//  ProductTableViewCell.swift
//  techTestKabumThiagoSemao
//
//  Created by Thiago Semão Pires on 28/10/22.
//

import UIKit
import Foundation
import Kingfisher
import CurrencyFormatter



class ProductTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ivProduct: UIImageView!
    @IBOutlet weak var tfBrand: UILabel!
    @IBOutlet weak var tfProductDescript: UILabel!
    @IBOutlet weak var tfFullPrice: UILabel!
    @IBOutlet weak var tfSpecialPrice: UILabel!
    @IBOutlet weak var btBuy: UIButton!
    @IBOutlet weak var btFavorite: UIButton!
    @IBOutlet weak var btCart: UIButton!

 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cornerRadius()
        shadowEffect()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cornerRadius() {
        self.btBuy.layer.cornerRadius = 5
        self.btBuy.clipsToBounds = true
        
        self.ivProduct.layer.cornerRadius = 10
        
    }
    
    
    func shadowEffect() {
   
        self.ivProduct.layer.cornerRadius = 15
        self.ivProduct.clipsToBounds = false
        self.ivProduct.layer.masksToBounds = false
        self.ivProduct.layer.shadowRadius = 2
        self.ivProduct.layer.shadowOpacity = 0.6
        self.ivProduct.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.ivProduct.layer.shadowColor = UIColor.black.cgColor
    
    }
    
    
    func prepare(with product: Product) {
        ivProduct.kf.setImage(with: URL(string: product.img ?? ""))
        tfBrand.text = product.brand?.name
        tfProductDescript.text = product.name
        tfFullPrice.text = "\("R$ " + (product.specialPrice ?? " "))"
        tfSpecialPrice.text = "\("R$ " + (product.price ?? " ") + " em até 10x")"
    }

}

