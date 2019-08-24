//
//  TableCellViewModel.swift
//  MVVMDemo1
//
//  Created by Subhra Roy on 24/08/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import UIKit

struct  TableCellViewModel {

    public var title : String?
    public var subTitle : String?
    
     init(title : String?, subTitle : String?){        
        self.title = title
        self.subTitle = subTitle
    }
    
}
