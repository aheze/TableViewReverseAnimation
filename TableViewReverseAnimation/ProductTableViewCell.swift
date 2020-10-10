//
//  ProductTableViewCell.swift
//  TableViewReverseAnimation
//
//  Created by Zheng on 10/10/20.
//

import UIKit

protocol CartDelegate {
    func updateCart(cell: ProductTableViewCell)
}

class ProductTableViewCell: UITableViewCell {
    
    /// delete this, you never use it -aheze
    weak var myParent:ProductViewController?
    
    @IBOutlet weak var imagename: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    var buttonSelected = false
    
    var delegate: CartDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addToCartButton.layer.cornerRadius = 5
        addToCartButton.clipsToBounds = true
    }
    
    func setButton(state: Bool) {
        /// Make a seperate variable for the state -aheze
        
//        addToCartButton.isUserInteractionEnabled = true
//        addToCartButton.isSelected = state
        
        buttonSelected = state
        addToCartButton.backgroundColor = (buttonSelected) ? .red : .blue /// red for selected, blue for not selected -aheze
    }
    
    @IBAction func addToCart(_ sender: Any) {
        print("Up inside")
        setButton(state: !buttonSelected) /// set the opposite state
        self.delegate?.updateCart(cell: self)
    }
}
