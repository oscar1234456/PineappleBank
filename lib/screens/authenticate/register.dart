import 'package:flutter/material.dart';
import 'package:food_bank_auth/services/auth.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'package:food_bank_auth/util/loading.dart';

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

    final BacktoSignIn = FlatButton.icon(
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
          image: AssetImage('images/ic_launcher_smile.png')
      ),
    );

    final EmailInput = TextFormField(
      keyboardType: TextInputType.multiline,
      validator: (val) => val.isEmpty ? pinEmailHintText : null,
      onChanged: (val) {
        setState(() => email = val);
      },
      style: TextStyle(
        color: InputColor,
      ),
      cursorColor: InputColor,
      decoration: InputDecoration(
        labelText: pinEmailText,
        hintText: pinEmailHintText,
        labelStyle: TextStyle(
            color: FocusNode().hasFocus ? InputCursorColor : InputColor,
        ),
        filled: true,
        fillColor: TextFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BlockBorderRadius),
        ),
        focusedBorder:OutlineInputBorder(
          borderSide: BorderSide(
            color: InputColor,
            width: TextFocusedLine,
          ),
          borderRadius: BorderRadius.circular(BlockBorderRadius),
        ),
      ),
    );

    final PasswordInput = TextFormField(
      keyboardType: TextInputType.multiline,
      obscureText: true,
      validator: (val) => val.length < 6 ? PasswordErrorText : null,
      onChanged: (val) {
        setState(() => password = val);
      },
      style: TextStyle(
        color: InputColor,
      ),
      cursorColor: InputColor,
      decoration: InputDecoration(
        labelText: pinCodeText,
        hintText: pinCodeHintText,
        labelStyle: TextStyle(
            color: FocusNode().hasFocus ? InputCursorColor : InputColor,
        ),
        filled: true,
        fillColor: TextFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BlockBorderRadius),
        ),
        focusedBorder:OutlineInputBorder(
          borderSide: BorderSide(
            color: InputColor,
            width: TextFocusedLine,
          ),
          borderRadius: BorderRadius.circular(BlockBorderRadius),
        ),
      ),
    );
    final PasswordCheck = TextFormField(
      keyboardType: TextInputType.multiline,
      obscureText: true,
      validator: (val) => password2!=password ? ConfirmPasswordErrorText : null,
      onChanged: (val) {
        setState(() => password2 = val);
      },
      style: TextStyle(
        color: InputColor,
      ),
      cursorColor: InputColor,
      decoration: InputDecoration(
        labelText: pinCode2Text,
        hintText: pinCodeHint2Text,
        labelStyle: TextStyle(
          color: FocusNode().hasFocus ? InputCursorColor : InputColor,
        ),
        filled: true,
        fillColor: TextFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BlockBorderRadius),
        ),
        focusedBorder:OutlineInputBorder(
          borderSide: BorderSide(
            color: InputColor,
            width: TextFocusedLine,
          ),
          borderRadius: BorderRadius.circular(BlockBorderRadius),
        ),
      ),
    );

    final SindUpBtn = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      color: InputColor,
      child: Text(
        SignUpText,
        style: TextStyle(color: Colors.white),
      ),
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
    );

    final ErrorText = Text(
      error,
      style: TextStyle(color: Colors.red, fontSize: 14.0),
    );

    return   loading ? Loading() : Scaffold(
      backgroundColor: SignInBGcolor,
      appBar: AppBar(
        backgroundColor: SignInBarColor,
          elevation: 0.0,
          title: Text(AppNameText,
            style: TextStyle(
              color: PineBarColor,
            ),
          ),
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
      // Doing this ensures that the keyboard's appearance does not
      // alter the size of the home page or its widgets.
      resizeToAvoidBottomInset: false,
    );
  }
}
