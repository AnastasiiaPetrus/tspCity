//
//  Controller.swift
//  TestWork
//
//  Created by Anastasia on 6/8/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class Controller: NSObject{
    let text: String = ""
    var url: URL?
    let donwloader: Downloader = Downloader()
    
    func urlDetector(inputText: String) -> Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: inputText, options: [], range: NSRange(location: 0, length: inputText.utf16.count))
        var findURL = false
        for match in matches {
            findURL = true
            guard let range = Range(match.range, in: inputText) else { continue }
            url = URL(string: "\(inputText[range])")!
        }
        return findURL
    }
    
    
    func donwloadImage(){
        let utilityQueue = DispatchQueue.global(qos: .utility)
        Alamofire.request("\(url!)")
            .responseImage { response in
                if let image = response.result.value {
                    self.donwloade = image
                }
            }
            .downloadProgress(queue: utilityQueue, closure: { progress in
                DispatchQueue.main.async() {
                    self.progressBar.progress = Float(progress.fractionCompleted)
                }
            })
    }
}
