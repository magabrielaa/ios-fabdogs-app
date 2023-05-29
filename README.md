# FabDogs App

## Empty Data from the API
In the case that the list of dogs comes back empty from the API, I added a `case emptyData` in [DogService](https://github.com/MPCS-51039/ios-project-magabrielaa/blob/testing-and-alerts/FabDogs/FabDogs/Data/DogService.swift), where the completion returns an empty array `[]` and `DogCallingError.emptyData`.

Then, on [DogListViewController](https://github.com/MPCS-51039/ios-project-magabrielaa/blob/testing-and-alerts/FabDogs/FabDogs/Controllers/DogListViewController.swift) I added two things:

- In `UITableViewDataSource` I check if the list of dogs is empty, and if so, I create 1 single cell in the tableView.
- I format that cell to display a text label that alerts the user **"There are currently no dogs"**

## Lack of internet connection
I also created a function called `fetchDogs()` in [DogListViewController](https://github.com/MPCS-51039/ios-project-magabrielaa/blob/testing-and-alerts/FabDogs/FabDogs/Controllers/DogListViewController.swift), in which, if the `DogService` returns an error, it alerts the user with a `UIAlertController` with the message **"Failed to fetch dogs"**. The user is given two options: "OK" and "Retry":

- If the user taps on "OK" --> the tableView reloads and presents an empty list of cells. This is a risk mitigation choice to stop the user from clicking on a cell from a previous API call and going to a DetailView that is conditioned on the API call to display information.

- If the user taps on "Retry --> The `fetchDogs()` calls itself recursively to make a new call to the API and load the cells, if the API call is successful. Otherwise, it will display the `UIAlertController` again. 