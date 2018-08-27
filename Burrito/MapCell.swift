//
//  MapCell.swift
//  Burrito
//
//  Created by Jeremiah Ayeni on 8/26/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//

import UIKit
import GoogleMaps

class MapCell : UICollectionViewCell{
    var lng: Double = 0.0
    var lat: Double = 0.0
    var Burrito:BurritoPlace?{
        didSet{
            Loc.text = Burrito?.Location
            lng = (Burrito?.Lng)!
            lat = (Burrito?.Lat)!
     
        }
    }
  
    override func layoutSubviews() {
        self.backgroundColor = UIColor(red:0.48, green:0.00, blue:1.00, alpha:1.0)
        Loc.frame = CGRect(x: 0, y: -280, width: contentView.frame.width, height: contentView.frame.height)
        GMSServices.provideAPIKey("AIzaSyB6nkRxx4L-HxcB6HJT-bWHJ5CzbEpIgSk")

        let camera = GMSCameraPosition.camera(withLatitude:  lat , longitude: lng, zoom: 15)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D( latitude:  lat , longitude: lng)
        marker.title = "Pin"
        marker.map = mapView
        marker.icon = UIImage(named: "Pin")
        mapView.frame = CGRect(x: 0, y: 120 , width: contentView.frame.width, height: contentView.frame.height-120)
        addSubview(mapView)
        addSubview(Loc)
        
        
        }
    override init(frame: CGRect){
        super.init(frame: frame)
        

    }

    let Loc: UILabel = {
        let name = UILabel()
        name.textColor = UIColor.white
        name.textAlignment = .center
        name.font = UIFont.boldSystemFont(ofSize: 26)
        name.translatesAutoresizingMaskIntoConstraints=false
        return name
        
    }()

 
 
   

    

    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

