//
//  ScoreCollectionViewCell.swift
//  SnakeGame
//
//  Created by Svetlana Timofeeva on 11/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class ScoreCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "Cell"
    
    weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            self.contentView.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
            ])
        self.textLabel = textLabel
        self.reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }
    
    func reset() {
        self.textLabel.textAlignment = .left
    }
}
