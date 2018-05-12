//
//  MemeDetailViewController.swift
//  MemeVersion1
//
//  Created by Shane Sealy on 5/5/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var memeItem: Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.label.text = self.memeItem.topTextField
        self.tabBarController?.tabBar.isHidden = true
        self.imageView!.image = memeItem.memedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
