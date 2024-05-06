# Behavioral Data Hub

The behavioral data hub is a tool designed to enhance the ease of data collection for researchers interested in cardiovascular disease. 
This app will collect and aggregate data from research participants who connect their wearable devices.

For the frontend, we used Flutter to have an app that can easily be used across different platforms, greatly increasing our ability to develop by freeing us from the need to write specific ports for each platform. Additionally, it has seamless integration with Visual Studio Code, reducing the work needed to get things running to begin with.

For the backend, we used .NET C#. It is a versatile and powerful framework that can be used to create the API we need to power the frontend. Several members of our team have experience using this framework in internships, making it a clear choice. We are using Visual Studio as our IDE of choice for the backend.

Our database runs off of Microsoft SQL Server. This choice was made to have easy integration into the suite of tools we're already using (Visual Studio supports connecting to SQL Server natively), as well as having familiar syntax while also maintaining power.

# Release Notes

## 0.0.0

### Features
- Research participants (At this point, the only user group) are able to self-report their own data
  - Currently this is limited to height and weight  
- Research participants can view the data that they've uploaded
- Users are able to navigate their main menu, although not every page past this menu is viewable
  - In the future, there will be more options for each user to choose from.

### Bug Fixes
None

### Known Issues
- Password box does not hide input characters
- If a user has no data, the loading spinner in the data view screen will run indefinitely
- Currently no actual login and password data to make verifiable login

### Future Development Plans
- Complete rest of application features
- Further develop API and database
- Incorporate machine learning algorithms
