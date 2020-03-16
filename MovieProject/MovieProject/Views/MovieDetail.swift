//
//  MovieDetail.swift
//  MovieProject
//
//  Created by MacOSSierra on 3/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire
import youtube_ios_player_helper
import SDWebImage
import CoreData

class MovieDetail: UIViewController,UITableViewDelegate,UITableViewDataSource ,UICollectionViewDelegate,UICollectionViewDataSource{
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    @IBOutlet weak var scrollScreen: UIScrollView!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var tableView: UITableView!
    
    var videosApi:String=""
    var reviewsApi:String=""
    var videosArr:[String]=[]
    var reviewArr:[ReviewModel]=[]
    var x:Int=0
    
    @IBOutlet weak var favouriteBtn: UIButton!
    
    var flag = false // in viewDidLoad after fetching if flag b2a true set image to be 1 not 6
    @IBAction func addToFavourite(_ sender: Any) {
        flag = !flag
        if flag{                                    //      [viiiiiiip]
            // add if not exist momkn f view did load ngiboh mn db lw mawgod set flag b true [vip] if cnt>0
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName:"Favourite",in: managedContext)
            let movie = NSManagedObject( entity: entity! , insertInto: managedContext)
            movie.setValue(movieTitle.text, forKey:"title")
            do{
                try managedContext.save()
            }catch let error as NSError{
                
            }
        }else{
            //remove
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourite")
            deleteFetch.predicate = NSPredicate.init(format:"title == %@" , movieTitle.text ?? "")
            do{
                let objects = try managedContext.fetch(deleteFetch)
                for object in objects {
                    managedContext.delete(object as! NSManagedObject)
                }
                try managedContext.save()
            }catch let error as NSError{
                
            }

        }
        setButtonImage()
    }
    func setButtonImage(){
        let imgName = flag ? "1" : "6"
        let image1 = UIImage(named: "\(imgName).png")!
        self.favouriteBtn.setImage(image1, for: .normal)
    }
    var movie:MovieModel=MovieModel(Id: 1, PosterPath: "", Title: "", ReleaseDate: "", Rating: 0.0, Overview: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource=self
        collectionView.delegate=self;
        scrollScreen.contentSize=CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+UIScreen.main.bounds.height/2)
        tableView.dataSource=self
        tableView.delegate=self
        movieTitle.text!=movie.title
        date.text!=movie.releaseDate
        overview.text!=movie.overview
        overview.isEditable = false
        rating.rating=movie.rating
        rating.settings.updateOnTouch=false
        image.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185"+movie.posterPath), placeholderImage: UIImage(named: "1.png"))
                
        let transformer = SDImageResizingTransformer(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3), scaleMode: .fill)
        image?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185"+movie.posterPath), placeholderImage: nil, context:   [.imageTransformer: transformer])
        
        
        let idStr = String(movie.id)
        videosApi="https://api.themoviedb.org/3/movie/"+idStr+"/videos?api_key=f13adef6af7345c7e280404a20f85e3e"
            reviewsApi="https://api.themoviedb.org/3/movie/"+idStr+"/reviews?api_key=f13adef6af7345c7e280404a20f85e3e"
        Alamofire.request(reviewsApi).validate().responseJSON(){ response in
            if response.result.isSuccess{
                guard let data = response.result.value as? [String:Any] else { return}
                guard let json = data["results"] as? [Any] else{return}
                //                print(json)
                if json.count>0{
                for i in 0 ... json.count-1{
                    let obj=json[i] as?[String:Any]
                    var author=obj?["author"] as? String;
                    if author==nil{author=""}
                    
                    var content=obj?["content"] as? String;
                    if content==nil{content=""}
                    print("nasr")
                    print(content)
                    var review=ReviewModel(Author: author ?? "", Content: content ?? "")
                    
                    self.reviewArr.append(review)
                    }
                }
//                self.collectionView.reloadData()
                self.collectionView.reloadData()
                self.x=1
                
            }
            else{
                print("fails")
            }
        }
        
        Alamofire.request(videosApi).validate().responseJSON(){ response in
            if response.result.isSuccess{
                guard let data = response.result.value as? [String:Any] else { return}
                guard let json = data["results"] as? [Any] else{return}
                //                print(json)
                for i in 0 ... json.count-1{
                    let obj=json[i] as?[String:Any]
                    var id=obj?["key"] as? String;
                    if id==nil{id=""}
                    
                    self.videosArr.append(id ?? "")
                    print("")
                   print(id!)
                    self.tableView.reloadData()
                }
                    self.tableView.reloadData()
                    self.x=1
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let managedContext = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourite")
                let myPredicate = NSPredicate(format: "title == %@" , self.movieTitle.text ?? "")
                fetchRequest.predicate = myPredicate
                do {
                    let records = try managedContext.fetch(fetchRequest)
                    if (records.count>0)
                    {
                        self.flag=true
                    }
                    
                }
                catch let error as NSError{
                    NSLog(error.localizedDescription)
                }
                let imgName = self.flag ? "1" : "6"
                let image1 = UIImage(named: "\(imgName).png")!
                self.favouriteBtn.setImage(image1, for: .normal)
            }
            else{
                print("fails")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videosCell", for: indexPath)
        let video=cell.viewWithTag(2) as! YTPlayerView
        if x==1{
            video.load(withVideoId: videosArr[indexPath.row])
            print("nonnna")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewArr.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReview", for: indexPath) as! UICollectionViewCell
                var author = cell.viewWithTag(1) as? UILabel
                var content = cell.viewWithTag(2)as? UITextView
        author?.text=reviewArr[indexPath.row].author
        content?.text=reviewArr[indexPath.row].content
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
