//
//  NavigationController.swift
//  TestWork
//
//  Created by Anastasia on 6/12/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    var shouldRotate: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        //return shouldRotate ? UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.RawValue(Int(UIInterfaceOrientationMask.portrait.rawValue))) : UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.RawValue(Int(UIInterfaceOrientationMask.all.rawValue)))
//
//        return shouldRotate ? UIInterfaceOrientation.portrait.rawValue : UIInterfaceOrientation.
//    }
//
//    override var shouldAutorotate: Bool{
//        return shouldRotate
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


