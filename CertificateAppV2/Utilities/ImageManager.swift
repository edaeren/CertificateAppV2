//
//  ImageManager.swift
//  CertificateAppV2
//
//  Created by Taha  Adıgüzel on 29.04.2024.
//

import Foundation
import FirebaseStorage // resimleri ve videoları tutar
import UIKit

//Resmi cache kaydediyoruz ki her seferinde indirmesin
let imageCache = NSCache<AnyObject, UIImage>()

class ImageManager{
    
    //MARK : PROPERTIES
    
    static let instance = ImageManager()
    
    private var REF_STOR = Storage.storage()
    
    //MARK: PUBLIC FUNCTIONS
    
        
    func uploadProfileImage(userID:String, image: UIImage){
        
        //get the path where we will save the image
        let path = getProfileImagePath(userID: userID)
        
        //Save image to path
        uploadImage(path: path, image: image) {(_) in }
        
    }
    
    func downloadProfileImage(userID: String, handler: @escaping (_ image : UIImage?) -> ()){
        
        //Get Path
        let path  = getProfileImagePath(userID: userID)
        
        //Download image
        downloadImage(path: path){ (returnedImage) in
            handler(returnedImage)
        }
    }
    
    //MARK: PRIVATE FUNCTIONS
    
    private func getProfileImagePath(userID:String)->StorageReference{
        let userPath = "users/\(userID)/profile"
        
        let storagePath = REF_STOR.reference(withPath: userPath)
        return storagePath
    }
    
    private func uploadImage(path:StorageReference, image: UIImage, handler: @escaping(_ success: Bool) -> ()){
        
        var compression : CGFloat = 1.0 //loops down by 0.05
        let maxFileSize: Int = 240 * 240 // max file size that we want to save // resmin max büyüklüğü
        let maxCompression: CGFloat = 0.05 // max comp. we allowed //bundan daha alağıya artık sıkıştırılmasın
        
        //Get image data
        guard var originalData = image.jpegData(compressionQuality: compression) else{
            print("Error hetting data from image")
            handler(false)
            return
        }

        //Check max file size
        //resmin boyutu istediğimiz boyuta inene kadar devam eder
        while (originalData.count > maxFileSize) && (compression > maxCompression){
            compression -= 0.05
            if let compressedData = image.jpegData(compressionQuality: compression){
                originalData = compressedData
            }
            print(compression)
        }
        
        //Get image data
        guard let finalData = image.jpegData(compressionQuality: compression) else{
            print("Error hetting data from image")
            handler(false)
            return
        }
        
        //get photo metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        path.putData(finalData,metadata: metadata){(_,error) in
        
            if let error = error{
                //Error
                print("Error uploading image. \(error)")
                handler(false)
                return
            } else {
                //Success
                print("Photo uploaded successfully")
                handler(true)
                return
            }
        }
    }
    
    private func downloadImage(path: StorageReference, handler: @escaping (_ image : UIImage?) -> () ){
        
        if let cachedImage = imageCache.object(forKey: path){
            print("image found in cache")
            handler(cachedImage)
        } else {
            path.getData(maxSize: 27 * 1024 * 1024) { (returnedImageData, error) in
                if let data = returnedImageData , let image  = UIImage(data: data){
                    //success
                    imageCache.setObject(image, forKey: path)
                    handler(image)
                    return
                } else {
                    print("Error getting image from path")
                    handler(nil)
                    return
                }
            }
        }
    }
    
}
