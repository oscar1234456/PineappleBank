[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)  <img src="https://i.imgur.com/WWbFmFv.png" width="100"/><img src="https://firebase.google.com/downloads/brand-guidelines/PNG/logo-built_white.png" width="100"/> <img src="https://1000logos.net/wp-content/uploads/2020/05/Google-Maps-Logo.png" width="100"/>

# Pineapple Bank 🍍 (Version 2.0)
An Social Application based on sharing leftover with others. Users can publish or holding leftover party through this applicaion, also those in need can use this appliaction to pick up the leftovers.
- About our Proposal(Q&A): [Pineapple Bank-GDSC Solution Challenge 2021-Proposal](https://docs.google.com/document/d/1-C3E04k0mC3o9D-nkA4bpTNSz1sekuXN-A0bgjJ11Sg/edit?usp=sharing)

## Demo Video (Version 2)
Please Click [Here](https://youtu.be/DCc4LIiA8gw)

## Before You Started ❗
1. Please Create **Your Own Firebase Project**, and **download the google-service.json file** put them in **PineappleBank\android\app\google-services.json**
2. Get the API key of **Geocoding API** and **Maps SDK for Android** on Google Cloud Platform
3. Enable Firebase Project to Blaze.(Need Payment Account)


## Requirements 🍽
```
Our project is Flutter 2.2.0 project
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
firebase_messaging: ^6.0.16
animations: ^2.0.0
geocoding: ^1.0.5
flutter_local_notifications: ^1.4.0
fluttertoast: ^8.0.7
firebase_ml_vision: ^0.12.0+2
firebase_ml_custom: ^0.2.0+1
tflite: ^1.1.1
path_provider: ^1.6.28

```
## Google Technologies we use
- Flutter 2 (2.2.1)
- Google Maps Platform
    - Maps SDK for Android
    - Geocoding API
- Google Firebase
    - Storage
    - Authentication
    - Firestore
    - Cloud Messaging
    - Cloud Functions
    - Firebase Machine Learning (Custom)
- AutoML
- Tensorflow Lite

## Features 🍕
- [x] Publish Leftover Posts
- [x] Holding a Leftover Events
- [x] Personal Leftover Tracer
- [x] Supply Leftover's Map
- [x] Chatting with Leftover provider
- [x] Food Recognition using ML
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

## Firebase Firestore JSON Tree
```
--user
	-- user_id
		-- display_name
		-- chatting_with
		-- email
		-- photo
		-- provider
		-- pushToken
		-- publish_posts
        -- save_posts
		-- user_id

--post
	--post_id
        -- belonging_people_user_id
        -- picking_position
        -- city
		-- district
		-- publish
		-- already_pick

--food
	--food_id
		-- best_before_time
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
        -- event type

--message
    --message_id
        --receive_user_id
            --message
```

## Architecture 🗂
- Models
    - Define the Data Model that can store fetch data from Firestore.
        1. event (Leftover event party)
        2. food (Store food in database)
        3. foodPost
        4. place
        5. post (Store post data binding with food)
        6. user (Store user data in our project)
- Screen/Home
    - Store the dart file that design for the interface after the user has passed the authentication which includes search article/event page, publish your leftover page, personal profile page, etc.
        1. foodFindEventPage(All event posts)
        2. foodFindFoodPage(All food posts)
        3. foodFocusPage(Expiring leftovers and event)
        4. foodPineapplePage(Preset articles and post class)
        5. home(call mainPage)
        6. placePage(the Map Page)
        7. placeSelect(Map selector)
        8. PostEditPage(Add new food post/all user)
        9. PostEditPage_Event(Add new event post(volunter only))
        10. ProfilePage(User information, badges, Event, Setting .etc)
        11. Profile_TabPage(Food Trace page, Event Page)
- Screen/Authenticate
    - Store the dart file that design for the interface before the user pass the authentication.
        1. authenticate (switch between register page and sign_in page)
        3. register (register new account in our app)
        4. sign_in (login our app by your account)
- Screen/chatRoom
    - The chat room system.
        1. chatProviderPick
        2. chatProvider
        3. chatReceiver
        4. chatRoom
        5. chatWindow
- Services
    - Design the authenticate method including Email/Password Registration/Sign-in, Social auth, Create FirebaseUser method, etc.
        1. auth
        2. dataprocess(tidy up data process function in this file)
- Util
    - Store some utility method that can be implemented in other file or class including loading screen, upload/fetch data from Firestore method, alertdialog widget, etc., also in Util files we define some constant in order to modify our hinttext, background color and screen size more convinent.
        1. cardSlider
        2. constants
        3. customIcon
        4. findEventCardList
        5. findFoodCardList
        6. loading (generate loading screen in our app)
        7. loadingIndicator
        8. mapLoadingDialog
        9. presetItem(Preset Saved Page and Preset Marked Page)
        10.styleDesign
        11.styleDesignImg

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
* [Building chat app with Flutter and Firebase](https://medium.com/flutter-community/building-a-chat-app-with-flutter-and-firebase-from-scratch-9eaa7f41782e)
* [Train and deploy on-device image classification model with AutoML Vision in ML Kit](https://codelabs.developers.google.com/codelabs/automl-vision-edge-in-mlkit#0)
* [On-Device Machine Learning: Train And Run TensorFlow Lite Models In Your Flutter Apps](https://medium.com/google-cloud/on-device-machine-learning-train-and-run-tensorflow-lite-models-in-your-flutter-apps-15ea796e5ad4)
* [Our Week Report 5/2](https://docs.google.com/presentation/d/1B_IkPqM0V4rDdA7r3wdNEt8WhR8VdM-hBwyOITrn6HM/edit?usp=sharing)
* [Our Week Report 6/4](https://docs.google.com/presentation/d/1zZ-U0glhuxLmawDho-Qjzqcy65I_pgzI_Eul4z8fH_w/edit?usp=sharing)

## Authors
- Oscar Chen(陳泰元)[TW], s110616038@stu.ntue.edu.tw
- Jessie Hsieh(謝妤婕)[TW], jessie60125@gmail.com
- Sean Chang(張子賢)[TW], chungsean74@gmail.com
- Alec Chen(陳碾曆)[HK], alecchan1995@gmail.com

## LICENSE
Under [APACHE2.0](https://opensource.org/licenses/Apache-2.0) LICENCE

## Get Stuck?
Welcome to send us Email!

###### tags: `Flutter2` `Firebase` `Solution Challenge` `Leftover sharing Platform`