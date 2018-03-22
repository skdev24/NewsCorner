//
//  NewsViewController.swift
//  NewsCorner
//
//  Created by Shivam Dev on 16/03/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//


import UIKit


class getFullDetails: Decodable {
    var sources: [getName]
}

class getName: Decodable {
    var id: String
    var name: String
    var category: String
}

class getNewsFullDetails: Decodable {
    var articles: [getNewsVlue]
}

class getNewsVlue: Decodable {
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var source: sourceDetail?
}

class sourceDetail: Decodable {
    var name: String
    var id: String?
}

class NewsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var categoryView: UICollectionView!
    @IBOutlet weak var nameView: UICollectionView!
    @IBOutlet weak var detalsTableView: UITableView!
    
    var getNewsName = [getName]()
    var getNewsDetail = [getNewsVlue]()
    
    var categoryName = "bbc-news"
    var value = 5
    
    var category: [String] = []
    var name: [String] = []
    
    var storeColorForCategory: [UIColor] = []
    var storeColorForName: [UIColor] = []
    
    
    var check = false
    var chack2 = false
    var checkedBtn = [Bool]()
    var checkedBtn2 = [Bool]()
    
    
    
    let forecastBaseURL = "https://newsapi.org/v2/sources?language=en&apiKey=YOUR_API_KEY"
    var forecastBaseURL2 = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getNewsData(urlString: forecastBaseURL)
        getNewsDetails(urlString: categoryName)
        
        
        if let flowLayout = nameView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1,height: 1)
        }
        
        
        
        categoryView.dataSource = self
        categoryView.delegate = self
        
        nameView.dataSource = self
        nameView.delegate = self
        
    }
    
    
    func getNewsData(urlString: String) {
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let data = data else {return}
            
            //            let dataString = String(data: data, encoding: .utf8)
            
            do {
                
                let collection = try [JSONDecoder().decode(getFullDetails.self, from: data)]
                
                self.getNewsName = collection[0].sources
                
                
                for i in 0...10 {
                    if !self.getNewsName.isEmpty {
                        self.name.append(self.getNewsName[i].name)
                        self.checkedBtn.append(false)
                    }
                }
                
            } catch let jsonError {
                print("Error Serialization json: ", jsonError)
            }
            
            DispatchQueue.main.async {
                self.nameView.reloadData()
                self.categoryView.reloadData()
            }
            }.resume()
    }
    
    func getNewsDetails(urlString: String) {
        
        let newUrlString = "https://newsapi.org/v2/top-headlines?sources=\(urlString)&apiKey=YOUR_API_KEY"
        
        let url = URL(string: newUrlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let data = data else {return}
            
            //                        let dataString = String(data: data, encoding: .utf8)
            
            //            print(dataString!)
            
            do {
                
                let collection2 = try [JSONDecoder().decode(getNewsFullDetails.self, from: data)]
                
                self.getNewsDetail = collection2[0].articles
                self.value = collection2[0].articles.count
                
                for _ in 0..<7 {
                    self.checkedBtn2.append(false)
                }
                
                
            } catch let jsonError {
                print("Error Serialization json: ", jsonError)
            }
            
            DispatchQueue.main.async {
                self.detalsTableView.reloadData()
            }
            }.resume()
    }
    
    
    @IBAction func categoryBtn(_ sender: UIButton) {
        name = []
        checkedBtn = []
        checkedBtn2 = []
        
        
        
        let justValue = sender.titleLabel?.text
        
        for i in 0..<getNewsName.count {
            
            if (getNewsName[i].category == justValue) {
                name.append(getNewsName[i].name)
                checkedBtn.append(false)
            }
        }
        
        
        for _ in 0..<7 {
            checkedBtn2.append(false)
        }
        for _ in 0..<name.count {
            checkedBtn.append(false)
        }
        
        if !checkedBtn2.isEmpty {
            checkedBtn2[sender.tag] = true
        }

        categoryView.performBatchUpdates({

            
            let indexPath2 = categoryView.indexPathsForVisibleItems
            
            for i in indexPath2.enumerated() {
                let cell2 = categoryView.cellForItem(at: i.element) as! CategoryCollectionViewCell
                
                if !checkedBtn2.isEmpty{
                    if checkedBtn2[cell2.categoryCell.tag] {
                        cell2.categoryCell.backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.737254902, blue: 0.3882352941, alpha: 1)
                        cell2.categoryCell.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                    } else {
                        cell2.categoryCell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell2.categoryCell.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.737254902, blue: 0.3882352941, alpha: 1), for: .normal)
                    }
                }
            }
            
        }, completion: nil)
        
        DispatchQueue.main.async(execute: {
            self.nameView.reloadData()
        })
        
    }
    
    @IBAction func nameBtn(_ sender: UIButton) {
        
        getNewsDetail = []
        checkedBtn = []
        
        
        for i in 0..<getNewsName.count {
            
            if getNewsName[i].name == sender.titleLabel?.text {
                getNewsDetails(urlString: getNewsName[i].id)
            }
            
        }
        
        for _ in 0..<name.count {
            checkedBtn.append(false)
        }
        
        if !checkedBtn.isEmpty {
            checkedBtn[sender.tag] = true
        }

        
        nameView.performBatchUpdates({

            
            let indexPath2 = nameView.indexPathsForVisibleItems
            
            for i in indexPath2.enumerated() {
                let cell2 = nameView.cellForItem(at: i.element) as! NameCollectionViewCell
                
                if !checkedBtn2.isEmpty{
                    if checkedBtn[cell2.nameCell.tag] {
                        cell2.nameCell.backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.737254902, blue: 0.3882352941, alpha: 1)
                        cell2.nameCell.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                    } else {
                        cell2.nameCell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell2.nameCell.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.737254902, blue: 0.3882352941, alpha: 1), for: .normal)
                    }
                }
            }
            
        }, completion: nil)
        
        
        
        DispatchQueue.main.async(execute: {
            self.detalsTableView.reloadData()
            //            self.detalsTableView.setContentOffset(.zero, animated: true)
            self.detalsTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
        })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sourceCell", for: indexPath) as? SourceTableViewCell
        
        
        if !getNewsDetail.isEmpty {
            if let name = getNewsDetail[indexPath.row].source?.name, let description = getNewsDetail[indexPath.row].description, let title = getNewsDetail[indexPath.row].title, let imageName = getNewsDetail[indexPath.row].urlToImage  {
                cell?.updateUI(name: name, description: description, title: title, imageName: imageName)
            }
        }
        
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let url = URL(string: getNewsDetail[indexPath.row].url!)
        UIApplication.shared.open(url!, options: [:], completionHandler: { (status) in
            
        })
    }
}


extension NewsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //        for i in 0..<getNewsName.count {
        //            if !category.contains(getNewsName[i].category) {
        //                category.append(getNewsName[i].category)
        //            }
        //        }
        
        if collectionView == self.nameView {
            
            if getNewsName.count != 0 {
                return name.count
            } else {
                return 0
            }
            
        } else {
            
            for i in 0..<getNewsName.count {
                if !category.contains(getNewsName[i].category) {
                    category.append(getNewsName[i].category)
                }
            }
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.categoryView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            
            cell.categoryCell.tag = indexPath.row
            if !category.isEmpty{
                cell.UIUpdate(name: category[indexPath.row])
            }
            
            if !checkedBtn2.isEmpty{
                if checkedBtn2[indexPath.row] {
                    cell.categoryCell.backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.737254902, blue: 0.3882352941, alpha: 1)
                    cell.categoryCell.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                } else {
                    cell.categoryCell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cell.categoryCell.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.737254902, blue: 0.3882352941, alpha: 1), for: .normal)
                }
            }
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nameCell", for: indexPath) as! NameCollectionViewCell
            
            
            cell.UIUpdate(name:name[indexPath.row])
            
            cell.nameCell.tag = indexPath.row
            
            if !checkedBtn.isEmpty{
                if checkedBtn[indexPath.row] {
                    cell.nameCell.backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.737254902, blue: 0.3882352941, alpha: 1)
                    cell.nameCell.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                } else {
                    cell.nameCell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cell.nameCell.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.737254902, blue: 0.3882352941, alpha: 1), for: .normal)
                }
            }
            return cell
        }
    }
}
