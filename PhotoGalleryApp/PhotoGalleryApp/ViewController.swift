//
//  ViewController.swift
//  PhotoGalleryApp
//
//  Created by 문창재 on 2022/06/09.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {

    var fetchResults: PHFetchResult<PHAsset>?
    // 전역변수 설정
    
    
    @IBOutlet weak var PhotoCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        PhotoCollectionView.dataSource = self
        
        self.title = "PhotoGallery"
        
        makeNavigationItem()
        setLayout()
    }


    func makeNavigationItem() {
        let PhotoItem = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle"), style: .done, target: self, action: #selector(checkPermission))
        
        self.navigationItem.rightBarButtonItem = PhotoItem // 네비게이션 아이템에 올리는거
        
        let RefreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refreshImage))
        
        self.navigationItem.leftBarButtonItem = RefreshItem // 네비게이션 아이템에 올리는거
        
    }
    
    func setLayout() {
        let layout = UICollectionViewFlowLayout()
        let halfOfScreen = UIScreen.main.bounds.width - 1
        
        layout.itemSize = CGSize(width: halfOfScreen / 2, height: 200)
        layout.minimumLineSpacing = 1 // 위아래 차이
        layout.minimumInteritemSpacing = 1 // 양 옆 차이
        
        
        
        PhotoCollectionView.collectionViewLayout = layout
    }
    
    
    
  
    @objc func showGallery() {
        let library = PHPhotoLibrary.shared()
        
        var configuration = PHPickerConfiguration(photoLibrary: library)
        configuration.selectionLimit = 10
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        
        present(picker, animated: true)
        
        
    }

    @objc func refreshImage() {
        self.PhotoCollectionView.reloadData()
    }
    
    @objc func checkPermission() {
            if PHPhotoLibrary.authorizationStatus() == .authorized || PHPhotoLibrary.authorizationStatus() == .limited { // 포토라이브러리 허가 상태가 허가됐거나 제한적 허가상태면 갤러리 연다.
                DispatchQueue.main.async {
                    self.showGallery()
                }
            
                
            } else if PHPhotoLibrary.authorizationStatus() == .denied { // 거부되어있으면 설정으로 열게한다.
                DispatchQueue.main.async {
                    self.showAuthorizationDeniedAlert()
                }
            } else if PHPhotoLibrary.authorizationStatus() == .notDetermined{
                PHPhotoLibrary.requestAuthorization{ status in
                    self.checkPermission() // 체크 퍼미션 안에서 체크 퍼미션이 재실행 되는 것이므로 나머지 로직들은 다른 쓰레드에서 계속 실행되고 있어야함. ui변경 작동 등등은 메인에서 일어나야함.
                }
            }
            
        }
    
    @objc func showAuthorizationDeniedAlert() {
            let alert = UIAlertController(title: "포토라이브러리 접근 권한을 활성화 해주세요", message: nil, preferredStyle: .alert) // alert은 화면 가운데 탁 뜨는거 액션시트는 밑에서 올라오는거
            
            alert.addAction(UIAlertAction(title: "닫기", style: .cancel))
            alert.addAction(UIAlertAction(title: "설정으로 가기", style: .default, handler: {
                action in
                
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

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResults?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! photoCell
        
        if let asset = self.fetchResults?[indexPath.row] {
            cell.loadImage(asset: asset)
        }
        
        
        
        return cell
    }
    
    
}


extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        let identifier = results.map{ $0.assetIdentifier ?? ""}
        // array형태의 results 안에 들어있는 assetIdentifier를 map으로 가져오는 것.
        
        self.fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: identifier, options: nil)
        // PHAsset 기능들 중 하나인 fetchAssets은 asset에서 identifier를 가져온다.
        // 전역변수로 설정해놨던 fetchResults에 넣는다.
        
        self.PhotoCollectionView.reloadData()
        
        self.dismiss(animated: true)
    }
    
    
}
