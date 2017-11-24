//
//  ViewController.swift
//  HorizontalScrollingCards
//
//  Created by Heitem OULED-LAGHRIYEB on 11/24/17.
//  Copyright © 2017 Hidden Founders. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = collectionView.collectionViewLayout as! UICollectionViewDelegate
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? Cell {
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
}

