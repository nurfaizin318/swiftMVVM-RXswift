//
//  AticleViewController.swift
//  swiftTest
//
//  Created by MacBook on 17/01/23.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import WebKit


class ArticleViewController: UIViewController,UITableViewDelegate,UISearchBarDelegate, UISearchDisplayDelegate {

    
    let viewModel = ArticleViewModel()
    private let disposeBag = DisposeBag()
    var loading : UIAlertController! = nil
    
    
    
    @IBOutlet weak var titleBar: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleSource: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
      
        setUpView()
        viewModel.fetchArticleList()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        viewModel.isLoading.asObservable().subscribe { status in
            
            print(status)
            if(status == true){
             
                    self.loading = self.loader()
                    print(status)
            }
            if (status == false){
                self.stopLoader(loader: self.loading)
            }
                    }.disposed(by: disposeBag)

    }

    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450.0;//Choose your custom row height
    }
    
   func  setUpView(){
       
       
        tableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier:"ArticleCell")
        titleBar.text = Category.name
        titleSource.text = SourceModel.name
        viewModel.listArticle.asObservable().bind(to: tableView.rx.items(cellIdentifier: "ArticleCell",cellType: ArticleCellViewController.self)){ row,item,cell in

            //if the image is null then it is replaced using static image
            cell.vwImage.setImageKF(with: item.urlToImage ?? "https://scx2.b-cdn.net/gfx/news/2023/convalescent-covid-19.jpg")
            cell.lblTitle?.text = item.title
            cell.lblPublishedAt.text = item.publishedAt
            cell.lblDescription.text = item.description

            cell.vwContainer.layer.cornerRadius = 8.0
            cell.vwContainer.dropShadow()

        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Article.self).bind{ item in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let webView = storyBoard.instantiateViewController(withIdentifier: "WebViewScreen") as! WebViewController
            guard let urlWeb = item.url else{
                return
            }
            webView.urlData = urlWeb
            webView.modalPresentationStyle = .overFullScreen
            self.present(webView, animated:true, completion:nil)
       
            
        }.disposed(by: disposeBag)
        
    }
    
     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height

            if offsetY > contentHeight - scrollView.frame.size.height {
                   
                self.viewModel.loadOnScroll()
                   self.tableView.reloadData()
            }

        }
  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
