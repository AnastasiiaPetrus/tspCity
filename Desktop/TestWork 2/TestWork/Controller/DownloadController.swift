//
//  DownloadController.swift
//  TestWork
//
//  Created by Anastasia on 6/12/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DownloadController: NSObject {
    //let imageDownloadViewController: ImageDownloadViewController = ImageDownloadViewController()
    
    func urlDetector(inputText: String) -> (Bool, URL) {
        var url: URL? = nil
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: inputText, options: [], range: NSRange(location: 0, length: inputText.utf16.count))
        var findURL = false
        for match in matches {
            findURL = true
            guard let range = Range(match.range, in: inputText) else { continue }
            url = URL(string: "\(inputText[range])")!
        }
        return (findURL, url!)
    }
    
    
    //func donwloadImage(url: URL) -> (UIImage, Float){
    func donwloadImage(url: URL){
//        var resultImage: UIImage = UIImage()
//        var progressToReturn: Float = 0
        let utilityQueue = DispatchQueue.global(qos: .utility)
        Alamofire.request("\(url)")
            .responseImage { response in
                if let image = response.result.value {
                    //resultImage = image
                    self.imageView.image = image
                }
            }
            .downloadProgress(queue: utilityQueue, closure: { progress in
                DispatchQueue.main.async() {
                    //progressToReturn = Float(progress.fractionCompleted)
                    self.progressBar.progress = Float(progress.fractionCompleted)
                }
            })
        //return (resultImage, progressToReturn)
    }
}
