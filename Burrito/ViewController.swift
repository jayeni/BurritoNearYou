//
//  ViewController.swift
//  Burrito
//
//  Created by Jeremiah Ayeni on 8/23/18.
//  Copyright © 2018 Jeremiah Ayeni. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController:UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, UICollectionViewDelegateFlowLayout  {
 
    
    let cellid = "cellid"
    let locationManger = CLLocationManager()
    var selectedPlace: BurritoPlace?
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var places: [BurritoPlace]?
    var tableV: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManger.requestWhenInUseAuthorization()
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.startUpdatingLocation()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.startUpdatingLocation()
            latitude = (locationManger.location?.coordinate.latitude) as! Double
            longitude = (locationManger.location?.coordinate.longitude) as! Double
            searchPlaceFromGoogle()
            
        }
        tableV.frame = view.frame
        tableV.register(BurritoCell.self, forCellReuseIdentifier: cellid)
        tableV.delegate = self
        tableV.dataSource = self
        tableV.estimatedRowHeight = 44
        tableV.rowHeight = UITableViewAutomaticDimension
        tableV.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
        tableV.estimatedRowHeight = 100
      
        view.addSubview(tableV)
        
  
        navigationItem.title = "Burrito Places"


        
        
        //tableView?.register(BurritoCell.self, forCellReuseIdentifier: cellid)
        //fetchplace()
       

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid) as! BurritoCell
        /*
        cell.Burrito = places[indexPath.row]
*/
        cell.Location.numberOfLines = 0
        cell.placeName.numberOfLines = 0
 
        cell.Burrito = places?[indexPath.section]
        //For bottom border to tv_title;
      
        
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
 
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 10
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
       
        cell.clipsToBounds = true
        
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(places?.count)
        return 1
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return places?.count ?? 0
    
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        return headerView
    }
    
        

 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
   
    


    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        let mV = MapView(collectionViewLayout: layout)
        mV.selectedPlace = places?[indexPath.section]
        navigationController?.pushViewController( mV , animated: true)
    }
   

    func searchPlaceFromGoogle() {
        
        var url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=1500&type=food&keyword=burrito&key=AIzaSyB6nkRxx4L-HxcB6HJT-bWHJ5CzbEpIgSk"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, resopnse, error) in
            if error == nil {
                let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                self.places = [BurritoPlace]()
                
                if let d = json as? Dictionary<String, AnyObject>{
                    if let results = d["results"] as? [Dictionary<String, AnyObject>]{
                
                for dict in results {
                    let burr = BurritoPlace()
                    burr.Name = dict["name"] as? String
                    let tmp = dict["geometry"]!["location"]! as? [String:AnyObject]
                 
                    burr.Lat = tmp!["lat"] as? Double
                    burr.Lng = tmp!["lng"] as? Double
                    burr.Location  = dict["vicinity"] as? String
                   
    
                    self.places?.append(burr)
                    
                }
                }
                }
               //
           //print("json == \(json)")
            }
            DispatchQueue.main.async {
                self.tableV.reloadData()
            }
   
        }
        task.resume()
    }



    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

