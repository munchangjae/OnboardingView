//
//  ViewController.swift
//  soloPhotoGallery
//
//  Created by 문창재 on 2022/07/10.
//

import UIKit
import PhotosUI



class ViewController: UIViewController {

    

    @IBOutlet weak var PhotoCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PhotoGallery"
        PhotoCollectionView.dataSource = self
        make_button_navigationBar()
        setLayout()
        
        
    }

    func setLayout() {
        
        let layout = UICollectionViewFlowLayout()
        
        
        layout.itemSize = CGSize(width: 100, height: 300)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        

        PhotoCollectionView.collectionViewLayout = layout
        
    }
    
    func make_button_navigationBar() {
        
        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo.artframe"), style: .done, target: self, action: #selector(checkPermission))
        
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise.circle"), style: .done, target: self, action: #selector(refreshPhoto))
        
        self.navigationItem.rightBarButtonItem = photoItem
        self.navigationItem.leftBarButtonItem = refreshItem
        
    }
    
    @objc func showGallery() {
        let photoLibrary = PHPhotoLibrary.shared()
        
        var photoConfiguration = PHPickerConfiguration(photoLibrary: photoLibrary)
        
        photoConfiguration.selectionLimit = 10
        
        let picker = PHPickerViewController(configuration: photoConfiguration)
        
        picker.delegate = self
        
        present(picker, animated: true)
        
        
    }
    
    @objc func refreshPhoto() {
        
    }

    @objc func checkPermission() {
        if PHPhotoLibrary.authorizationStatus() == .authorized || PHPhotoLibrary.authorizationStatus() == .limited
        {
            self.showGallery()
        }
        else if PHPhotoLibrary.authorizationStatus() == .denied
        {
            let alert = UIAlertController(title: "갤러리 접근 권한을 활성화 해주세요.", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "닫기", style: .cancel))
            alert.addAction(UIAlertAction(title: "설정으로 가기", style: .default, handler: { action in
                
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(url) {
                 
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                
            }))
            
            self.present(alert, animated: true)
        }
    }
    
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        
        return cell
    }
    
    
}


extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
    }
    
    
}
