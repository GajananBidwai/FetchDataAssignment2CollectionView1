//
//  PostCollectionViewCell.swift
//  FetchDataAssignment2CollectionView1
//
//  Created by Mac on 23/12/23.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var albumId: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var url: UIImageView!
    @IBOutlet weak var thumbnailUrl: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

}
