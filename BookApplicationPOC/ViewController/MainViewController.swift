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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RequestResponceHandler.shared.getAllBooks(startIndex: 1) { (responce, error, string) in
            self.booksArray =  responce
            self.bookTableView.reloadData()
        }
        
        self.initalizeUiComponents()
    }
    
    //Mark:initalizeUiComponents
    func initalizeUiComponents(){
      
        //Table View
        bookTableView.delegate = self
        bookTableView.dataSource = self
        
        bookTableView.register(MainviewControllerCell.self, forCellReuseIdentifier: cellIdentifier)
        bookTableView.backgroundColor = UIColor.clear
        
    }
    
}


extension MainViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  booksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MainviewControllerCell
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
    
}

class MainviewControllerCell: UITableViewCell {
    
    var lblName = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        lblName.textColor = UIColor.red
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

