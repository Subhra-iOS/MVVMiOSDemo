//
//  TableViewCell.swift
//  MVVMDemo1
//
//  Created by Subhra Roy on 24/08/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    private var  cellViewModel : TableCellViewModel? {
        
        didSet{
            self.titleLabel.text = cellViewModel?.title
             self.subTitleLabel.text = cellViewModel?.subTitle
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWithCellViewModel(viewModel : TableCellViewModel) -> Void{
        
        self.cellViewModel = viewModel
        
    }

}
