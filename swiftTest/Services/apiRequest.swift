//
//  apiRequest.swift
//  swiftTest
//
//  Created by MacBook on 17/01/23.
//

import Foundation

class APIService :  NSObject {

    
    func fetchArticleList(completion : @escaping (ArticleModel?,Error?) -> ()){
        
        let sourcesURL = URL(string: "https://newsapi.org/v2/top-headlines?category=\(Category.name)&apiKey=1cbfb069362649c99b515e8ef3a6a4b1")!
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {

                let jsonDecoder = JSONDecoder()

                let empData = try! jsonDecoder.decode(ArticleModel.self, from: data)
                    completion(empData,nil)
            }
            
            if let error = error {
               
                    completion(nil,error)
                        
            }
        }.resume()
        print(sourcesURL)
    }
}
