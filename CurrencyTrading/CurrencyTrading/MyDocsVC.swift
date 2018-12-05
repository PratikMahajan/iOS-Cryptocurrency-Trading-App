//
//  MyDocsVC.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/5/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import UIKit
import AWSCore
import AWSS3
import Photos

class MyDocsVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    @IBOutlet weak var uploadedImage: UIImageView!
    
    @IBOutlet weak var imageSelectButton: UIButton!
    var selectedImageUrl: URL!
    var myActivityIndicator: UIActivityIndicatorView!
    var username: String = ""
    
    func getData(){
        do{
            try dbQueue.read { db in
                let user = try User.fetchAll(db)
                username = user[0].username
            }
        }
        catch{
            print("Error in reading data")
        }
        
    }
    
    
    @IBAction func uploadPressed(_ sender: Any) {
        startUploadingImage()
    }
    
    
    @IBAction func selectImageAction(_ sender: Any) {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        self.dismiss(animated: true, completion: nil)
        let kk = info[UIImagePickerControllerPHAsset] as! PHAsset
        kk.getURL{ url in
            self.selectedImageUrl = url
            print (url)
        }
        uploadedImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        uploadedImage.backgroundColor = UIColor.clear
        uploadedImage.contentMode = UIViewContentMode.scaleAspectFit
//        self.dismiss(animated: true, completion: nil)
    }
    
    func generateImageUrl(fileName: String) -> NSURL
    {
        let fileURL = NSURL(fileURLWithPath: NSTemporaryDirectory().appending(fileName))
        let data = UIImageJPEGRepresentation(uploadedImage.image!, 0.6)
        do{
            try data!.write(to: fileURL as URL)}
        catch{
            print ("generate url error")
        }
        
        return fileURL
    }
    
    func remoteImageWithUrl(fileName: String)
    {
        let fileURL = NSURL(fileURLWithPath: NSTemporaryDirectory().appending(fileName))
        do {
            try FileManager.default.removeItem(at: fileURL as URL)
        } catch
        {
            print(error)
        }
    }
    
    
    
    func startUploadingImage()
    {
        
        print (selectedImageUrl)
        var localFileName:String?
        
        localFileName = username+".jpeg"
//        if let imageToUploadUrl = selectedImageUrl
//        {
//            let phResult = PHAsset.fetchAssets(withALAssetURLs: [imageToUploadUrl], options: nil)
//            localFileName = phResult.firstObject?.value(forKey: "filename") as? String
//        }
//
//        if localFileName == nil
//        {
//            print (localFileName)
//            print ("error here ")
//            return
//        }
        
        myActivityIndicator.startAnimating()
        
        // Configure AWS Cognito Credentials
        let myIdentityPoolId = "us-east-1:5ffdd6d8-cf99-40ad-abd3-ecbed3610cec"
        
        let credentialsProvider:AWSCognitoCredentialsProvider = AWSCognitoCredentialsProvider(regionType:AWSRegionType.USEast1, identityPoolId: myIdentityPoolId)
        
        let configuration = AWSServiceConfiguration(region:AWSRegionType.USEast1, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        // Set up AWS Transfer Manager Request
        let S3BucketName = "aedprojectvalidate"
        
        let remoteName = localFileName!
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest?.body = generateImageUrl(fileName: remoteName) as URL
        uploadRequest?.key = remoteName
        uploadRequest?.bucket = S3BucketName
        uploadRequest?.contentType = "image/jpeg"
        
        
        let transferManager = AWSS3TransferManager.default()
        
        // Perform file upload
        transferManager.upload(uploadRequest!).continueWith { (task) -> AnyObject? in
            
            DispatchQueue.main.async() {
                self.myActivityIndicator.stopAnimating()
            }
            
            if let error = task.error {
                print("Upload failed with error: (\(error.localizedDescription))")
            }
            
            if let exception = task.error {
                print("Upload failed with exception (\(exception))")
            }
            
            if task.result != nil {
                // Remove locally stored file
                self.remoteImageWithUrl(fileName: (uploadRequest?.key!)!)
                
                DispatchQueue.main.async() {
                    self.displayAlertMessage()
                }
                
                
            }
            else {
                print("Unexpected empty result.")
            }
            return nil
        }
        
    }
    
    
    
    
    
    
    
    func displayAlertMessage()
    {
        let alertController = UIAlertController(title: "Alert title", message: "Image has been uploaded", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
    
    
    
    
    func setUpActivityIndicator()
    {
        //Create Activity Indicator
        myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = true
        
        myActivityIndicator.backgroundColor = UIColor.white
        
        view.addSubview(myActivityIndicator)
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpActivityIndicator()
        getData()
        checkPermission()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized: print("Access is granted by user")
        case .notDetermined: PHPhotoLibrary.requestAuthorization({
            (newStatus) in print("status is \(newStatus)");
            if newStatus == PHAuthorizationStatus.authorized
            { print("success") }
            })
            case .restricted:
                print("User do not have access to photo album.")
            case .denied:
                print("User has denied the permission.")
            }

        }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension PHAsset {
    
    func getURL(completionHandler : @escaping ((_ responseURL : URL?) -> Void)){
        if self.mediaType == .image {
            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return true
            }
            self.requestContentEditingInput(with: options, completionHandler: {(contentEditingInput: PHContentEditingInput?, info: [AnyHashable : Any]) -> Void in
                completionHandler(contentEditingInput!.fullSizeImageURL as URL?)
            })
        } else if self.mediaType == .video {
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.version = .original
            PHImageManager.default().requestAVAsset(forVideo: self, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable : Any]?) -> Void in
                if let urlAsset = asset as? AVURLAsset {
                    let localVideoUrl: URL = urlAsset.url as URL
                    completionHandler(localVideoUrl)
                } else {
                    completionHandler(nil)
                }
            })
        }
    }
}
