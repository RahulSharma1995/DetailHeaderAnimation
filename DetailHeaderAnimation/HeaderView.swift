//
//  HeaderView.swift
//  DetailHeaderAnimation
//
//  Created by Rahul Sharma on 27/01/23.
//

import UIKit

struct Track {
    let imageName: String
}

class HeaderView: UICollectionReusableView {
    static let reuseIdentifier = "header_supplementary_reuse_identifier"
    var imageView = UIImageView()
    
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    var yConstraint: NSLayoutConstraint?
    
    var isFloating: Bool = false
    
    var track: Track? {
           didSet {
               guard let track = track else { return }
               let image = UIImage(named: track.imageName) ?? UIImage(named: "placeholder")!

               imageView.image = image
           }
       }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension HeaderView {
    
    func layout() {
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        widthConstraint = imageView.widthAnchor.constraint(equalToConstant: 300)
        heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 300)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
//            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            widthConstraint!,
            heightConstraint!
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 300)
    }
}

extension HeaderView {
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let y = scrollView.contentOffset.y
        
        guard let widthConstraint = widthConstraint, let heightConstraint = heightConstraint else { return }
        
        let normalizedScroll = y/2
        
        widthConstraint.constant = 300 - normalizedScroll
        heightConstraint.constant = 300 - normalizedScroll
        
        if isFloating {
            isHidden = y > 200
        }
        
        let normalizedAlpha = y / 200
        alpha = 1.0 - normalizedAlpha
        
    }
}
