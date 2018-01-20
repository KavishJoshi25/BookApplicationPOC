//
//  InfoDetailViewController.swift
//  BookApplicationPOC
//
//  Created by Kavish joshi on 15/01/18.
//  Copyright © 2018 Kavish joshi. All rights reserved.
//

import UIKit
import AlamofireImage

class InfoDetailViewController: UITableViewController {

    @IBOutlet var bookDeatilTableView: UITableView!
    var booksDetailsArray = [BooksEntity]()
    
    var bookObj = BooksEntity()
    var volumeInfoObj = volumeInfoEntity()

    let cellIdentifier = "tableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalizeUiComponents()
       
    }
    
    //Mark:initalizeUiComponents
    func initalizeUiComponents(){
        
        bookObj = booksDetailsArray.first!
        volumeInfoObj = bookObj.volumeInfo.first!
        
        //Table View
        bookDeatilTableView.delegate = self
        bookDeatilTableView.dataSource = self
        bookDeatilTableView.separatorStyle = .none
        
        bookDeatilTableView.register(MainviewControllerCell.self, forCellReuseIdentifier: cellIdentifier)
        bookDeatilTableView.backgroundColor = UIColor.clear
        
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0 //booksDetailsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MainviewControllerCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView:UIView = UIView()
        let movieImageView = UIImageView()
        let detailObj =  volumeInfoObj.imageLinks["smallThumbnail"] ?? ""
        print(detailObj)
        let url = NSURL(string:detailObj)
        movieImageView.af_setImage(withURL:  url! as URL)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.backgroundColor = UIColor.clear
        movieImageView.backgroundColor = UIColor.clear
        
        self.view.addSubview(headerView)
        headerView.addSubview(movieImageView)
        
        NSLayoutConstraint.activate([headerView.topAnchor.constraint(equalTo: tableView.topAnchor,constant:0), headerView.leftAnchor.constraint(equalTo: tableView.leftAnchor), headerView.widthAnchor.constraint(equalTo: tableView.widthAnchor),headerView.heightAnchor.constraint(equalToConstant: 250)])
        
        
        NSLayoutConstraint.activate([movieImageView.topAnchor.constraint(equalTo: headerView.topAnchor,constant:0),
                                     movieImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                                     movieImageView.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 1.0),
                                     movieImageView.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 1.0)])
        
        let movieTitle = UILabel()
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.text = "Title: " + (volumeInfoObj.title)
        movieTitle.textAlignment = .left
        movieTitle.textColor = UIColor.white
        headerView.addSubview(movieTitle)
        NSLayoutConstraint.activate([movieTitle.topAnchor.constraint(equalTo: movieImageView.bottomAnchor,constant:15),
                                     movieTitle.leftAnchor.constraint(equalTo: headerView.leftAnchor,constant:0),
                                     movieTitle.widthAnchor.constraint(equalTo: headerView.widthAnchor),
                                     movieTitle.heightAnchor.constraint(equalToConstant: 25)])
        
        
        let vote_average = UILabel()
        vote_average.translatesAutoresizingMaskIntoConstraints = false
        vote_average.text = "Authors: " + "\(volumeInfoObj.authors.first!)"
        vote_average.textAlignment = .left
        vote_average.textColor = UIColor.white
        headerView.addSubview(vote_average)
        NSLayoutConstraint.activate([vote_average.topAnchor.constraint(equalTo: movieTitle.bottomAnchor,constant:15),
                                     vote_average.leftAnchor.constraint(equalTo: headerView.leftAnchor,constant:0),
                                     vote_average.widthAnchor.constraint(equalTo: headerView.widthAnchor),
                                     vote_average.heightAnchor.constraint(equalToConstant: 25)])
        
        let releaseDate = UILabel()
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.text = "Subtitle: " + "\(volumeInfoObj.subtitle)"
        releaseDate.textAlignment = .left
        releaseDate.textColor = UIColor.white
        releaseDate.lineBreakMode = NSLineBreakMode.byWordWrapping
        releaseDate.numberOfLines = 0

        headerView.addSubview(releaseDate)
        NSLayoutConstraint.activate([releaseDate.topAnchor.constraint(equalTo: vote_average.bottomAnchor,constant:15),
                                     releaseDate.leftAnchor.constraint(equalTo: headerView.leftAnchor,constant:0),
                                     releaseDate.widthAnchor.constraint(equalTo: headerView.widthAnchor),
                                     releaseDate.heightAnchor.constraint(equalToConstant: 50)])
        
        let movieOverView = UILabel()
        movieOverView.translatesAutoresizingMaskIntoConstraints = false
        
        let snippet = bookObj.searchInfo
        movieOverView.text = "Text Snippet: " + "\(snippet["textSnippet"]!)"
        movieOverView.textAlignment = .left
        movieOverView.textColor = UIColor.white
        movieOverView.lineBreakMode = .byWordWrapping
        movieOverView.numberOfLines = 0
        headerView.addSubview(movieOverView)
        NSLayoutConstraint.activate([movieOverView.topAnchor.constraint(equalTo: releaseDate.bottomAnchor,constant:15),
                                     movieOverView.leftAnchor.constraint(equalTo: headerView.leftAnchor,constant:0),
                                     movieOverView.widthAnchor.constraint(equalTo: headerView.widthAnchor,constant:0),
                                     movieOverView.heightAnchor.constraint(equalToConstant: 100)])
        
        
        let descriptionLbl = UILabel()
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLbl.text = "Description: " + "\(volumeInfoObj.bookDescription)"
        descriptionLbl.textAlignment = .left
        descriptionLbl.textColor = UIColor.white
        descriptionLbl.lineBreakMode = .byWordWrapping
        descriptionLbl.numberOfLines = 0
        headerView.addSubview(descriptionLbl)
        NSLayoutConstraint.activate([descriptionLbl.topAnchor.constraint(equalTo: movieOverView.bottomAnchor,constant:15),
                                     descriptionLbl.leftAnchor.constraint(equalTo: headerView.leftAnchor,constant:0),
                                     descriptionLbl.widthAnchor.constraint(equalTo: headerView.widthAnchor,constant:0),
                                     descriptionLbl.heightAnchor.constraint(equalToConstant: 320)])
        
        
        let averageRatingLbl = UILabel()
        averageRatingLbl.translatesAutoresizingMaskIntoConstraints = false
        
        averageRatingLbl.text = "Average Rating: " + "\(volumeInfoObj.averageRating)"
        averageRatingLbl.textAlignment = .left
        averageRatingLbl.textColor = UIColor.white
        headerView.addSubview(averageRatingLbl)
        NSLayoutConstraint.activate([averageRatingLbl.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor,constant:15),
                                     averageRatingLbl.leftAnchor.constraint(equalTo: headerView.leftAnchor,constant:0),
                                     averageRatingLbl.widthAnchor.constraint(equalTo: headerView.widthAnchor,constant:0),
                                     averageRatingLbl.heightAnchor.constraint(equalToConstant: 30)])
        
        return headerView


    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 900
    }

}


//class InfoDetailViewControllerCell: UITableViewCell {
//    
//    var lblName = UILabel()
//    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        lblName.textColor = UIColor.black
//        lblName.lineBreakMode = .byWordWrapping
//        lblName.numberOfLines = 2
//        lblName.translatesAutoresizingMaskIntoConstraints = false
//        lblName.font = UIFont.boldSystemFont(ofSize: 24)
//        contentView.addSubview(lblName)
//        
//        // Layout setup
//        NSLayoutConstraint.activate([lblName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor,constant: 0),
//                                     lblName.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant:15),
//                                     lblName.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0),
//                                     lblName.heightAnchor.constraint(equalToConstant:35)])
//        
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}



