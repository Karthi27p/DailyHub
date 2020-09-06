//
//  ViewController.swift
//  DailyHub
//
//  Created by Karthi on 07/06/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var newsArticles: DHArticles?
    var displayedIndices: [IndexPath] = []
    let newsCategories = ["Top News","business", "entertainment", "health", "science", "sports", "technology"]
    let viewModel = DHNewsViewModel()
    
    //MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 90
        self.tableView.register(UINib(nibName: "DHNewsCell", bundle: nil), forCellReuseIdentifier: "DHNewsCell")
        self.fetchNews(category: "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setTopNewsSelected()
    }
    
    //MARK: UI and Data configuration
    func setTopNewsSelected() {
        guard let topNewsCell = self.collectionView.cellForItem(at: IndexPath.init(item: 0, section: 0)) as? DHArticleCollectionViewCell else {
            return
        }
        self.collectionView.selectItem(at: IndexPath.init(item: 0, section: 0), animated: true, scrollPosition: [])

        self.setBackgroundColorForSelectedItem(cell: topNewsCell, color: UIColor.systemBlue)
    }
    
    func fetchNews(category: String) {
        viewModel.fetchNewsData(category: category) { [weak self] (data, error) in
            guard let strongSelf = self , let _ = data else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.newsArticles = data as? DHArticles
                strongSelf.tableView.reloadData()
                /* if (strongSelf.newsArticles?.articles.count ?? 0 > 0) {
                    strongSelf.tableView.scrollToRow(at: IndexPath.init(item: 0, section: 0), at: .top, animated: false)
                } */
            }
        }
    }
    
    func setBackgroundColorForSelectedItem(cell: DHArticleCollectionViewCell, color: UIColor) {
        cell.containerView.backgroundColor = color
        cell.titleLabel.backgroundColor = color
    }
    
    func drawRect(rect: CGRect) {
        
        
        var percentage = CGFloat()  //can declare as instance variable or globally which you get from web service and set it's value!!
        
        
        
        percentage = 0.5
        
        let upperRect = CGRect(x: 0, y: 0, width: collectionView.frame.size.width/2, height: collectionView.frame.size.height)//CGRectMake(0, 0, rect.size.width, collectionView.frame.size.height)
        
        let lowerRect = CGRect(x: 0, y: 0, width: collectionView.frame.size.width/2, height: collectionView.frame.size.height)
        
        UIColor.red.set()
        UIRectFill(upperRect)
        UIColor.green.set()
        UIRectFill(lowerRect)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailPage" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationViewController = segue.destination as? DHNewsDetailViewController
                let url = URL(string: newsArticles?.articles[indexPath.row].url ?? "https://images.livemint.com/img/2020/08/02/600x338/Bandhanbank_1596365798223.JPG")!
                destinationViewController?.url = url
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    //MARK: Table View Delegates
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (!self.displayedIndices.contains(indexPath)) {
            self.displayedIndices.append(indexPath)
            let view = cell.contentView
            view.alpha = 0
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0.05 * Double(indexPath.row),
                animations: {
                    view.alpha = 1
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
       }
}

extension ViewController: UITableViewDataSource {
    
    //MARK: Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DHNewsCell") as? DHNewsCell else {
            return UITableViewCell()
        }
        //Uncomment for storyboard cell
        /* guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? DHArticleTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(cellViewModel: cellViewModel) */
        
        let cellViewModel = DHNewsCellViewModel()
        cellViewModel.article = newsArticles?.articles[indexPath.row]
        cell.getArticleView()?.setData(cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetailPage", sender: nil)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    //MARK: Collection View Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let titleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCell", for: indexPath) as? DHArticleCollectionViewCell else {
            return UICollectionViewCell()
        }
        titleCell.titleLabel.text = newsCategories[indexPath.row]
        self.setBackgroundColorForSelectedItem(cell: titleCell, color: titleCell.isSelected ? UIColor.systemBlue : UIColor.white)
        return titleCell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    //MARK: CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.displayedIndices = []
        self.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        self.fetchNews(category: indexPath.row == 0 ? "" : newsCategories[indexPath.row])
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? DHArticleCollectionViewCell else {
            return
        }
        self.setBackgroundColorForSelectedItem(cell: selectedCell, color: UIColor.systemBlue)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let deSelectedCell = collectionView.cellForItem(at: indexPath) as? DHArticleCollectionViewCell else {
            return
        }
        self.setBackgroundColorForSelectedItem(cell: deSelectedCell, color: UIColor.white)
    }
}

extension ViewController: UIScrollViewDelegate {
    
    //MARK: Scroll View Delegates
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView == tableView) {
            let totalScroll = scrollView.contentSize.height - self.tableView.frame.height
            let scrollPercent = (scrollView.contentOffset.y/totalScroll)
            self.progressView.setProgress(Float(scrollPercent), animated: true)
            self.progressView.trackTintColor = UIColor.orange;
            self.progressView.progressTintColor = UIColor.purple;
            
            
        }
    }
}

