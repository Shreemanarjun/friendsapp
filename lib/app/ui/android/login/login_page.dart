import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:friendsapp/app/controllers/logincontroller.dart';
import 'package:friendsapp/app/ui/android/login/login_consts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqlite_viewer/sqlite_viewer.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginController loginController = Get.find();
  final TextEditingController mobilenumbercontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget _buildMobileTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Mobile',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: mobilenumbercontroller,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            validator:
                ValidationBuilder().maxLength(10).minLength(10).phone().build(),
            style: GoogleFonts.openSans(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14.0),
                prefixIcon: const Icon(
                  Icons.smartphone_outlined,
                  color: Colors.white,
                ),
                hintText: 'Enter your mobile number',
                hintStyle: kHintTextStyle,
                counterStyle: kHintTextStyle),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: passwordcontroller,
            obscureText: true,
            validator: ValidationBuilder().required().build(),
            style: GoogleFonts.openSans(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: Colors.white,
        ),
        onPressed: () {
          loginController.loginUser(
              mobile: int.parse(mobilenumbercontroller.text),
              password: passwordcontroller.text);
        },
        child: Text('LOGIN',
            style: GoogleFonts.openSans(
              color: const Color(0xFF527DAA),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        print('signup clicked');
        Get.toNamed("/signup");
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: 'Don\'t have an account? ',
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                )),
            TextSpan(
                text: 'Sign Up',
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              SizedBox(
                height: double.infinity,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 40.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Sign In',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 30.0),
                        _buildMobileTF(),
                        const SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTF(),
                        _buildLoginBtn(),
                        _buildSignupBtn(),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: ElevatedButton(
                        //       onPressed: () {
                        //         Get.to(() => const DatabaseList());
                        //       },
                        //       child: const Text("DB Viewer")),
                        // )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
