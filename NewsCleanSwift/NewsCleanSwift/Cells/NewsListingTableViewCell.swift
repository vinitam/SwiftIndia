//
//  NewsListingTableViewCell.swift
//  NewsCleanSwift
//
//  Created by Vinita Miranda on 17/04/18.
//  Copyright © 2018 Vinita Miranda. All rights reserved.
//

import UIKit

class NewsListingTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(displayArticle: NewsListing.Fetch.ViewModel.DisplayArticle) {
        self.titleLabel.text = displayArticle.displayTitle
        self.subtitleLabel.text = displayArticle.displayAuthor
        iconImage.sd_setImage(with: URL(string: displayArticle.displayIconUrl))
    }
}
