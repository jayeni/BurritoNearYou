//
//  MapView.swift
//  Burrito
//
//  Created by Jeremiah Ayeni on 8/26/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//

import UIKit


class MapView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var cellID = "cellId"
    var selectedPlace: BurritoPlace?
   
    override func viewDidLoad() {
        super.viewDidLoad()
   
        collectionView?.register(MapCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.backgroundColor = UIColor.white
        navigationItem.title = selectedPlace?.Name
        
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MapCell
        
        cell.Burrito = selectedPlace
        
        cell.layer.cornerRadius = 12
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width-20, height: UIScreen.main.bounds.size.height-100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(20,20,20,20)
    }
    
    
    
}

