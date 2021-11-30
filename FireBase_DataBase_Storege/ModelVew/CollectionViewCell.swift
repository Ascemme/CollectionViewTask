//
//  CollectionViewCell.swift
//  FireBase_DataBase_Storege
//
//  Created by Temur on 28/11/2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var cellImage: UIImageView!
    func customImage(){
        self.cellImage.layer.cornerRadius = 20
        self.cellImage.layer.masksToBounds = true
    }
}
