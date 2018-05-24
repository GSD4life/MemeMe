//
//  SentMemesTableViewController.swift
//  MemeVersion1
//
//  Created by Shane Sealy on 5/1/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    // Mark: Property
    
    var memes: [Meme]!
    
    // Mark: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Mark: Button action
    
    @IBAction func moveToMemeEditor() {
      let editorVC = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
      navigationController?.pushViewController(editorVC, animated: true)
    }
    
    // MARK: - TableView datasource protocols

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemesTableViewCell")
        let memeItem = self.memes[indexPath.row]
        cell?.textLabel?.text = memeItem.topTextField
        cell?.detailTextLabel?.text = memeItem.bottomTextField
        cell?.imageView?.image = memeItem.memedImage

        return cell!
    }
    
    // MARK: TableView delegate protocol
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.memeItem = self.memes[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }

}
