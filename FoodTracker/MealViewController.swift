//
//  MealViewController.swift
//  FoodTracker
//
//  Created by vasanth vmr on 12/26/15.
//  Copyright © 2015 vasanth vmr. All rights reserved.
//

import UIKit

class MealViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var meal:Meal?
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender{
            let name = nameTextField.text ?? ""
            let rating = ratingControl.rating
            let image = photoImageView.image
            meal = Meal(name: name, rating: rating, image: image)
        }
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the Keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidNames()
        navigationItem.title = textField.text
    }
    
    func checkValidNames(){
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Info has multiple presentation of same image , this one picks originial
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Assign the selected image to storyboard Image element
        photoImageView.image = selectedImage
        
        // Dismiss the picker
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the Keybaord
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is the one that handles the image picking from the library
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        
        //Notifies the view controller that image picker controller has selected the image
        imagePickerController.delegate = self
        
        //presenting the view controlled by image picker controller
        presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        let isPresentingNewMeal = presentingViewController is UINavigationController
        if isPresentingNewMeal{
            dismissViewControllerAnimated(true, completion: nil)
        }else{
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            ratingControl.rating = meal.rating
            photoImageView.image = meal.image
        }
        checkValidNames()
    }
    
}

