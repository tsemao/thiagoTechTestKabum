//
//  LoadingCell.swift
//  techTestKabumThiagoSemao
//
//  Created by Thiago Semão Pires on 02/11/22.
//

import UIKit



class LoadingCell: UITableViewCell {
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
