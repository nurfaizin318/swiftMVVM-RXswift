//
//  MainViewController.swift
//  swiftTest
//
//  Created by MacBook on 17/01/23.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController,UITableViewDelegate {
    
    private let articleVW  = ArticleViewModel()
    private let mainViewModel  = MainViewModel()
    private let disposeBag = DisposeBag()
    let service  = APIService()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()

        tableView.delegate = self
        
        setupView();
 

        // Do any additional setup after loading the view.
    }
    
    
    func setupView(){
        
        
        tableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier:"mainCell")
      
        mainViewModel.listSource.asObservable().bind(to: tableView.rx.items(cellIdentifier: "mainCell",cellType: MainCellViewController.self)){ row,item,cell in
            cell.name?.text = item
            cell.nameContainer?.layer.cornerRadius = 8.0
            cell.nameContainer.dropShadow()
           

        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
                            .subscribe(onNext: { [weak self] indexPath in
                                guard let self = self else { return }
                                
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                let sourceViewController = storyBoard.instantiateViewController(withIdentifier: "SourceView") as! SourceViewController
                                sourceViewController.modalPresentationStyle = .overFullScreen
                                
                                //get id for parameter on next page
                                let type :String =  self.mainViewModel.listSource.value[indexPath.row]
                                
                                Category.name = type
                                
                                self.present(sourceViewController, animated:true, completion:nil)
                            }).disposed(by: disposeBag)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0;//Choose your custom row height
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
