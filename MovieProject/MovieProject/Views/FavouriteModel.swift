//
//  FavouriteModelTableViewController.swift
//  MovieProject
//
//  Created by MacOSSierra on 3/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import CoreData
import Cosmos
import SDWebImage

class FavouriteModel: UITableViewController {
    
    var movies:[MovieModel] = []
    var titles:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // extract data from favourite table of core data and reload
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Favourite>(entityName: "Favourite")
        
        do {
            let records = try managedContext.fetch(fetchRequest)
            if (records.count>0)
            {
                for i in 0...records.count-1{
                    
                    let match = records[i]
                    let curTitle = match.value(forKey: "title") as! String
                    titles.append(curTitle)
                }
            }
            
        }
        catch let error as NSError{
            NSLog(error.localizedDescription)
        }
        
        let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
        let managedContext2 = appDelegate2.persistentContainer.viewContext
        let fetchRequest2 = NSFetchRequest<NewMovie>(entityName: "NewMovie")
        
        if titles.count>0{
        for j in 0...titles.count-1{
            let myPredicate = NSPredicate(format: "title == %@" , titles[j])
            fetchRequest2.predicate = myPredicate
            
            do {
                let records = try managedContext2.fetch(fetchRequest2)
                if (records.count>0)
                {
                        let match = records[0]
                        let curId=Int(match.value(forKey: "id") as! NSDecimalNumber)
                        var mv=MovieModel(Id: curId, PosterPath: match.value(forKey: "imagePath") as! String, Title: match.value(forKey: "title") as! String, ReleaseDate: match.value(forKey: "releaseDate") as! String, Rating: match.value(forKey: "rating") as! Double, Overview: match.value(forKey: "overview") as! String)
                        movies.append(mv)
                }
                
            }
            catch let error as NSError{
                NSLog(error.localizedDescription)
            }
        }
            tableView.reloadData()
    }
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
        
        var img = cell.viewWithTag(1) as? UIImageView
        var title = cell.viewWithTag(2) as? UILabel
        var releaseDate = cell.viewWithTag(3) as? UILabel
        var rating = cell.viewWithTag(4) as? CosmosView
        var loveBtn = cell.viewWithTag(5) as? UIButton
        // Configure the cell...
        if Reachability.isConnectedToNetwork(){
            img?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185"+movies[indexPath.row].posterPath), placeholderImage: UIImage(named: "1.png"))
            
        }else{
            let image : UIImage = UIImage(named:"1.png")!
            img = UIImageView(image: image)
            
        }
        title?.text=movies[indexPath.row].title
        releaseDate?.text=movies[indexPath.row].releaseDate
        rating?.rating=movies[indexPath.row].rating
        
        // action of loveBtn
//        idx=indexPath.row
//        loveBtn?.addTarget(self, action: #selector(FavouriteModel.onClickedLoveButton(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func onClickedLoveButton(_ sender: Any?) {
        // remove from core data [ then ] array
        //remove
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourite")
//        deleteFetch.predicate = NSPredicate.init(format: "title==\(titles[idx])")
//        do{
//            let objects = try managedContext.fetch(deleteFetch)
//            for object in objects {
//                managedContext.delete(object as! NSManagedObject)
//            }
//            try managedContext.save()
//        }catch let error as NSError{
//
//        }
//        // delete from array
//        titles.remove(at: idx)
//        movies.remove(at: idx)
//        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/4
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourite")
            let str:String=titles[indexPath.row]
            deleteFetch.predicate = NSPredicate.init(format: "title==\(titles[indexPath.row])")
            do{
                let objects = try managedContext.fetch(deleteFetch)
                for object in objects {
                    managedContext.delete(object as! NSManagedObject)
                }
                try managedContext.save()
            }catch let error as NSError{
                
            }
            // delete from array
            titles.remove(at: indexPath.row)
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
