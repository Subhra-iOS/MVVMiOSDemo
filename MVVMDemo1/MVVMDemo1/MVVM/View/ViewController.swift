//
//  ViewController.swift
//  MVVMDemo1
//
//  Created by Subhra Roy on 24/08/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import UIKit

private let cellIdentifier = "cellIdetifier"
class ViewController: UIViewController {

    @IBOutlet weak var dataListTable: UITableView!
    @IBOutlet weak var rootViewModel: RootViewModel!
    
    let financeArr = [["title" : "ARC", "description" : "A print and tech product base Company"], ["title" : "CTS", "description" : "A service and tech Company"], ["title" : "IBM", "description" : "A service and tech Company"], ["title" : "Accenture", "description" : "A service and tech Company"], ["title" : "Capgemini", "description" : "A service and tech Company"], ["title" : "Google", "description" : "A product b Company"], ["title" : "Microsoft", "description" : "A product based Company"], ["title" : "Apple", "description" : "A product based Company"]]
    
    let resultDict : [String : Any] = ["responseCode" : 200, "result" : [["title" : "ARC", "description" : "A print and tech product base Company"], ["title" : "CTS", "description" : "A service and tech Company"], ["title" : "IBM", "description" : "A service and tech Company"], ["title" : "Accenture", "description" : "A service and tech Company"], ["title" : "Capgemini", "description" : "A service and tech Company"], ["title" : "Google", "description" : "A product b Company"], ["title" : "Microsoft", "description" : "A product based Company"], ["title" : "Apple", "description" : "A product based Company"]]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      //  self.dataListTable.register(UINib(nibName: "TableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
        self.rootViewModel.setViewModelDelegateWith(delegate: self)
       //self.rootViewModel.serviceCallWith(array: financeArr)
        self.rootViewModel.serviceNewCall(response: resultDict)
        
    }

}

extension ViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rootViewModel.tableViewNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        
        if let dataCollections : [TableCellViewModel] = self.rootViewModel.dataListArray, dataCollections.count > 0{
            let cellViewModel : TableCellViewModel = dataCollections[indexPath.row]
            cell.configureCellWithCellViewModel(viewModel: cellViewModel)
        }
        return cell
    }
    
}

extension ViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
            case .delete:
                let model : TableCellViewModel? = self.rootViewModel.dataListArray?[indexPath.row]
                let status = self.rootViewModel.deleteStatusForViewModel(model: model)
                if  status.state {
                    self.dataListTable.beginUpdates()
                    self.dataListTable.deleteRows(at: [IndexPath(row: status.currentIndex , section: 0)], with: .automatic)
                    self.dataListTable.endUpdates()
            }
                
            case .insert : break
            default : break
        }
        
    }
    
}

extension  ViewController : RootViewModelProtocol{
    
    func didFinishInsertItemsWith(model: TableCellViewModel?) {
        
    }
    
    func didFinishLoadingErrorWith(error: Error?) {
        print("\(String(describing: error))")
    }
    
    func didFinishLoadingOfData() {
        
        DispatchQueue.main.async { [unowned self] in
            self.dataListTable.reloadData()
        }
        
    }

}

