//
//  NetworkViewController.swift
//  TestWork
//
//  Created by Anastasia on 6/7/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//
/*
import UIKit
import Foundation
//import Kingfisher

class NetworkViewController: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate{
    /*https://avatars.mds.yandex.net/get-pdb/931085/f7d8ba48-e7ce-4204-8e74-f127f914ddc0/orig
    https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Ultraviolet_image_of_the_Cygnus_Loop_Nebula_crop.jpg/1382px-Ultraviolet_image_of_the_Cygnus_Loop_Nebula_crop.jpg
     https://o.aolcdn.com/images/dims?quality=85&image_uri=https%3A%2F%2Fo.aolcdn.com%2Fimages%2Fdims%3Fcrop%3D960%252C540%252C0%252C0%26quality%3D85%26format%3Djpg%26resize%3D1600%252C900%26image_uri%3Dhttps%253A%252F%252Fs.yimg.com%252Fos%252Fcreatr-uploaded-images%252F2019-04%252F9c886110-5ad8-11e9-bedf-db47a0cc62de%26client%3Da1acac3e1b3290917d92%26signature%3D88a5ca35561c838cff668d8831e8da84757adc01&client=amp-blogside-v2&signature=f94770c535a0af9465d8b30dbd5a3eaa7890d4e2
     https://media.playstation.com/is/image/SCEA/horizon-zero-dawn-impact-poster-ps4-us-07feb17?$native_nt$ */

    var url : URL?
    var defaultSession: URLSession?
    var downloadTask: URLSessionDownloadTask?
    var imagePath: URL?
    var tempImage: UIImage? = nil
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var progressOfDownloading: UIProgressView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var downloadButtonOutlet: UIButton!
    @IBAction func downloadButtonAction(_ sender: Any) {
        if imagePath != nil {
            removeOldDownloadedData()
        }
        //imageView.image = nil
        progressOfDownloading.progress = 0
        let inputText = textField.text ?? ""
        let urlWasFound = urlDetector(inputText: inputText)
        if urlWasFound == true {
            downloadImage()
        } else {
            print("show allert with text:'There is no URL.'")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressOfDownloading.progress = 0
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        imagePath = location
//        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//            guard let data = data, error == nil else { return }
//            let tempImage = UIImage(data: data)
            DispatchQueue.main.async() {
//                self.downloadButtonOutlet.isEnabled = true
//                print("isEnabled = true")
                if self.progressOfDownloading.progress < 1 {
                    self.progressOfDownloading.setProgress(1, animated: true)
                }
                print("show image")
                self.imageView.image = self.tempImage
            }
        }
        task.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        if totalBytesExpectedToWrite > 0 {
            DispatchQueue.main.async {
                print("start")
                self.progressOfDownloading.setProgress(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite), animated: true)
//                self.progressOfDownloading.setProgress(self.updateProgressBar(totalBytesWritten: totalBytesWritten, totalBytesExpectedToWrite: totalBytesExpectedToWrite), animated: true)
                print("finish")
            }
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?){
        DispatchQueue.main.async {
            self.downloadButtonOutlet.isEnabled = true
            print("Task completed: \(task), error: \(error)")
        }
    }
    
//    func updateProgressBar(totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) -> Float {
//        //let smollestPartForRisingProgres = Float(totalBytesExpectedToWrite)/5
//        var currenProgressOnProgressBar: Float = 0
//        let currenDownloadProgress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
//        if currenDownloadProgress > currenProgressOnProgressBar {
//            currenProgressOnProgressBar += 0.2
//        }
//        return currenProgressOnProgressBar
//    }
    
    func removeOldDownloadedData(){
        let fileManager = FileManager.default
        let filePathName = ("\(imagePath!)" as NSString).lastPathComponent
        print(filePathName)
        try? fileManager.removeItem(atPath: filePathName)
    }
    
    func urlDetector(inputText: String) -> Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: inputText, options: [], range: NSRange(location: 0, length: inputText.utf16.count))
        var findURL = false
        for match in matches {
            findURL = true
            guard let range = Range(match.range, in: inputText) else { continue }
            url = URL(string: "\(inputText[range])")
            print(url!)
        }
        return findURL
    }
    
    func downloadImage() {
            DispatchQueue.main.async() {
                self.defaultSession = Foundation.URLSession(configuration: .default, delegate: self, delegateQueue: nil)
                self.progressOfDownloading.setProgress(0.0, animated: false)
                self.downloadTask = self.defaultSession?.downloadTask(with: self.url!)
                self.downloadButtonOutlet.isEnabled = false
                self.downloadTask?.resume()
        }
    }
    

    












//        DispatchQueue.main.async {
//            print("Download finished: \(location)")
//let data = NSData(contentsOf: location)
//            self.imageView.image = UIImage(contentsOfFile: location.absoluteString)

//func downloadImage() {
//    }


//if urlWasFound == true {
//            let task = downloadsSession?.downloadTask(with: url!)
//            task?.resume()
//            downloadImage()
//        }
//        let task = URLSession.shared.dataTask(with: url) {data, response, error in
//            guard let data = data, error == nil else { return }
//        }
//
//        // Don't forget to invalidate the observation when you don't need it anymore.
//        let observation = task.progress.observe(\.fractionCompleted) { progress, _ in
//            print(progress.fractionCompleted)
//        }
//
//        task.resume()



//    func decodeHTML(url: String) -> String {
//        // encodedString should = a[0]["title"] in your case
//        guard let data = url.data(using: .utf8) else {
//            return nil
//        }
//        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
//            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.documentType.rawValue): NSAttributedString.DocumentType.html,
//            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.characterEncoding.rawValue): String.Encoding.utf8.rawValue
//        ]
//        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
//            return nil
//        }
//        return let decodedString = attributedString.string
//    }

//let aString = NSString(data: data!, encoding:4)
//            urlDetector(inputText: aString! as String)
//            self.imageView.image = getImage(url: url! as NSURL)


//if let filePath = Bundle.main.path(forResource: "imageName", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
//            imageView.contentMode = .scaleAspectFit
//            imageView.image = image
//        }

//        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//            guard let data = data, error == nil else { return }
//
//            DispatchQueue.main.async() {    // execute on main thread
//                self.imageView.image = UIImage(data: data)
//            }
//        }

//task.resume()
}
*/
