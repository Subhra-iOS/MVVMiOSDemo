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
    func didFinishInsertItemsWith(model :  TableCellViewModel?)
}

class RootViewModel: NSObject {
    
    public private(set) var dataListArray : [TableCellViewModel]?
    private var dataModels : [CompanyModel]?
    private weak var  rootDelegate : RootViewModelProtocol?
    
    func serviceNewCall(response : [String : Any]) -> Void{
        
        print("\(response)")
        
        let response : Data = try! JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        ServiceManager().fetchDataFromServer(staticData: response) {  (data, error) in
            
            if let finalData : ITCompany = data as? ITCompany , let responseArr : [CompanyModel] = finalData.result , responseArr.count > 0 {
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
    
    func serviceCallWith(array : [[String : String]]) -> Void{
    
        let arrayStr = self.jsonEncodeWith(array: array)
        ServiceManager().fetchDataFromServer(staticJson : arrayStr) {  (data, error) in
            
            if let responseArr : [CompanyModel] = data  as? [CompanyModel], responseArr.count > 0 {
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

   private func jsonEncodeWith(array : [[String : String]]) -> String{
        
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
    
//    private func jsonEncodeWith(result : [String : Any]) -> String{
//
//        var jsonString : String?
//        let jsonEncoder = JSONEncoder()
//        jsonEncoder.outputFormatting = .prettyPrinted
//        do {
//
//            let jsonData = try jsonEncoder.encode(<#T##value: Encodable##Encodable#>)
//            jsonString = String(data: jsonData, encoding: .utf8) ??  ""
//        }
//        catch {
//        }
//
//        return jsonString!
//    }
    
    deinit {
        print("RootViewModel dealloc")
    }
    
}

extension RootViewModel{
    
    func tableViewNumberOfRowsInSection() -> Int {
        return dataListArray?.count ?? 0
    }
    
}

extension  RootViewModel{
    
    func deleteStatusForViewModel(model : TableCellViewModel?) -> (state : Bool, currentIndex : Int){
        
        guard let cellViewModel : TableCellViewModel = model, let index = self.getModelIndexAtCollectionWith(item: cellViewModel) else {
            return (state : false, currentIndex : 0)
        }
        
        let status : Bool = self.removeModelAtIndex(index: index)
        self.dataListArray?.remove(at: index)

        return (state : status, currentIndex : index)
    }
    
    private func getModelIndexAtCollectionWith(item : TableCellViewModel) -> Int?{
        
        guard let viewModelArr :  [TableCellViewModel] = self.dataListArray,  viewModelArr.count > 0 else {
            return 0
        }
        
        let index : Int? = viewModelArr.lastIndex(where: { (currentModel) -> Bool in
            
            return   item.title?.isEqual(currentModel.title) ??  false
            
        })
        
        return index
    }
    
   private func removeModelAtIndex(index : Int) -> Bool{
        
        guard let viewModelArr :  [TableCellViewModel] = self.dataListArray,  viewModelArr.count > 0 else {
            
            let cellViewModel : TableCellViewModel = self.dataListArray![0]
            let restModels : [CompanyModel]? = self.dataModels?.filter({ (deletedModel) -> Bool in
                
                return  !(deletedModel.title?.isEqual(cellViewModel.title))!
                
            })
            self.dataModels = restModels
            
            return false
        }
        
        let cellViewModel : TableCellViewModel = viewModelArr[index]
        let restModels : [CompanyModel]? = self.dataModels?.filter({ (deletedModel) -> Bool in
            
            return  !(deletedModel.title?.isEqual(cellViewModel.title))!
            
        })
        
        self.dataModels = restModels
        return true
        
    }
    
    
}
