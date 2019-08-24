//
//  RootModel.swift
//  MVVMDemo1
//
//  Created by Subhra Roy on 24/08/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import UIKit


//class Companies: Codable {
//    var companies : [FinanceModel]
//}


class FinanceModel: Codable {

    public var title : String?
    public var description : String?

    
    convenience init(title : String?, subTitle : String?){
        self.init()

        self.title = title
        self.description = subTitle
    }

    deinit {
        print("FinanceModel dealloc")
    }
    
}
