//
//  MemeDetailViewController.swift
//  MemeVersion1
//
//  Created by Shane Sealy on 5/5/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    // Mark: Property
    
    var memeItem: Meme!
    
    // Mark: IBOutlet
    
    @IBOutlet weak var imageView: UIImageView!
    
    // Mark: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.imageView!.image = memeItem.memedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
