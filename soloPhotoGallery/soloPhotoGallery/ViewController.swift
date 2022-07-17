//
//  ViewController.swift
//  soloPhotoGallery
//
//  Created by 문창재 on 2022/07/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var PhotoCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PhotoGallery"
        
    }

    func make_button_navigationBar() {
        
        let photoItem = UIBarButtonItem(image: UIImage(systemName: <#T##String#>), style: .done, target: self, action: <#T##Selector?#>)
        
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: <#T##String#>), style: <#T##UIBarButtonItem.Style#>, target: <#T##Any?#>, action: <#T##Selector?#>)
        
        self.navigationItem.rightBarButtonItem = photoItem
        self.navigationItem.leftBarButtonItem = refreshItem
        
    }
    
    

}

