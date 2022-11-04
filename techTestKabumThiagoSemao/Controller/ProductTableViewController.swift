//
//  ProductTableViewController.swift
//  techTestKabumThiagoSemao
//
//  Created by Thiago Semão Pires on 28/10/22.
//

import UIKit
import Foundation
import Kingfisher
import SwiftUI

class ProductTableViewController: UITableViewController {


    var products: [Product] = []
    var currentPage = 1
    var inLoading: Bool = false
    var fetchingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItemList(page: currentPage)
        loadingActivity()
    }
    
    
    ///////////////////////    LOADING INDICATOR    ////////////////////////////////
    func loadingActivity() {
        let loadingNIb = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(loadingNIb, forCellReuseIdentifier: "loadingCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func beginBatchFetch() {
        fetchingMore = true
        print("beginBatchFetch!")
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let newProducts = (self.products.count...self.products.count + 10) .map { index in index }
            self.fetchingMore = false
            self.tableView.reloadData()
        })
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    func loadItemList(page: Int = 1) {
        
        guard let url = URL(string: "https://servicespub.prod.api.aws.grupokabum.com.br/home/v1/home/produto?app=1&limite=10&pagina=\(page)") else {return}
        // Using [weak self] dont retain cycle
        var request = URLRequest(url: url)
        request.setValue("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36", forHTTPHeaderField: "User-Agent")
        inLoading = true
        print(url)
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error == nil {
                if let returnData = data {
                    do {
                        let jsonDecode = try JSONDecoder().decode(DataProduct.self, from: returnData)
                        if self.currentPage > 1 {
                            self.products.append(contentsOf: jsonDecode.products)
                        } else {
                            self.products = jsonDecode.products
                        }
                        self.currentPage += 1
                        self.inLoading = false
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    } catch {
                        self.inLoading = false
                        debugPrint(error)
                    }
                }
            } else {
                self.inLoading = false
                print("Error ao fazer a consulta")
            }
        }
        dataTask.resume()
    }
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return products.count
        } else if section == 1 && fetchingMore {
            return 1
        }
        return 0
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
            cell.prepare(with: products[indexPath.row])
            
            
            cell.layer.cornerRadius = 4
            cell.clipsToBounds = false
            cell.layer.masksToBounds = false
            cell.layer.shadowRadius = 2
            cell.layer.shadowOpacity = 0.6
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowColor = UIColor.black.cgColor
            

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
            cell.spinner.startAnimating()
           
            return cell
        }
        
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // último item
        if products.count-1 == indexPath.row, !products.isEmpty, !inLoading {
            loadItemList(page: currentPage)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeigth = scrollView.contentSize.height
        
        
        if offsetY > contentHeigth - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch()
                
            }
        }
    }
    
    
        
}



   

