//
//  ImageViewController.swift
//  FireBase_DataBase_Storege
//
//  Created by Temur on 30/11/2021.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageViewer: UIImageView!
    var imageIs = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewer.image = imageIs

       
    }
    


}
