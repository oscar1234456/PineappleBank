import 'package:flutter/material.dart';
import 'package:food_bank_auth/screens/home/ProfilePage.dart';

class FoodColor{
    //TODO: change level2 to level3
    static const Color foodColor_level1 = Color(0xFFff8a80); //most emergency
    static const Color foodColor_level2 = Color(0xFFffe57f);
    static const Color foodColor_level3 = Color(0xFFc5e1a5);
}

//Sign In/Up
Color SignInBGcolor = Color(0xFFffdead);
Color SignInBarColor = Color(0xFFbc8f8f);
Color InputColor = Color(0xFFbc8f8f);//focused游標、文字、邊框、show文字
Color PineBarColor = Colors.white;

//mainPage
Color BGColor = Color(0xFFffdead);//Background
Color ABColor = Colors.orangeAccent[200];//AppBar
Color AddEventBtnColor = Color(0xFFfafad2);
Color AddEventBtnIconColor = Colors.deepOrangeAccent;

//ProfilePage
Color ListTextColor = Color(0xFFcd853f);
Color LogOutColor = Color(0xFF8b4513);
Color SavedBtnIconColor = Color(0xFF804040);
Color BadgeBGcolor = Colors.white24;
Color BadgeBlockBG = Color(0x99EA7500);
Color BadgeBlockLine = Color(0xAAFFFFCC);//ffdc35 BB5E00
Color PointBlockBG = Color(0x99EA7500);
Color PointBlockLine = Color(0xAAFFFFCC);
Color PointVelue = Color(0xFFFFD306);

//PostEditPage
Color TextFill = Colors.white70;//Article
Color IconColor = Colors.black26;//Article、HashTag
Color ShowFill = Colors.white54; //showDate、showLocation
Color InputCursorColor = Colors.brown;//focused游標、文字、邊框、show文字
Color TagBG = Colors.orangeAccent[100];
Color ButtonIconColor = Colors.white; //with ButtonText
Color ButtonBGColor_Photo = Color(0xFFffbb77);
Color ButtonBGColor_Date = Color(0xFFffa042);
Color ButtonBGColor_Location = Color(0xFFff9000);

//foodArticlePage
const Color MarkBtnIconColor_X = Colors.black26;//word、icon
const Color MarkBtnIconColor_O = Colors.orange;
const Color MarkBtnColor_X = Colors.grey;//BtnBG
const Color MarkBtnColor_O = Color(0xFFffd700);
const Color SaveBtnColor  = Colors.amber;
const Color SaveBtnIconColor = Colors.red;
const Color TitleColor = Color(0xFF8b4513);
const Color LocationColor = Color(0xFFcc5000);
const Color ArticleColor = Color(0xFFb87333);

const textInputDecoration = InputDecoration(
    border: OutlineInputBorder(),
    fillColor: Colors.white70, filled: true,
);

//Sign_in_Strings //register_Strings
const AppNameText = "Welcome to Pineapple Bank !";
const pinEmailText = "e-mail";
const pinEmailHintText = "Please enter e-mail address";
const pinCodeText = "password";
const pinCodeHintText = "Please enter password";
const pinCode2Text = "comfirm password";
const pinCodeHint2Text = "Please enter password again";
const EmailErrorText = "Please enter a valid e-mail address";
const PasswordErrorText = "Password must be at least 6 characters long";
const ConfirmPasswordErrorText = "Two different input password, please re-entry" ;
const SignInText = "Sign in";
const SignInG = "Sign in from Google";
const SignUpText = "Sign up";
const AccountErrorText = "No such account";

//mainPage
const NewPost_food = "   Post your food.  ";
const NewPost_event = "Hold an new event.";

//Profile_Strings
const LogOutText = "Log out";
const DoubleCheckText_t = "Treasure grain, saving resources.";
const DoubleCheckText_c = "Do you clean your plate today?";
const KeepText = "keep logged in";
const AboutPineText = "Pineapple Bank is an app "
    "let you can provide your leftovers for those in need.\n\n"
    "In 2021, for some reasons as everyone knows, "
    "there are many unmarketable fruit(especially pineapples) in Taiwan, "
    "which cause many Taiwanese to buy pineapples.\n"
    "If your pineapples are too much to eat, "
    "you can try make them into other meals.\n"
    "If you still can't finish them...\n\n"
    "Pineapple Bank is your best choose!\n\n"
    "Warnning : Please don't offer expired food, dietary supplement, controlled medicine, "
    "and other prescription medicine.";
const AboutUsText = "DSCNTUE 2020 & \n"
    "NTUEIRC(Information Research Club)\n"
    "core team members \n\n"
    "We hope everyone can reduce waste food through Pineapple Bank, "
    "not only pineapple.";
const ContactUsText = "email : ntueirc.club@gmail.com\n\n"
    "Location : National Taipei University of Education in Taiwan\n\n";

//ArticlePage
const ABText = "Save the food!!";
const MarkText = "Mark";
const MarkedText = "Marked";
const SaveBtn = "Save the precious FOOD !";
const SaveCheck_t = "Confirm to Save";
const SaveCheck_c = "push 'Save' to save the food or 'Cancel'.";
const Save_X = "Cancel";
const Save_O = "SAVE!";
const SucceedText = "You are successful to save the food!\nPlease get the food on time.";
const ABText_Event = "Event!!";
const AtdBtn = "Participate!";

//PostEditPage_Strings //PostEditPage_Event_Strings
const TitleLabelText = "Title";
const TitleHintText = "Food Name";
const ArticleLabelText = "Article";
const ArticleHelperText = "Brief introduction of your food";
const ExpirationDateText = "Expiry date";
const LocationText = "Link to Map";
const RealLocationText = "SweetPotatoOuO";
const ConfirmToSendText = " POST ! ! ";
const ConfirmToSendText_t = "Confirm to Post";
const ConfirmToSendText_c = "push 'Yes' to share your food or 'Cancel' to edit";
const EditHelp = "TIPS ! ";
const EditHelp_Tips = "The Article cannot be empty, and Expiration date should be after NOW at least 30 minutes.";
const doubleCheck_X = "Cancel";
const doubleCheck_O = "Yes";
const EditHelpAlertText = "EDIT ";
const CancelAlertText_t = "Cancel to Post";
const CancelAlertText_c = "We will not save your edits.";
const PhotoDeleteText_t = "Delete the Photo";
const PhotoDeleteText_c = "Are you sure to delete the Photo?";
const Event_TitleLabelText = "Event Name";
const Event_TitleHintText = "What's your event about?";
const Event_ArticleLabelText = "Event Agenda";
const Event_ArticleHelperText = "Brief description of your event";
const Event_ExpirationDatehelpText = "Event date";
const Event_TimeStart = "Start Time";
const Event_TimeEnd = "End Time";
const Event_EditHelp_Tips = "The blanks cannot be empty, and the event should be more than 30 minutes.";

//SizeBox
const Width_Size_S = 10.0;
const Height_Size_L = 20.0;

// LoginPage_Sizes
const LoginIconRadius = 100.0;
const LoginIconRadius_BIG = 200.0;
const Height_Size = 20.0;

//PostEditPage_Size
const ABIconSize = 35.0;
const BlockBorderRadius = 25.0; //框框圓角
const TextFocusedLine = 2.0; //框框加粗
const RaisedButtonborderRadius = 10.0; //按鈕、show圓角
const wordsSize_L = 26.0;
const wordsSize_S = 16.0;
const TitleMaxLength = 50;
const ArticleMaxLength = 500;
const ArticleMaxLines = 15;
const SettingButton_Height = 45.0;
const ShowWords_Height = 45.0;

//ProfilePage
const BadgeSize = 70.0-20;
const BadgeImgSize = 65.0-20;