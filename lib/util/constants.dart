import 'package:flutter/material.dart';
import 'package:food_bank_auth/util/styleDesign.dart';

//不是我寫的窩不敢刪
const textInputDecoration = InputDecoration(
    border: OutlineInputBorder(),
    fillColor: Colors.white70, filled: true,
);


//常用全域變數
//Words
const NormalWordsSize = 16.0;
const TitleWordsSize = 20.0;
//SizeBox
const Width_Size_S = 10.0;
const Height_Size_L = 20.0;
//IconSize
const ABIconSize = 35.0;

//list of Post tags
const List<String> tagsList = [
    "pineapple","sour","sweet","bitter","spicy","salty",
    "seafood","fruit","vegetable","seasonings","beverage","dessert",
    "daytime","afternoon","night","midnight","liqueur","wine",
];


// LoginPage_Sizes
const LoginIconRadius = 100.0;
const LoginIconRadius_BIG = 200.0;
const Height_Size = 20.0;
//PostEditPage_Size
const BlockBorderRadius = 25.0; //框框圓角
const TextFocusedLine = 2.0; //框框加粗
const RaisedButtonborderRadius = 10.0; //按鈕、show圓角
const TitleMaxLength = 50;
const ArticleMaxLength = 500;
const ArticleMaxLines = 15;
const SettingButton_Height = 45.0;
const ShowWords_Height = 45.0;
//
//ArticlePage
//
const SaveBtn = "Save the precious FOOD !";
const SaveCheck_t = "Confirm to Save";
const SaveCheck_c = "push 'Save' to save the food or 'Cancel'.";
const Save_X = "Cancel";
const Save_O = "SAVE!";
const SucceedText = "You are successful to save the food!\nPlease get the food on time.";
const YourOwnFoodText = [
    "Something Wrong",
    "You can't save your own food, try \"finish\" your food at \"My Food Trace\" Page. ",
];
const ABText_Event = "Event!!";
const AtdBtn = "Participate!";
const attendEventORnot = [
    "Cancel Participation!",
    "Participate!",
];
const attendEventORcancel = [
    "Alright......ByeBye. Have a nice day.OAO",
    "look forward to your visit (๑・ω-)～♡\nHave a nice day.",
];
//
//PostEditPage_Strings
//PostEditPage_Event_Strings
//
const TitleLabelText = "Title";
const TitleHintText = "Food Name";
const ArticleLabelText = "Article";
const ArticleHelperText = "Brief introduction of your food";
const ExpirationDateText = "Expiry date";
const EventDateText = "Event date";
const LocationText = "Link to Map";
const RealLocationText = "SweetPotatoOuO";
const ConfirmToSendText = " POST ! ! ";
const ConfirmToSendText_t = "Confirm to Post";
const ConfirmToSendText_c = "push 'Yes' to share your food or 'Cancel' to edit";
const EditHelp = "TIPS ! ";
const EditHelp_Tips = "The Title,Article,Photo,Location cannot be empty, and Expiration date should be after NOW at least 30 minutes.";
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
//
//SignInPage
//RegisterPage
//
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
const SignInText = "  Sign in  ";
const SignUpText = "  Sign up  ";
const AccountErrorText = "No such account";
const TODOAlert_title = "TIPS";
const TODOAlertText = "Not yet opened in query, soon will open.";
//
//FoodTrace 共通部件文字
//
const FoodTraceOption = [
    "Post",
    "Finished",
];
const FoodTracePostDiaOption = [
    "No",
    "Yes, I want to post.",
];
const SucceedPostText = [
    "TIPS",
    "Are you sure to post your food?",
    "You are successful to post the food!"
        "\nPlease wait someone to save it."
        "\n\nIf the food is saved by someone, you can get 5 point.",
];
const FoodTraceFinDiaOption = [
    "No",
    "Yes, I have finished it.",
];
const SucceedFinishText = [
    "TIPS",
    "Are you sure your food has been finished?",
    "Great( ･ิ ◡･ิ)!"
        "\nAdvocate festival food culture, and promote the sustainable development.",
];
//
//ProfilePage
//
const BadgeSize = 70.0-20;
const BadgeImgSize = 65.0-20;
//Profile_Strings
//Profile_ExpDescription
const BlockDescription_title = "TIPS";
final BlockDescription_Exp = RichText(
    text: TextSpan(
        style: DiaConStyle,
        children: <TextSpan>[
            TextSpan(text: "Saving food or posting food can let you get point."),
            TextSpan(text: "\n(10 point = 1 Reliability)"),
            TextSpan(text: "\n\nGetting 100 Reliability and then you can become a "),
            TextSpan(text: "Volunteer", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: " !!\n"),
            TextSpan(text: "Volunteer", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: " can collect nearby food and hold event."),
        ],
    ),
);
const ExpTitle = "Reliability";
const BadgeTitle = "Badge";
const BadgeName = [
    "Newbie Pineapple Badge",
    "first sign up : 2021/01/28",
    "PinePinePineapple Badge",
    "first save food : 2021/01/31",
    "Green Pineapple Badge",
    "first post food : 2021/01/31",
    "Partyapple Badge",
    "first hold event : 2021/02/21",
];
//Profile_SettingList
const LogOutText = "Log out";
const DoubleCheck_title = "Treasure grain, saving resources.";
const DoubleCheckText = "Do you clean your plate today?";
const KeepText = "keep logged in";
const OKoptionText = "I see."; //ArticlePage //TabPage
const AboutPine_title = "About Pineapple Bank";
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
const AboutUs_title = "About Us";
const AboutUsText =  "DSCNTUE 2020 & \n"
    "NTUEIRC(Information Research Club)\n"
    "core team members \n\n"
    "We hope everyone can reduce waste food through Pineapple Bank, "
    "not only pineapple.";
const ContactUs_title = "Contact Us";
const ContactUsText = "email : ntueirc.club@gmail.com\n\n"
    "Location : National Taipei University of Education in Taiwan\n\n";