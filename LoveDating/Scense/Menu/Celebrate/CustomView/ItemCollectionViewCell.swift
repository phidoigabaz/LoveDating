//
//  ItemCollectionViewCell.swift
//  LoveDating
//
//  Created by Tạ Thành Đạt on 5/13/19.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

protocol ItemCollectionViewCellDelegate: NSObjectProtocol {
    func didSelectInsert(_ cell: ItemCollectionViewCell, sender: Any)
}
class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbaiImageView: UIImageView!
    weak var delegate: ItemCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onInsertActionPressed(_ sender: Any) {
        delegate?.didSelectInsert(self, sender: sender)
    }
}
