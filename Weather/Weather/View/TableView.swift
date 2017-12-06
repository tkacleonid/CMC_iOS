//
//  TableView.swift
//  Weather
//
//  Created by Leonid Tkachenko on 01/11/2017.
//  Copyright © 2017 Leonid Tkachenko. All rights reserved.
//

import UIKit

class TableView: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch (identifier) {
            case "MoscowSegue":
                if let vc = segue.destination as? ViewController {
                    vc.weather = DayWeather()
                    vc.weather.cityEng = "Moscow"
                    vc.weather.city = "Москва"
                }
            case "LondonSegue":
                if let vc = segue.destination as? ViewController {
                    vc.weather = DayWeather()
                    vc.weather.cityEng = "London"
                    vc.weather.city = "Лондон"
                }
            case "ParisSegue":
                if let vc = segue.destination as? ViewController {
                    vc.weather = DayWeather()
                    vc.weather.cityEng = "Paris"
                    vc.weather.city = "Париж"
                }
            case "NewYorkSegue":
                if let vc = segue.destination as? ViewController {
                    vc.weather = DayWeather()
                    vc.weather.cityEng = "New_York"
                    vc.weather.city = "Нью-Йорк"
                }
            case "LosAngelesSegue":
                if let vc = segue.destination as? ViewController {
                    vc.weather = DayWeather()
                    vc.weather.cityEng = "Los_Angeles"
                    vc.weather.city = "Лос Анджелес"
                }
            case "BerlinSegue":
                if let vc = segue.destination as? ViewController {
                    vc.weather = DayWeather()
                    vc.weather.cityEng = "Berlin"
                    vc.weather.city = "Берлин"
                }
            case "TokyoSegue":
                if let vc = segue.destination as? ViewController {
                    vc.weather = DayWeather()
                    vc.weather.cityEng = "Tokyo"
                    vc.weather.city = "Токио"
                }
            case "CairoSegue":
                if let vc = segue.destination as? ViewController {
                    vc.weather = DayWeather()
                    vc.weather.cityEng = "Cairo"
                    vc.weather.city = "Каир"
                }
            case "SaintPetersburgSegue":
                if let vc = segue.destination as? ViewController {
                    vc.weather = DayWeather()
                    vc.weather.cityEng = "Saint_Petersburg"
                    vc.weather.city = "Санкт-Петербург"
                }
            case "RioDeJaneiroSegue":
                if let vc = segue.destination as? ViewController {
                    vc.weather = DayWeather()
                    vc.weather.cityEng = "Rio_De_Janeiro"
                    vc.weather.city = "Рио-де-Жанейро"
                }
            default:
                break
            }
        }
        
    }
    
}








