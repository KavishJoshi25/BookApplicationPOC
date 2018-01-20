//
//  MainViewController.swift
//  BookApplicationPOC
//
//  Created by Kavish joshi on 15/01/18.
//  Copyright © 2018 Kavish joshi. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var bookTableView: UITableView!
    var booksArray = [BooksEntity]()
    
    let cellIdentifier = "tableCell"
    
     var count:Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.fetchData(startIndex: count)
        self.initalizeUiComponents()
    }
    
    //Mark:: fetchData
    func fetchData(startIndex:Int)  {
        RequestResponceHandler.shared.getAllBooks(startIndex: startIndex) { (responce, error, string) in
            self.booksArray.append(contentsOf: responce)
            self.bookTableView.reloadData()
        }
    }
    
    //Mark:initalizeUiComponents
    func initalizeUiComponents(){
      
        //Table View
        bookTableView.delegate = self
        bookTableView.dataSource = self
        
        bookTableView.register(MainviewControllerCell.self, forCellReuseIdentifier: cellIdentifier)
        bookTableView.backgroundColor = UIColor.black
        view.backgroundColor = UIColor.black
        
        
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "imagename"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        btn1.addTarget(self, action: #selector(Class.Methodname), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "imagename"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        btn2.addTarget(self, action: #selector(Class.MethodName), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.setRightBarButtonItems([item1,item2], animated: true)
    }
    
}


extension MainViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  booksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MainviewControllerCell
        cell.backgroundColor = UIColor.black
        cell.accessoryType = .disclosureIndicator
        let bookObj = booksArray[indexPath.row]
        let volumeInfoObj = bookObj.volumeInfo.first
        cell.lblName.text = volumeInfoObj?.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyboard.instantiateViewController(withIdentifier: "InfoDetailViewController") as! InfoDetailViewController
        detailsViewController.booksDetailsArray = [booksArray[indexPath.row]]
        navigationController?.pushViewController(detailsViewController,
                                                 animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        count += 1
       self.fetchData(startIndex: count)
    }
    
}

class MainviewControllerCell: UITableViewCell {
    
    var lblName = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        lblName.textColor = UIColor.white
        lblName.lineBreakMode = .byWordWrapping
        lblName.numberOfLines = 2
        lblName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lblName)
        
        // Layout setup
        NSLayoutConstraint.activate([lblName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor,constant: 0),
                                     lblName.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant:15),
                                     lblName.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0),
                                     lblName.heightAnchor.constraint(equalToConstant:35)])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

