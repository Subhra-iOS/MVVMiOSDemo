//
//  RootViewModel.swift
//  MVVMDemo1
//
//  Created by Subhra Roy on 24/08/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import UIKit

protocol RootViewModelProtocol : NSObjectProtocol{
    func didFinishLoadingOfData() -> Void
    func didFinishLoadingErrorWith( error : Error?) -> Void
}

class RootViewModel: NSObject {
    
    public private(set) var dataListArray : [TableCellViewModel]?
    private var dataModels : [FinanceModel]?
    private weak var  rootDelegate : RootViewModelProtocol?
    
    func serviceCallWith(array : [[String : String]]) -> Void{
    
        let arrayStr = self.jsonEncodeWith(array: array)
        ServiceManager().fetchDataFromServer(staticJson : arrayStr) {  (data, error) in
            
            if let responseArr : [FinanceModel] = data  as? [FinanceModel], responseArr.count > 0 {
                print("\(responseArr)")
                
                self.dataModels = responseArr
                self.dataListArray =  responseArr.map({ (model) -> TableCellViewModel in
                    return  TableCellViewModel(title: model.title, subTitle: model.description)
                })
                
                print("\(String(describing: self.dataModels))")
                print("\(String(describing: self.dataListArray))")
                
                self.rootDelegate?.didFinishLoadingOfData()
                
            }else{
                self.rootDelegate?.didFinishLoadingErrorWith(error: error)
            }
            
        }
        
    }
    
    func setViewModelDelegateWith(delegate : RootViewModelProtocol?){
        self.rootDelegate = delegate
    }

    func jsonEncodeWith(array : [[String : String]]) -> String{
        
        var jsonString : String?
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(array)
            jsonString = String(data: jsonData, encoding: .utf8) ??  ""
            
        }
        catch {
        }
        
        return jsonString!
    }
    
    deinit {
        print("RootViewModel dealloc")
    }
    
}

extension RootViewModel{
    
    func tableViewNumberOfRowsInSection() -> Int {
        return dataListArray?.count ?? 0
    }
    
}
