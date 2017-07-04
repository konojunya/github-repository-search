//
//  GitHubRepositoryTableViewCell.swift
//  github-repostory-search
//
//  Created by konojunya on 2017/07/04.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import UIKit
import AlamofireImage

class GitHubRepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var languageNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(repository: GithubRepository) {
        ownerAvatarImageView.af_setImage(withURL: URL.init(string: (repository.user?.avatarUrl)!)!)
        repositoryNameLabel.text = repository.name
        ownerNameLabel.text = repository.user?.name
        starCountLabel.text = "☆:" + (repository.starNumber?.description)!
        languageNameLabel.text = repository.language
    }
    
}
