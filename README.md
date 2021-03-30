[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
# Pineapple Bank 🍍
An Social Application based on sharing leftover with others. Users can publish or holding leftover party through this applicaion, also those in need can use this appliaction to pick up the leftovers.

## Before You Started ❗
1. Please Create **Your Own Firebase Project**, and **download the google-service.json file** put them in **solution_challenge_joas\android\app\google-services.json**
2. Get the API key of **Geocoding API** and **Maps SDK for Android** on Google Cloud Platform



## Requirements 🍽
```
Our project is Flutter 2.0.0 project
dart: >=2.12.0-259.9.beta <3.0.0
flutter: >=1.22.0
Android studio 4.0.1
sign_button: ^1.0.2
cupertino_icons: ^1.0.0
provider: ^5.0.0
firebase_core: "^0.7.0"
firebase_auth: "^0.20.0+1"
cloud_firestore: "^0.16.0"
firebase_storage: "^7.0.0"
flutter_spinkit: "^4.0.0"
carousel_slider: ^3.0.0
google_sign_in: "^4.5.1"
chips_choice: ^2.0.1
image_picker: ^0.6.7+22
image_cropper: ^1.3.1
http: ^0.12.0+3
google_maps_flutter: ^0.5.32
search_map_place: ^0.3.0
geolocator: ^6.2.1
flutter_facebook_login: ^3.0.0
animations: ^2.0.0
geocoding: ^1.0.5

```
## Google Technologies we use
- Flutter 2
- Google Maps Platform
    - Maps SDK for Android
    - Geocoding API
- Google Firebase
    - Storage
    - Authentication
    - Firestore

## Features 🍕
- [x] Publish Leftover Posts
- [x] Holding a Leftover Events
- [x] Personal Leftover Tracer
- [x] Supply Leftover's Map
- [x] Save Your Favorite Leftover Post

## Screenshots 📷
|Sign in Page|Focus Page|Map|Profile Page|
|:----------:|:--------:|:-:|:----------:|
|![](https://i.imgur.com/UCPK1jB.jpg)|![](https://i.imgur.com/mYFAhyZ.jpg)|![](https://i.imgur.com/ItVA5QO.jpg)|![](https://i.imgur.com/ueyFfOP.jpg)|
|**Find Food**|**Food Post**|**Post Edit**|**Food Trace**|
|![](https://i.imgur.com/pfOk6JU.jpg)|![](https://i.imgur.com/9bpwggz.jpg)|![](https://i.imgur.com/1okxOkK.jpg)|![](https://i.imgur.com/RrQaIAF.jpg)|


## System Architecture Diagram 📈
* User interaction process
![](https://i.imgur.com/c5SrVCs.png)
* Operating Process
![](https://i.imgur.com/QhY6Y1v.png)

## Project JSON Tree
```
--user
	-- user_id
		-- display_name
		-- sex
		-- job
		-- birthday{timestamp}
		-- age
		-- self_introduction
		-- address
		-- contribution
		-- publish_posts
		-- holding_events

--post
	--post_id
                -- belonging_people_user_id
                -- picking_position
		-- publish
		-- already_pick
		-- food_id

--food
	--food_id
		-- best_before_time
		-- city
		-- district
		-- food_type
		-- name
		-- introduction
		-- photo
		
--event
	--event_id
		-- city
		-- district
		-- holding_people_user_id
		-- name
		-- introduction
		-- event_type
		-- holding_date
		-- end_date
		-- picking_position
```

## Architecture 🗂
- Models
    - Define the Data Model that can store fetch data from Firestore. 
        1. event (Leftover event party)
        2. food (Store food in database)
        3. foodPost
        4. message (still developing)
        5. place
        6. post (Store post data binding with food)
        7. user (Store user data in our project)
- Screen/Home
    - Store the dart file that design for the interface after the user has passed the authentication which includes search article/event page, publish your leftover page, personal profile page, etc.
        1. container_transition(Animation effect)
        2. foodFindEventPage(All event posts)
        3. foodFindFoodPage(All food posts)
        4. foodFocusPage(Expiring leftovers and event)
        5. foodPineapplePage(Preset articles and post class)
        6. home(call mainPage)
        7. mainPage(Add post or taggle tab)
        8. placePage(the Map Page)
        9. placeSelect(Map selector)
        10. PostEditPage(Add new food post/all user)
        11. PostEditPage_Event(Add new event post(volunter only))
        12. presetItem(Preset Saved Page and Preset Marked Page)
        13. ProfilePage(User information, badges, Food Trace, Event, Setting .etc)
- Screen/Authenticate
    - Store the dart file that design for the interface before the user pass the authentication.
        1. authenticate (switch between register page and sign_in page)
        3. register (register new account in our app)
        4. sign_in (login our app by your account)
- Services
    - Design the authenticate method including Email/Password Registration/Sign-in, Social auth, Create FirebaseUser method, etc.
        1. auth
        2. database
- Util
    - Store some utility method that can be implemented in other file or class including loading screen, upload/fetch data from Firestore method, alertdialog widget, etc., also in Util files we define some constant in order to modify our hinttext, background color and screen size more convinent.
        1. cardSlider
        2. constants
        3. customIcon
        4. dataprocess (tidy up data process function in this file)
        5. findEventCardList
        6. findFoodCardList
        7. loading (generate loading screen in our app)
        8. loadingIndicator
        9. mapLoadingDialog

## Reference Sources
* [Firebase Authentication](https://firebase.flutter.dev/docs/auth/usage)
* [Cloud Firestore](https://firebase.flutter.dev/docs/firestore/usage)
* [Cloud Storage](https://firebase.flutter.dev/docs/storage/usage)
* [Material Design](https://material.io)
* [MDC-101 Flutter: Material Components (MDC) Basics (Flutter)](https://codelabs.developers.google.com/codelabs/mdc-101-flutter#0)
* [MDC 102 Flutter: Material Structure and Layout](https://codelabs.developers.google.com/codelabs/mdc-102-flutter)
* [MDC 103 Flutter: Material Theming with Color, Shape, Elevation, and Type](https://codelabs.developers.google.com/codelabs/mdc-103-flutter)
* [MDC 104 Flutter: Material Advanced Components](https://codelabs.developers.google.com/codelabs/mdc-104-flutter)
* [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter)
* [Add Custom Marker Images to your Google Maps in Flutter](https://pub.dev/packages/google_maps_flutter)

###### tags: `Flutter2` `Firebase` `Solution Challenge` `Leftover sharing Platform`


