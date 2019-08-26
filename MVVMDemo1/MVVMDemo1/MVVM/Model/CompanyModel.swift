//
//  RootModel.swift
//  MVVMDemo1
//
//  Created by Subhra Roy on 24/08/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import UIKit


class ITCompany :  Codable {
    public var responseCode : Int
    public var result : [CompanyModel]?
    
   /* private enum CodingKeys: String, CodingKey {
        case responseCode
        case result
    }
    
    init(code : Int, resultCollection : [[String : Any]]) {
        
        self.responseCode = code
        self.result = resultCollection.map({ ([String : Any]) -> CompanyModel in
            
            
            
        })
    }
    
    func decode(from decoder : Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result =  try container.decode(Array.self, forKey: ITCompany.CodingKeys.result)
        responseCode = try container.decode(Int.self, forKey: ITCompany.CodingKeys.responseCode)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(responseCode, forKey: .responseCode)
        try container.encodeIfPresent(result, forKey: .result)
       
    }*/
    
    deinit {
        print("ITCompany dealloc")
    }

}

class CompanyModel: Codable {

    public var title : String?
    public var description : String?

    private enum CodingKeys : String, CodingKey{
        case  title = "company_title"
        case  description
    }
    
//    func decode(from decoder : Decoder) throws{
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.title  =  try container.decode(String.self, forKey: CompanyModel.CodingKeys.title)
//        self.description = try container.decode(String.self, forKey: CompanyModel.CodingKeys.description)
//    }
    
    convenience init(title : String?, subTitle : String?){
        self.init()

        self.title = title
        self.description = subTitle
    }

    deinit {
        print("CompanyModel dealloc")
    }
    
}
