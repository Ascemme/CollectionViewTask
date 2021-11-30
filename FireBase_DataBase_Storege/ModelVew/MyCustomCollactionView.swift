//
//  MyCustomCollactionView.swift
//  FireBase_DataBase_Storege
//
//  Created by Temur on 28/11/2021.
//

import UIKit

class MyCustomCollactionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    

    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        //cell.mylable.text = String(indexPath.row)
        cell.backgroundColor = UIColor.gray
        return cell
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
