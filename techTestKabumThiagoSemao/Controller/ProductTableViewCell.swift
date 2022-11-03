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
        btBuy.layer.cornerRadius = 5
        btBuy.clipsToBounds = true
        
        ivProduct.layer.cornerRadius = 5
        ivProduct.clipsToBounds = true
    }
    
    
    func shadowEffect() {
        self.btBuy.layer.shadowColor = UIColor.gray.cgColor
        self.btBuy.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.btBuy.layer.shadowRadius = 10
        self.btBuy.layer.shadowOpacity = 0.5
        self.btBuy.layer.shadowPath = nil
        
        
        
        ivProduct.layer.shadowColor = UIColor.lightGray.cgColor
        ivProduct.layer.shadowRadius = 6.0
        ivProduct.layer.shadowOpacity = 0.5
        ivProduct.layer.shadowOffset = CGSize(width: 5, height: 5)
        ivProduct.layer.shadowPath = nil
        ivProduct.layer.borderColor = .init(gray: 3, alpha: 5)
    }
    
   
    
    func prepare(with product: Product) {
        //lbPhaseOne.text = "\(phaseOne.title)"
       // ivWallPaper.image = UIImage(named: phaseOne.title)
        //ivWallPaper.image = UIImage(named: "\(phaseOne.wallpaper).png")
        //ivWallPaper.kf.setImage(with: URL(string: phaseOne.wallpaper))
        ivProduct.kf.setImage(with: URL(string: product.img ?? ""))
        tfBrand.text = product.brand?.name
        tfProductDescript.text = product.name
        tfFullPrice.text = "\("R$ " + (product.specialPrice ?? " "))"
        tfSpecialPrice.text = "\("R$ " + (product.price ?? " ") + " em até 10x")"
        
        
    }

}
