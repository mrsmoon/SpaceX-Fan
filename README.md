# SpaceX Fan

## Work Plan for SpaceX Fan Project

I have looked over designs in Zeplin and created the simple plan below to follow:

1. Since some details at designs like custom tab bar, blur backgrounds, etc. are a little complex and may have some difficulties to implement, I will skip those parts for now and start with individual tab bar view controllers and basic UI designs. 
2. After I complete tab page designs, I will continue creating business logic. This part will include networking, data models, managers, persistent data storage and so on. I may use some cocoa pods here like Alamofire, Realm, etc.
3. I will add fingerprint authentication to reach favorites.
4. I will make tab bar integration after I see that all tab pages are individually running well.
5. As a design pattern, I will use MVVM and singleton. 
6. I will add Firebase Crashlytics and some app events to track.
7. If I have enough time, I can work on a bonus cloud service.

## Implementation Key Points

### Data Models
#### RocketModel: 
Created to use as a reference class to parse SpaceX API's JSON response

#### RocketData: 
A Realm object class to store rocket information persistently. It includes `isFavorite` property as an addition to RocketModel properties.

#### RocketManager:
A manager class that includes API call functions

#### RealmStore: 

A class to manage Realm database CRUD functions

### Libraries Used In The Project
1. RealmSwift: Persistent storage
2. SDWebImage: Image downloading and caching support
3. Firebase/Core: Analytics - App event tracking
4. Firebase/Crashlytics: App crash reporting

*Note*: I did not use Alamofire for networking since only two API calls are needed in the project, and URL Request is sufficient for it.

### Design Patterns
MVVM, Singleton, and Delegation are used as design patterns. A view model was created for each view controller.

ViewModel delegate methods are used to manage user interface and send data to views.

### Extensions

Created some extension methods for UIImage, UIColor, Date, Double, UIView, UIViewController. Some are explained below:

- UIImage: `blend` method is used to blend upcoming images with background.
- Date: `datePhraseRelativeToToday` method is used to calculate remaining date of upcoming launches in a format of months, weeks or days.
- UIViewController: `getFaceIDAuthorization` method is used to authorize the user by fingerprint.
- UIView: `addTopBorder` and `addBottomBorder` methods are used to make borders to views in rocket detail page.

### Implementation Details
#### User Interface
- Since the tab bar in the project has a custom design, I preferred using custom view instead of usual Tab bar Controller. I have created a Navigation Controller, and whenever 
user taps an item on this custom view, I have changed the root view controller of Navigation Controller.
  
- Images that come from API calls are not quite effective to use in rocket listing page. Therefore, rockets tab view may look different from the design in Zeplin.
- Since some upcoming launches do not have images to display, you can see blank cells with only names and explore button on them for upcoming page.

#### Coding
- Includes four App tracking event:
    
    - `favorite_tab_pressed`
    - `rocket_detail_displayed` with a parameter `rocket_name`
    - `explore_button_pressed`
    - `upcoming_detail_displayed` with a parameter `upcoming_launch_name`

- Whenever App goes background and comes foreground again, the API call method for fetching all rocket information is called, which refreshs data on persistent storage if there is any new rocket info. Upcoming launches are also fetched again from SPaceX server when scene will enter foreground. Instead of loading all rocket and upcoming data from server during each display, it is more reasonable and effective to fetch the data at the first launch and whenever screen comes foreground.








