//
//  SourceViewController.swift
//  swiftTest
//
//  Created by MacBook on 17/01/23.
//

import UIKit
import RxSwift
import RxCocoa

class SourceViewController: UIViewController,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
     let sourceViewModel  = SourceViewModel()
    private let disposeBag = DisposeBag()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        setupView()
        
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        
        tableView.register(UINib(nibName: "SourceCell", bundle: nil), forCellReuseIdentifier:"sourceCell")
        sourceViewModel.listCategory.asObservable().bind(to: tableView.rx.items(cellIdentifier: "sourceCell",cellType: SourceCellViewController.self)){ row,item,cell in

            cell.name?.text = item.name;
            cell.labelContainer.layer.cornerRadius = 8.0

        }.disposed(by: disposeBag)
     
    
        
        tableView.rx.modelSelected(SourceModel.self).bind{ item in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let artcicleViewController = storyBoard.instantiateViewController(withIdentifier: "ArticleView") as! ArticleViewController
            artcicleViewController.modalPresentationStyle = .overFullScreen
            SourceModel.name = item.id
            self.present(artcicleViewController, animated:true, completion:nil)
       
            
        }.disposed(by: disposeBag)
    }
    
    
    

    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
