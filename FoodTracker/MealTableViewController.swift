//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by vasanth vmr on 12/30/15.
//  Copyright © 2015 vasanth vmr. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    // MARK: Properties
    var meals = [Meal]()
    
    func loadSampleMeals(){
        let salad_image = UIImage(named: "salad")!
        let salad = Meal(name: "Salad", rating: 5, image: salad_image)!
        let potato_chicken_image = UIImage(named: "potato_chicken")!
        let potato_chicken = Meal(name: "Potato Chicken", rating: 5, image: potato_chicken_image)!
        let pasta_meatballs_image = UIImage(named: "pasta_meatballs")!
        let pasta_meatballs = Meal(name: "Pasta Meatballs", rating: 3, image: pasta_meatballs_image)!
        meals += [salad,potato_chicken,pasta_meatballs]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem()
        if let meals = loadMeals() {
            self.meals += meals
        }else{
            loadSampleMeals()
        }
    }
    
    // MARK: NSCoding
    func saveMeals(){
        let isMealSavedSuccesfully = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.archivePath.path!)
        if !isMealSavedSuccesfully {
            print("Failed to save Meals")
        }
    }
    
    func loadMeals() ->[Meal]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.archivePath.path!) as? [Meal]
        
    }
    
    // MARK: Actions
    
    @IBAction func unwindToMealList(unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.sourceViewController as? MealViewController, meal = sourceViewController.meal {
            if let selectedRowPath = tableView.indexPathForSelectedRow{
                meals[selectedRowPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedRowPath], withRowAnimation: .None)
            }
            else{
                let indexpath = NSIndexPath(forItem: meals.count, inSection: 0)
                meals+=[meal]
                tableView.insertRowsAtIndexPaths([indexpath], withRowAnimation: .Bottom)
            }
            saveMeals()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Only grouping is required now
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // No of cells per section
        return meals.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MealTableViewCell", forIndexPath: indexPath) as! MealTableViewCell
        let meal = meals[indexPath.row]
        // Configure the cell...
        cell.nameLabel.text = meal.name
        cell.ratingControl.rating = meal.rating
        cell.photoImageView.image = meal.image

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            meals.removeAtIndex(indexPath.row)
            saveMeals()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let mealDetailViewController = segue.destinationViewController as! MealViewController
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)
                let selectedMeal = meals[indexPath!.row]
                mealDetailViewController.meal = selectedMeal
            }
            
        }
        else if segue.identifier == "AddItem" {
          print("Adding new meal")
        }
    }
    
}
