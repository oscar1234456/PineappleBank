import 'package:flutter/material.dart';
import 'package:food_bank_auth/util/styleDesign.dart';
import 'package:food_bank_auth/util/styleDesignImg.dart';
import 'package:sign_button/sign_button.dart';
import 'package:food_bank_auth/services/auth.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'package:food_bank_auth/util/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}
class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final text_pinEmail = TextEditingController();
  final text_pinCode = TextEditingController();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {

    final paddingNum = MediaQuery.of(context).size.width/12;

    final GotoSignUp = TextButton.icon(
      icon: Icon(
        Icons.person,
        color: Colors.white70,
      ),
      label: Text(
        SignUpText,
        style: TextStyle(
          color: Colors.white70,
        ),
      ),
      onPressed: (){
        widget.toggleView();
      },
    );
    final LogoRadius = MediaQuery.of(context).size.width/3;
    final AppLogo = Container(
      width: LogoRadius,
      height: LogoRadius,
      child: Image(
        image: AssetImage(AppIconImgPath[0]),
      ),
    );
    final EmailInput = TextFormField(
      keyboardType: TextInputType.multiline,
      controller: text_pinEmail,
      validator: (val) => val.isEmpty ? pinEmailHintText : null,
      onChanged: (val) {
        setState(() => email = val);
      },
      style: InputBlockDesign[0],
      cursorColor: InputColor,
      decoration: EmailInputDesign,
    );
    final PasswordInput = TextFormField(
      keyboardType: TextInputType.multiline,
      controller: text_pinCode,
      obscureText: true,
      validator: (val) => val.length < 6 ? PasswordErrorText : null,
      onChanged: (val) {
        setState(() => password = val);
      },
      style: InputBlockDesign[0],
      cursorColor: InputColor,
      decoration: PasswordInputDesign,
    );
    final SignInBtn = ElevatedButton(
      onPressed: () async{
        if(_formKey.currentState.validate()){
          setState(() => loading = true);
          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
          if(result == null){
            setState(() {
              error = AccountErrorText;
              loading = false;
              // showMyDialog(error);
            });
          }
        }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          )
        ),
        backgroundColor: MaterialStateProperty.all<Color>(InputColor),
      ),
      child: Text(
        SignInText,
        style: TextStyle(color: Colors.white),
      ),

    );

    final ShowErrorText = Text(
      error,
      style: TextStyle(
          color: Colors.red,
          fontSize: NormalWordsSize),
    );

    final dividerLine = SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      height: 3,
      child: divLineDesign,
    );

    final TODOhint = AlertDialog(
      title: Text(
        TODOAlert_title,
        style: DiaTitleStyle,
      ),
      content: Text(
        TODOAlertText,
        style: DiaConStyle,
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text(
            OKoptionText,
            style: DiaOptStyle,
          ),
        ),
      ],
    );

    final GithubSignIn = SignInButton.mini(
      buttonType: ButtonType.github,
      onPressed: () {
        showDialog<void>(context: context, builder: (context) => TODOhint);
      },
    );
    final FBSignIn = SignInButton.mini(
      buttonType: ButtonType.facebook,
      btnColor: Colors.white,
      onPressed: () async{
        // showDialog<void>(context: context, builder: (context) => TODOhint);
        setState(() => loading = true);
        dynamic result = await _auth.signInWithFacebook();
        if(result == null){
          setState(() {
            error = AccountErrorText;
            loading = false;
          });
        }
      },
    );
    final GoogleSignIn = SignInButton.mini(
      buttonType: ButtonType.google,
      onPressed: () async{
        setState(() => loading = true);
        dynamic result = await _auth.signInWithGoogle();
        if(result == null){
          setState(() {
            error = AccountErrorText;
            loading = false;
          });
        }
      },
    );
    final OtherSignIn = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GoogleSignIn,
        FBSignIn,
        GithubSignIn,
      ],
    );

    return loading ? Loading() : Scaffold(
      backgroundColor: SignInBGcolor,
      appBar: AppBar(
        backgroundColor: SignInBarColor,
        elevation: 0.0,
        title: AppBarAppName,
        actions: <Widget>[
          GotoSignUp,
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
            vertical: paddingNum,
            horizontal: paddingNum,
          ),
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: Height_Size),
                  AppLogo,
                  SizedBox(height: Height_Size*2),
                  EmailInput,
                  SizedBox(height: Height_Size),
                  PasswordInput,
                  SizedBox(height: Height_Size),
                  SignInBtn,
                  SizedBox(height: Height_Size),
                  ShowErrorText,
                  SizedBox(height: Height_Size),
                  dividerLine,
                  SizedBox(height: Height_Size),
                  SizedBox(height: Height_Size),
                  OtherSignIn,
                ],
              ),
            ),
          ],
        ),
      ),
      // Doing this ensures that the keyboard's appearance does not
      // alter the size of the home page or its widgets.
      resizeToAvoidBottomInset: false,
    );
  }
}
