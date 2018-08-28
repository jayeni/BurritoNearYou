//
//  BurritoCell.swift
//  Burrito
//
//  Created by Jeremiah Ayeni on 8/23/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//


import UIKit

class BurritoCell: UITableViewCell{
    var Burrito:BurritoPlace?{
        didSet{
            placeName.text = Burrito?.Name
            Location.text = Burrito?.Location
            
            
          
            
        }
    }
  
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    func setupCell(){
        
 
        placeName.frame = CGRect(x: 15, y: 20 , width: contentView.frame.width, height: contentView.frame.height)
        Location.frame = CGRect(x: 15, y: 60 , width: contentView.frame.width, height: contentView.frame.height)
        Image.frame = CGRect(x: 235, y: contentView.frame.midY+40 , width: contentView.frame.width, height: contentView.frame.height/2)
        
        
        
        addSubview(Image)
        addSubview(placeName)
        addSubview(Location)
    
    }

    var placeName: UILabel = {
        let name = UILabel()
        name.textColor = UIColor(red:0.48, green:0.00, blue:1.00, alpha:1.0)
        name.textAlignment = NSTextAlignment.left
        name.font = UIFont.boldSystemFont(ofSize: 24)
        name.translatesAutoresizingMaskIntoConstraints=false
        return name
        
    }()
    var Location: UILabel = {
        let name = UILabel()
        name.textColor = UIColor.darkGray
        name.textAlignment = NSTextAlignment.left
        name.font = UIFont.boldSystemFont(ofSize: 19)
        name.numberOfLines = 2
        name.translatesAutoresizingMaskIntoConstraints=false
        return name
        
    }()
    var Image: UIImageView = {
        let imageV = UIImageView()
        imageV.image =  UIImage(named: "Chevron")
        imageV.contentMode = .scaleAspectFit
        imageV.translatesAutoresizingMaskIntoConstraints=false;
        
        return imageV
    }()

        required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



