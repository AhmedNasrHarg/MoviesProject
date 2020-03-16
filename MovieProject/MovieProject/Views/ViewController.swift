//
//  ViewController.swift
//  MovieProject
//
//  Created by MacOSSierra on 3/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import CoreData


// the home controller view

class ViewController: UIViewController , UICollectionViewDataSource,UICollectionViewDelegate {
     var x:Int=0;
    var movies:[MovieModel] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UICollectionViewCell
        var img = cell.viewWithTag(1) as? UIImageView
        if(x==1){
            if Reachability.isConnectedToNetwork(){
                img?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185"+movies[indexPath.row].posterPath), placeholderImage: UIImage(named: "1.png"))
                
            }else{
                let image : UIImage = UIImage(named:"1.png")!
                img = UIImageView(image: image)
                
            }
            // Configure the cell
            print(indexPath.row)
            print(movies[indexPath.row].posterPath)
            
        }
        return cell
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("ha")
        return 1
    }
    var idx:Int!
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var nxt:MovieDetail=self.storyboard?.instantiateViewController(withIdentifier: "nxt") as! MovieDetail
        nxt.movie=movies[indexPath.row]
        self.navigationController?.pushViewController(nxt, animated: true)
    }
    func resetAllRecords(in entity : String) // entity = Your_Entity_Name
    {
        
        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        collectionView.dataSource=self
        collectionView.delegate=self;
       
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            Alamofire.request("https://api.themoviedb.org/3/discover/movie?api_key=f13adef6af7345c7e280404a20f85e3e").validate().responseJSON(){ response in
                if response.result.isSuccess{
                    guard let data = response.result.value as? [String:Any] else { return}
                    guard let json = data["results"] as? [Any] else{return}
                    //                print(json)
                    for i in 0 ... json.count-1{
                        let obj=json[i] as?[String:Any]
                        var id=obj?["id"] as? Int;
                        if id==nil{id=0}
                        var title=obj?["title"] as? String
                        if title==nil{title=""}
                        var posterPath=obj?["poster_path"] as? String
                        if posterPath==nil{posterPath=""}
                        var overview=obj?["overview"] as? String
                        if overview==nil{overview=""}
                        var releaseDate=obj?["release_date"] as? String
                        if releaseDate==nil{releaseDate=""}
                        var voteAverage=obj?["vote_average"] as? Double
                        if voteAverage==nil{voteAverage=0}
                        //                    print(id!)
                        //             "/xyuwZgYEFHxZH1aYbuXzgrZjaEj.jpg"       print(title!);print(posterPath!);print(overview!);print(releaseDate!);print(voteAverage!)
                        let mov:MovieModel=MovieModel(Id: id ?? 0, PosterPath: posterPath ?? "/xyuwZgYEFHxZH1aYbuXzgrZjaEj.jpg", Title: title ?? "", ReleaseDate: releaseDate ?? "", Rating: voteAverage ?? 0.0, Overview: overview ?? "")
                        self.movies.append(mov)
                        print(self.movies.count)
                        self.collectionView.reloadData()
                    }
                    self.collectionView.reloadData()
                    self.x=1
                    // add to core data
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let managedContext = appDelegate.persistentContainer.viewContext
                    let entity = NSEntityDescription.entity(forEntityName:"NewMovie",in: managedContext)
                    
                    for cur in 0...self.movies.count-1{
                        let movie = NSManagedObject( entity: entity! , insertInto: managedContext)
                        movie.setValue(self.movies[cur].title, forKey:"title")
                        movie.setValue(self.movies[cur].releaseDate, forKey:"releaseDate")
                        movie.setValue(self.movies[cur].rating, forKey:"rating")
                        movie.setValue(self.movies[cur].overview, forKey:"overview")
                        movie.setValue(self.movies[cur].id, forKey:"id")
                        movie.setValue(self.movies[cur].posterPath, forKey:"imagePath")
                    }
                    do{
                        try managedContext.save()
                    }catch let error as NSError{
                        
                    }
                }
                else{
                    print("fails")
                }
            }
            

            
        }else{
            print("Internet Connection not Available!")
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NewMovie")
            let myPredicate = NSPredicate(format: "title == %@" , "titleName")
            fetchRequest.predicate = myPredicate
            do {
                let records = try managedContext.fetch(fetchRequest)
                if (records.count>0)
                {
                    for i in 0...records.count-1{
                        
                        let match = records[i]
                        let curId=Int(match.value(forKey: "id") as! NSDecimalNumber)
                        var mv=MovieModel(Id: curId, PosterPath: match.value(forKey: "imagePath") as! String, Title: match.value(forKey: "title") as! String, ReleaseDate: match.value(forKey: "releaseDate") as! String, Rating: match.value(forKey: "rating") as! Double, Overview: match.value(forKey: "overview") as! String)
                        movies.append(mv)
                    }
                }
                
            }
            catch let error as NSError{
                NSLog(error.localizedDescription)
            }
            collectionView.reloadData()
        }
        print("done")
}

}
