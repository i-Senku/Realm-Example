//
//  ProductController.swift
//  Realm Demo
//
//  Created by Ercan on 29.06.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import RealmSwift

typealias completionHandlerForProduct = (String,Int) -> ()

class ProductController: UIViewController {
    
    var realm = try! Realm()
    
    @IBOutlet weak var tableProduct: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString)
    }
    
    @IBAction func addProduct(_ sender: Any) {
        
        showAlert {(name, price) in
            self.add(name: name, price: price)
        }
        
    }
    
    //MARK:- Add Product
    fileprivate func add(name:String , price : Int) {
        let product = Product()
        do {
            try self.realm.write{
                product.productName = name
                product.price = price
                self.realm.add(product)
                DispatchQueue.main.async {
                    self.tableProduct.reloadData()
                }
            }
        } catch (let e) {
            print(e.localizedDescription)
        }
    }
    
    //MARK:- Delete Product
    fileprivate func deleteProduct(object: Product) {
        do {
            try self.realm.write{
                self.realm.delete(object)
                DispatchQueue.main.async {
                    self.tableProduct.reloadData()
                }
            }
        } catch (let e) {
            print(e.localizedDescription)
        }
    }
    
    //MARK:- Update Product
    fileprivate func updateProduct(object : Product,name:String , price : Int) {
        do {
            try self.realm.write {
                object.productName = name
                object.price = price
                
                self.tableProduct.reloadData()
            }
        } catch (let e) {
            print(e.localizedDescription)
        }
    }
    
    //MARK:- Show Alert Function
    fileprivate func showAlert(name:String = "", price:Int = 0, completionHandler : @escaping completionHandlerForProduct){
        
        let alertController = UIAlertController(title: "Product", message: "Add Product", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Product Name"
            textField.text = name
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Price"
            textField.text = String(price)
        }
        
        let completeAction = UIAlertAction(title: "Complete", style: .default) { (_) in
            let productName = alertController.textFields![0].text!
            let price = Int(alertController.textFields![1].text!)!
            completionHandler(productName,price)
        }
        
        alertController.addAction(completeAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
}

//MARK:- Delegate Methods For UITableView
extension ProductController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(Product.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.productCellName) as! ProductCell
        let product = realm.objects(Product.self)[indexPath.row]
        cell.productName.text = product.productName
        cell.price.text = String(product.price)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            let product = self.realm.objects(Product.self)[indexPath.row]
            self.deleteProduct(object: product)
            completionHandler(true)
        }
        
        let updateAction = UIContextualAction(style: .normal, title: "Update") { (_, _, completionHandler) in
            let product = self.realm.objects(Product.self)[indexPath.row]
            
            self.showAlert(name: product.productName, price: product.price) { (name, price) in
                self.updateProduct(object: product, name: name, price: price)
            }
            completionHandler(true)
        }
        
        let configration = UISwipeActionsConfiguration(actions: [deleteAction,updateAction])
        return configration
        
    }
    
}
