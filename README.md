# Firebase 認證功能介紹
* **程式架構圖**
![](https://i.imgur.com/QhY6Y1v.png)
* 檔案說明
    - models:管理已寫好的資料種類及存取方式
        - User.dart : 定義使用者的資料存取方式
    - screens:管理畫面類(UI)的程式
        - authenticate
            - authenticate.dart : 管理註冊與登入服務
            - register.dart :註冊服務，成功後會導到home.dart
            - sign_in.dart : 登入服務，成功後會導到home.dart
        - home 
            - home.dart : 通過認證服務後會看到的畫面
        - wrapper.dart : 根據使用者是否通過認證，而決定給予登入/註冊畫面或是主畫面
    - services:管理串接服務類的程式
        - auth.dart : 管理所有的認證方法，目前有加入基本的電子郵件/密碼方法
    - util : 管理工具類程式，大家可以共用的
        - loading.dart : 控制按下送出鍵的暫存畫面
        - constants.dart : 目前僅定義文字輸入框的格式
* 已安裝擴充套件
    - [firebase_auth : ^0.14.0+5](https://pub.dev/packages/firebase_auth)
    - [cloud_firestore : ^0.12.9+4](https://pub.dev/packages/cloud_firestore)
    - [provider : ^3.1.0](https://pub.dev/packages/provider)
    - [flutter_spinkit :　^4.0.0](https://pub.dev/packages/flutter_spinkit)
* 參考文章/程式碼
    - [Firebase Document](https://firebase.google.com/docs/auth/android/firebaseui)
    - [Firebase Quickstart for Android](https://github.com/firebase/quickstart-android)
    - [Firebase UI sample code](https://github.com/firebase/snippets-android/blob/bc39834be99275cd248a8577870c832692673b2b/auth/app/src/main/java/com/google/firebase/quickstart/auth/kotlin/FirebaseUIActivity.kt#L21-L35)
    - [Flutter & Firebase App Build Tutorial](https://youtube.com/playlist?list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC)
