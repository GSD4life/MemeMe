//
//  SentMemesCollectionViewController.swift
//  MemeVersion1
//
//  Created by Shane Sealy on 5/16/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    // Mark: Property
    
    var memes: [Meme]!
    
    // Mark: IBOutlet
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // Mark: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 2.0
        let dimension = (view.frame.size.width - (2 * space)) / 2.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        self.collectionView?.reloadData()
    }
        
    // Mark: Helper function
        
    @IBAction func moveToMemeEditor() {
            let editorVC = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
            navigationController?.pushViewController(editorVC, animated: true)
    }

    // Mark: UICollectionView datasource protocols

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesCollectionViewCell", for: indexPath) as! SentMemesCollectionViewCell
    let memeItem = self.memes[indexPath.row]
    cell.memeMeImageView.image = memeItem.memedImage
    
    return cell
    }
    
    // Mark: UICollectionView delegate protocol
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.memeItem = self.memes[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }

}
