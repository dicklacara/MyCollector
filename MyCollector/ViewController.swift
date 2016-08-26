//
//  ViewController.swift
//  MyCollector
//
//  Created by Richard Applebaum on 8/25/16.
//  Copyright © 2016 La Cara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var collectionItems: [MyCollection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            collectionItems = try context.fetch(MyCollection.fetchRequest())
            tableView.reloadData()
            //print("=======\(collectionItems)")
        } catch {
            
        }
            
//        let myCollection = MyCollection(context: context)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let collectionItem = collectionItems[indexPath.row]
        cell.textLabel?.text = collectionItem.title
        cell.imageView?.image = UIImage(data: collectionItem.image as! Data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collectionItem = collectionItems[indexPath.row]
        performSegue(withIdentifier: "collectionSegue", sender: collectionItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! SecondViewController
        nextVC.collectionItem = sender as? MyCollection
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

