//
//  ViewExtention.swift
//  swiftTest
//
//  Created by MacBook on 17/01/23.
//

import Foundation
import UIKit
import Kingfisher


extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
          layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
          layer.shadowOffset = CGSize(width: -1, height: 1)
          layer.shadowRadius = 2

//          layer.shadowPath = UIBezierPath(rect: bounds).cgPath
          layer.shouldRasterize = true
          layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIImageView {
    func setImageKF(with urlString: String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        kf.indicatorType = .activity
        self.kf.setImage(with: resource)
    }
}

extension UIViewController{
    func loader  () ->UIAlertController{
        let alert = UIAlertController(title: nil, message:"load data", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 6, width:50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large
        alert.view.addSubview(indicator)
        present(alert,animated: true,completion: nil)
        return alert
    }
    
    func stopLoader (loader:UIAlertController){
        DispatchQueue.main.async {
            loader.dismiss(animated: true,completion: nil)
        }
    }
}
