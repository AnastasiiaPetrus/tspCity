//
//  ImageDownloadViewController.swift
//  TestWork
//
//  Created by Anastasia on 6/11/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AlamofireImage

class ImageDownloadViewController: UIViewController{
    @IBOutlet var textField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var progressBar: UIProgressView!
    
    var url : URL?
    
    @IBAction func downloadButtonAction(_ sender: Any) {
        reactionOfButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
        textField.clearButtonMode = .whileEditing
    }
    
    func findUrl(inputText: String) -> Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: inputText, options: [], range: NSRange(location: 0, length: inputText.utf16.count))
        var findURL = false
        for match in matches {
            findURL = true
            guard let range = Range(match.range, in: inputText) else { continue }
            url = URL(string:"\(inputText[range])")
        }
        return findURL
    }

    func downloadImage() {
        let utilityQueue = DispatchQueue.global(qos: .utility)
        if let url = url {
            Alamofire.request("\(url)")
                .responseImage { response in
                    if let image = response.result.value {
                        self.imageView.image = image
                    }
                }
                .downloadProgress(queue: utilityQueue, closure: { progress in
                    DispatchQueue.main.async() {
                        self.progressBar.progress = Float(progress.fractionCompleted)
                    }
                })
        }
    }
    
    func reactionOfButton(){
        progressBar.progress = 0.0
        let inputText = textField.text ?? ""
        if findUrl(inputText: inputText) == true {
            downloadImage()
        } else {
            let alert = UIAlertController(title: "Alert", message: "URL is invalid.\nPlease provide a valid URL", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
        reactionOfButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
        

