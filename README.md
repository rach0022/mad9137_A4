# Bugs
- [x] No table cells are showing after loading | SOLUTION: Forgot to set the number of sections
- [ ] Constraints are causing issues in LoadEventTableViewCell prototype cell
- [ ] The first element of the data dictionary is repeated for every element of the array 
# Marks Rubric
## Create Layout: (4pt total)

- [x] TableViewController with embedded Navigation Controller (2pt)
- [x] Add Bar Button Item to nav bar in table view labeled 'Load' (1pt)
- [x] Give prototype cell an Identifier name (1pt)

TableViewController class: (3pt total)

- [x] Create IBAction for 'Load' button (1pt)
- [x] Create jsonData object to hold response (2pt)

## Button Action function: (7pt total)

- [x] Create button Action (1pt)
- [x] Create URL (1pt)
- [x] Create Request using URL (1pt)
- [x] Create Session using shared session (1pt)
- [x] Create task object from session passing in request and completion handler (2pt)
- [x] Execute task (1pt)

## Completion Handler Request Task function: (9pt total)

- [x]  Create the completion handler function for the url session (2pt)
- [x] If the serverError is not nil, execute the callback function passing in empty string for data and description of error message (2pt)
- [x] If there was no error, convert the raw data to a utf8 json string, and execute callback passing in json string data, and nil for the error (5pt)

## Callback function: (12pt total)

- [x] Output the error if it's not nil using the print method (1pt)
- [x] If there is no error, print the json data (1pt)
- [x] Convert json string to data (2pt)
- [x] Attempt to convert the data to a json object stored in the jsonData object (3pt)
- [x] Catch and print out any errors in jsonData conversion (2pt)
- [ ] Call reloadData on tableView on main thread with dispatch async (3pt)

## TableView(numberOfRowsInSection) method: (3pt total)

- [x] Use optional binding to return json array count (2pt)
- [x] If the json data does not exist return 0 (1pt)

## TableView(cellForRowAtIndexPath) method: (7pt total)

- [x] Get a copy of the dequeued reusable cell (2pt)
- [x] Use optional binding to get the jsonData object if it exists, and get the current dictionary by using the indexPath.row (3pt)
- [x] Set each tableViewCell's textLabel with the 'eventTitle' and 'eventDate' values in the current json dictionary from the jsonData array (2pt)

## Project (5pt)

- [ ] Use a CollectionViewController with a custom CollectionViewCell with proper constraints instead of a TableViewController (15pt)
- [x] Code is clear and well-commented (10pt)
- [ ] Application runs without errors (5pt)


