//
//  ArticleViewModel.swift
//  swiftTest
//
//  Created by MacBook on 17/01/23.
//

import Foundation
import RxSwift
import RxCocoa

class ArticleViewModel{
    
        let service  = APIService()
        var listArticle =  BehaviorSubject<[Article]>(value : [])
      
        var mainVW = MainViewModel()
        var disposeBag = DisposeBag()
        var scrolltype  = false // sebagai parameter jika true ambil data general jika false ambil data health , jika news api mempunyai parameter index lebih baik menggunakan index
    var isLoading = BehaviorSubject<Bool>(value:false);
    
    
        func fetchArticleList (){
            
            isLoading.onNext(true)
                service.fetchArticleList{ data,error in

                if let data = data {
                    let list = data as ArticleModel
                    self.listArticle.onNext(list.articles)
                    self.isLoading.onNext(false)
                }

                if let error = error{
                    print(error)
                    self.isLoading.onNext(false)
                }
                    

            }
        }
    
    
    func loadOnScroll (){
        
        
        print("hit")
        self.isLoading.onNext(true)
        scrolltype = !scrolltype
        if(scrolltype == false){
            Category.name = "health"
        }else{
            Category.name = "sports"
        }
            service.fetchArticleList{ data,error in

            if let data = data {
                let list = data.articles
                do {
                    self.listArticle.onNext(try self.listArticle.value()+list)
                    // concatenating older value with new
                    self.isLoading.onNext(false)
                } catch {
                    print(error)
                }

            }

            if let error = error{
                print(error)
                self.isLoading.onNext(false)
            }


        }
    }
}
