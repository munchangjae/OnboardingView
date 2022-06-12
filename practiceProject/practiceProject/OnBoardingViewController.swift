//
//  OnBoardingViewController.swift
//  practiceProject
//
//  Created by 문창재 on 2022/06/02.
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var TopImage: UIImageView!
    @IBOutlet weak var TopTitle: UILabel! {
        didSet{
            TopTitle.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        }
    }
    @IBOutlet weak var BottomTitle: UILabel!
    
    var topImage: String = "onboard1"
    var topTitle: String = "label"
    var bottomTitle: String = "label"

    override func viewDidLoad() {
        super.viewDidLoad()

        TopTitle.text = topTitle
        TopImage.image = UIImage(named: topImage)
        BottomTitle.text = bottomTitle
       
    }




}
