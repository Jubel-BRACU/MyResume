# Application Type
UIKit

# Application Name
My Resume

# Objective
This app is an iOS App representation of my Resume. It's a failry intutive app, once installed and run. 

In short however:

- the app launches to a main screen which uses a segement controller to switch between various information screens (view controllers) that show case various aspects of my career within the software development industry, iOS Development, as well as highlighting iOS Projects developed, education and vocational training / certfications. 

- Additonal informaton can be sought on the experience and iOS Projects segments by clicking the more link. This will display a Details Screen (Detail View Controller) with more information.

- There is also a short gif included further below in this readme file demonstrating the app.


# Additonal notes for Udacity Rubric Assessor/s
I have highlighted here how some of the specific rubric criteria has been met: 


*//Networking service rubric requirement:*
- app uses URLSession to fetch json data enclosed within a file located on a remote server (google drive)
- app also fetches images from files also located on a remote server (google drive)
- app uses JSON Decoder to decode fetched json
- above networking code is encapsulated within its own class


*//Networking failure alert rubric requirement:*
- if download of json file fails for any reason, an alert is displayed to the user


*//UIActivity Indicator rubric requirement:*
- when app is first launched, app displays a activity indicator whilst json file / data is fetched and loaded from the remote (google drive) server
- app also displays activity indicator whilst any images are downloaded from the remote (google drive) server (on the item DetailViewController)


*//Data Persistence rubric requirement:*
- json data fetched from remote (google drive) server is saved as permanalty as NSObject within core data (Note! images fetched and dsiplayed on the DetailViewController are not persisted by design, to demonstarte networking per app launch without needing to uninstall and reinstall app).


*//Installation and build requirements:*
- app developed with Xcode v11x using iOS v13x APIs. Please run on devices running iOS 13 and above
- Supported iOS devices: iPhones only, running iOS 13x


# Demo
![Demo](Demo_29122019.gif)

# Core Technologies

- UIKit

- Core Data

- SafariServices (launch safari / load websites in app)

- MessageUI (launch email app / compos email message in app)

- .open(URL: ) (call phone number in app)

- ContainerView

- MVC

- UICollectionView

- Custom UICollectionViewCell

- UICollectionViewCompositionalLayout

- SegmentController

- Storybaords

- .xib files

- URLSession Networking 

- dataTask (fetch images from emote server)

- downloadTask (dwonlaod json file from remoe server)

- JSON Encoder / Decoder

- @escaping functions (completion handler)

- enum

- extensions (UIView, UICollectionView, ViewController)

- Git / Github


# Versions
- June, 2020 (version 2)

- December, 2019 (version 1)

# Deployment information

- <strong>Deployment Target (iOS version):</strong> 13.x
- <strong>Supported Devices: </strong>iPhone only

