//
//  Upload.swift
//  FireBase_DataBase_Storege
//
//  Created by Temur on 30/11/2021.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import Combine

struct userModel{
    let url: String = ""
}




struct Upload{
    let publisherURL = PassthroughSubject<String,Never>()
    
    
    private var database = Database.database().reference()
    var textStreet = "Локация"
    var userName = "Ivan"
    var imageURL = [String]()
    
    
    
    
    //MARK: FireBASE using
    
    func firebaseInit(imageURL: String, postTime: String){
        
        print("click")
        print(postTime)
        let object: [String : String] = [
            "url": "url"
        ]
        database.child(textStreet).child(userName).child(postTime).setValue(imageURL)
    }
    
    //MARK: IMAGES uploadin to firebase
    
    func upload(image: UIImage){
        let dateFormatter : DateFormatter = DateFormatter()
        //  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "yyyy-dd-HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        let userTime = userName + "-" + dateString
        
        let ref = Storage.storage().reference().child("images").child(userTime)
        guard let imageData = image.jpegData(compressionQuality: 0.4) else {return}
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        ref.putData(imageData, metadata: metadata) { metadata, error in
            guard let _ = metadata else {
                return
            }
            ref.downloadURL { url, error in
                guard let url = url else {return}
                self.firebaseInit(imageURL: String(url.absoluteString), postTime: String(userTime))
            }
        }
        
        
    }
    
    
    
    
    func firebaseGeting(completed: @escaping ([String]) ->()){
        var urls = [String]()
        
        database.child(textStreet).child(userName).observeSingleEvent(of: .value, with: { snapshot in
            // Get user value
            let value = snapshot.value as? NSDictionary
            urls = (value!.allValues as? [String])!
            print("tut")
            //print(urls)
            publisherURL.send("urls")
            
            DispatchQueue.main.async {
                completed(urls)
            }
            
        }) { error in
            print(error.localizedDescription)
        }
        
    }
    
}

