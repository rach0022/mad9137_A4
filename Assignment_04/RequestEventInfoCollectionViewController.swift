//
//  RequestEventInfoCollectionViewController.swift
//  Assignment_04
//
//  Created by Ravi Rachamalla on 2020-11-24.
//

import UIKit

//private let reuseIdentifier = "Cell"

class RequestEventInfoCollectionViewController: UICollectionViewController {
    // Properties for the URLRequestTableViewController
    var responseJSONArray: [[String: String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // using the size of the responseJSONArray we can determine the number of cells
        if let jsonData = self.responseJSONArray {
            return jsonData.count
        } else {
            return 0
        }
    }
    
    // override the collectionView function to update the cells based on the
    // response from the API (contained in responseJSONArray)
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // typecast the cell as my custom LoadEventTableViewCell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventInfoCell", for: indexPath) as? EventInfoCollectionViewCell
    
        // Configure the cell... after checking if we have JSONData or not
        if let jsonData = self.responseJSONArray as [[String:String]]? {
            // loop through the jsonData array to access the individual values
            let title = jsonData[indexPath.row]["eventTitle"]
            let time = jsonData[indexPath.row]["eventDate"]
            
            if let myCell = cell {
                myCell.cellEventTitle?.text = title
                myCell.cellEventDate?.text = time
                
            }

        }
    
        return cell!
    }
    
    // fucntion that fires when the user clicks the load button in the navigation bar
    @IBAction func loadEventInfoBarButtonAction(_ sender: Any) {
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
            self.collectionView.reloadData()
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
