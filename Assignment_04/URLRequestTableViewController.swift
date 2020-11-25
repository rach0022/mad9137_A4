//
//  URLRequestTableViewController.swift
//  Assignment_04
//
//  Created by Ravi Rachamalla on 2020-11-24.
//

import UIKit

class URLRequestTableViewController: UITableViewController {
    
    // Properties for the URLRequestTableViewController
    var responseJSONArray: [[String: String]]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let jsonData = self.responseJSONArray {
            return jsonData.count
        } else {
            return 0
        }
    }
    
    // the function for TableView(cellforRowAtIndexPath) method to customize the table cells with our JSON Data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // typecast the cell as my custom LoadEventTableViewCell object
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResponseTableCell", for: indexPath) as? LoadEventTableViewCell
        // Configure the cell... after checking if we have JSONData or not
        if let jsonData = self.responseJSONArray {
            // loop through the jsonData array to access the individual values
            for thisDictionary in jsonData {
                // first lets unwrap the cell and then set the cellEventTitle and cellEventTime labels text values
                if let myCell = cell {
                    myCell.cellEventTitle?.text = thisDictionary["eventTitle"]
                    myCell.cellEventTime?.text = thisDictionary["eventDate"]
                    
                }
            }
        }
        
        // return the cell object
        return cell!
    }
    
    // My Actions
    // IBACtion for the load button
    
    @IBAction func loadBarButtonItemAction(_ sender: Any) {
        // first create the URL
        let loadURL: URL = URL(string: "https://lenczes.edumedia.ca/mad9137/a4/respond.php")!
        
        //create the request based on the loadURL
        let loadURLRequest: URLRequest = URLRequest(url: loadURL)
        
        // create the session using the shared session ( the URL session
        // object) that is used to make requests
        let loadSession: URLSession = URLSession.shared
        
        // make the task from the session by passing in the loadRequest and then execute the task
        let loadTask = loadSession.dataTask(with: loadURLRequest, completionHandler: requestLoadTask)
        loadTask.resume()
    }
    
    // the completeion handler function callback for the loadTask
    func requestLoadTask(serverData: Data?, serverResponse: URLResponse?, serverError: Error?) -> Void {
        // first lets check if an error occured, if it did send an error message using a guard statement
        guard serverError == nil  else {
            self.loadEventCallback(responseString: "", error: serverError!.localizedDescription)
            return
        }
        // now that we know a server error hasnt occured lets use the response
        // first strigify the response data
        let response = String(data: serverData!, encoding: String.Encoding.utf8)!
        
        self.loadEventCallback(responseString: response as String, error: nil)
    }
    
    // the loadEventCallback function to handle the data from the APi response
    func loadEventCallback(responseString: String, error: String?) {
        // first define the string responsible for outputting the value of the response
        var outputString: String?
        
        // now check if we have an error or not, print to the console whatever comes back
        if error != nil {
            print("ERROR: \(error!)")
        } else {
            print("DATA is: \(responseString)")
            outputString = responseString
        }
        
        // now with the output string lets convert it into a JSON object
        if let jsonData: Data = outputString?.data(using: String.Encoding.utf8){
            do {
                self.responseJSONArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: String]]
            }
            catch let convertError {
                print("Error Converting: \(convertError.localizedDescription)")
            }
        }
        
        // now lets reload data on the main thread using the DispatchQueue object
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
