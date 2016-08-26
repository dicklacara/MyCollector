//
//  SecondViewController.swift
//  MyCollector
//
//  Created by Richard Applebaum on 8/25/16.
//  Copyright © 2016 La Cara. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var addUpdateButton: UIButton!
    
    @IBOutlet weak var myImageView: UIImageView!
 
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBAction func photosTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func deleteTapped(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(collectionItem!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func addTapped(_ sender: AnyObject) {
        
        if collectionItem != nil {
            collectionItem?.title = titleTextField.text
            collectionItem?.image = UIImagePNGRepresentation(myImageView.image!) as? NSData

        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let collectionItem = MyCollection(context: context)
            collectionItem.title = titleTextField.text
            //        cell.imageView?.image = UIImage(data: collectionItem.image as! Data)
            
            collectionItem.image = UIImagePNGRepresentation(myImageView.image!) as? NSData

        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
   
    var collectionItem: MyCollection? = nil

    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        
        if collectionItem != nil {
          myImageView.image = UIImage(data: collectionItem!.image as! Data)
            titleTextField.text = collectionItem?.title
            addUpdateButton.setTitle("Update", for: UIControlState.normal)
        } else {
            deleteButton.isHidden = true
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        myImageView.image = image
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
