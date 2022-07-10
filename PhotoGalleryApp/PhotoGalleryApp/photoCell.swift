//
//  photoCell.swift
//  PhotoGalleryApp
//
//  Created by 문창재 on 2022/06/09.
//

import UIKit
import Photos

class photoCell: UICollectionViewCell {
    
    func loadImage(asset: PHAsset) {
        
        let imageManager = PHImageManager()
        // 이미지 관리하는 기능
        let Scale = UIScreen.main.scale
        
        let imageSize = CGSize(width: 150 * Scale, height: 150 * Scale)
        // 아이폰 화면에서 픽셀을 뭐 배수? 로 쓸 수도 있기때문에 스케일을 곱해줘야 정확한 150 값으로 사진 크기를 정할 수 있음
        
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: nil) { image, info in
            self.photoImageView.image = image
        }
    
    }
    
    @IBOutlet weak var photoImageView: UIImageView!
    {
        didSet {
            photoImageView.contentMode = .scaleAspectFill
        }
    }
}
