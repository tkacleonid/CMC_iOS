//
//  ViewControllerForecasts.swift
//  Weather
//
//  Created by user131596 on 11/30/17.
//  Copyright © 2017 Alexandr Poroshin. All rights reserved.
//

import UIKit

class ViewControllerForecasts: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var ForecastTableView: UITableView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! ForecastTableViewCell
        
        //cell.name.text = table_data[indexPath.section].data[indexPath.row]
        //cell.index.text = String(indexPath.row)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return table_data[section].data.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return table_data.count
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var table_data = Array<TableData>()
    
    struct TableData
    {
        var section:String = ""
        var data = Array<String>()
        init(){}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ForecastTableView.dataSource = self
        ForecastTableView.delegate = self
        
        var new_elements:TableData
        
        new_elements = TableData()
        new_elements.section = "Section 1"
        new_elements.data.append("Element 1")
        new_elements.data.append("Element 2")
        new_elements.data.append("Element 3")
        new_elements.data.append("Element 4")
        new_elements.data.append("Element 5")
        new_elements.data.append("Element 6")
        new_elements.data.append("Element 7")
        
        table_data.append(new_elements)
        
        
        new_elements = TableData()
        new_elements.section = "Section 2"
        new_elements.data.append("Element 1")
        new_elements.data.append("Element 2")
        
        table_data.append(new_elements)
        
        new_elements = TableData()
        new_elements.section = "Section 3"
        new_elements.data.append("Element 1")
        new_elements.data.append("Element 2")
        new_elements.data.append("Element 3")
        new_elements.data.append("Element 4")
        new_elements.data.append("Element 5")
        new_elements.data.append("Element 6")
        new_elements.data.append("Element 7")
        
        table_data.append(new_elements)
        
        self.ForecastTableView.reloadData()
        
    }
    

}
