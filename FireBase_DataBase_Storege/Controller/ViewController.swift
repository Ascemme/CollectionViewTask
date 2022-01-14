//
//  ViewController.swift
//  FireBase_DataBase_Storege
//
//  Created by Temur on 26/11/2021.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class ViewController: UIViewController{
    
    
    //MARK: all global items
    
    @IBOutlet weak var colactionCustomView: UIView!
    @IBOutlet weak var addingButton: UIButton!
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var mycollcationView: UICollectionView!
    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var LocationLable: UILabel!
    @IBOutlet weak var myTable: UICollectionView!
    var textStreet = "Локация"
    var backView = UIView()
    var image = UIImageView()
    var urlsArray = [String]()
    
    var imagesArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
        viewInit()
        Upload().firebaseGeting { urls in
            for imagURl in urls{
                if let imageURL = URL(string: imagURl){
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: imageURL)
                        if let data = data{
                            let image = UIImage(data: data)
                            DispatchQueue.main.async {
                                self.imagesArray.append(image!)
                                self.mycollcationView.reloadData()
                            }
                        }
                    }
                }
            }
            
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    //MARK: customacing itemes in storyboard
    func viewInit(){
        LocationLable.text = textStreet
        textInput.text = textStreet
        mycollcationView.layer.cornerRadius = 20
        mycollcationView.layer.masksToBounds = true
        colactionCustomView.layer.cornerRadius = 20
        colactionCustomView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
        addingButton.frame = CGRect(x: 335, y: 20, width: 30, height: 30)
        addingButton.layer.cornerRadius = 15
        addingButton.layer.masksToBounds = true
        
        self.tableView.layer.shadowColor = UIColor.lightGray.cgColor
        self.tableView.layer.shadowRadius = 10.0
        self.tableView.layer.shadowOpacity = 6.0
        self.tableView.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.tableView.layer.masksToBounds = false
        
        
    }
    
    
    //MARK: loading from firebase
    
    
    @IBAction func addingButton(_ sender: Any) {
        imageAddingFunc()
    }
    
    
    
    //MARK: image picker
    func imageAddingFunc(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    
}

//MARK: Extentions

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imagesArray.count != 0{
            return imagesArray.count
        }
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        if imagesArray.count != 0{
            cell.cellImage.image = imagesArray[indexPath.row]
        }
        cell.backgroundColor = UIColor.lightGray
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = false
        cell.customImage()
        return cell
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        imagesArray.append(image)
        let loading = Upload()
        loading.upload(image: image)
        self.mycollcationView.reloadData()
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openImage", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ImageViewController{
            destination.imageIs = imagesArray[(mycollcationView.indexPathsForSelectedItems?.first!.row)!]
        }
    }
}

