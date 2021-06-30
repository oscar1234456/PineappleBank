import 'package:flutter/material.dart';
import 'package:food_bank_auth/services/auth.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'package:food_bank_auth/util/loading.dart';
import 'package:food_bank_auth/util/styleDesign.dart';
import 'package:food_bank_auth/util/styleDesignImg.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String password2 ='';
  String error = '';

  @override
  Widget build(BuildContext context) {

    final paddingNum = MediaQuery.of(context).size.width/12;

    final BacktoSignIn = TextButton.icon(
      icon: Icon(
        Icons.person,
        color: Colors.white70,
      ),
      label: Text(SignInText,
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
        image: AssetImage(AppIconImgPath[1]),
      ),
    );

    final EmailInput = TextFormField(
      keyboardType: TextInputType.multiline,
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
      obscureText: true,
      validator: (val) => val.length < 6 ? PasswordErrorText : null,
      onChanged: (val) {
        setState(() => password = val);
      },
      style: InputBlockDesign[0],
      cursorColor: InputColor,
      decoration: PasswordInputDesign,
    );
    final PasswordCheck = TextFormField(
      keyboardType: TextInputType.multiline,
      obscureText: true,
      validator: (val) => password2!=password ? ConfirmPasswordErrorText : null,
      onChanged: (val) {
        setState(() => password2 = val);
      },
      style: InputBlockDesign[0],
      cursorColor: InputColor,
      decoration: PassWord2InputDesign,
    );

    final SindUpBtn = ElevatedButton(
      onPressed: () async{
        if(_formKey.currentState.validate()&&password==password2){
          setState(() => loading = true);
          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
          if(result == null){
            setState(() {
              error = EmailErrorText;
              loading = false;
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
        SignUpText,
        style: TextStyle(color: Colors.white),
      ),

    );

    final ErrorText = Text(
      error,
      style: TextStyle(color: Colors.red, fontSize: 14.0),
    );

    return loading ? Loading() : Scaffold(
      backgroundColor: SignInBGcolor,
      appBar: AppBar(
        backgroundColor: SignInBarColor,
          elevation: 0.0,
          title: AppBarAppName,
          actions: <Widget>[
            BacktoSignIn,
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child:ListView(
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
                      PasswordCheck,
                      SizedBox(height: Height_Size),
                      SindUpBtn,
                      SizedBox(height: Height_Size),
                      ErrorText,
                    ],
                  ),
                ),
              ],
          ),
        ),
      resizeToAvoidBottomInset: false,
    );
  }
}
