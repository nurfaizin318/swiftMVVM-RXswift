//
//  sourceViewModel.swift
//  swiftTest
//
//  Created by MacBook on 17/01/23.
//

import Foundation
import RxSwift
import RxCocoa


class SourceViewModel{
       

    var listCategory  =  BehaviorRelay<[SourceModel]>(value: [SourceModel(id:"bbc-news",name:"BBC News"),
                                                              SourceModel(id:"bloomberg",name:"Bloomberg"),
                                                              SourceModel(id:"fox-sports",name:"Fox Sports"),
                                                              SourceModel(id:"cnn",name:"CNN")])

    
}
