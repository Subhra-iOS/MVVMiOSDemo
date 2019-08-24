//
//  ServiceManager.swift
//  MVVMDemo1
//
//  Created by Subhra Roy on 24/08/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import Foundation

struct ServiceManager {

    func fetchDataFromServer( staticJson : String, completion :  @escaping (_ response : Any?, _ error : Error?) -> Void) -> Void{
     
        sleep(UInt32(5.0))
        print("\(staticJson)")
        let staticData : Data = staticJson.data(using: .utf8)!
        let  result  =  self.jsonConverterWith(data: staticData)
        print("\(String(describing: result))")
        completion(result, nil)
     
    }
}

extension  ServiceManager{
    
    private func jsonConverterWith(data : Data)  -> Any?{
    
        do{
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .useDefaultKeys
            let    foodModels  = try jsonDecoder.decode([FinanceModel].self, from: data)
            return foodModels
        }catch let error{
            print("\(error.localizedDescription)")
        }
        return nil
    }
    
}
