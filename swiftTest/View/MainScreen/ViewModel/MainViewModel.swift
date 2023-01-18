//
//  MainViewModel.swift
//  swiftTest
//
//  Created by MacBook on 17/01/23.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel{
    
    var listSource  =  BehaviorRelay<[String]>(value:   ["business","entertainment","general","health","sciencesports","technology"])

 //untuk parameter scroll jika true maka ambil data busines jika false maka ambil data general
    
  
}
