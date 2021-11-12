import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:friendsapp/app/controllers/friendscontroller.dart';
import 'package:friendsapp/app/ui/android/login/login_consts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFriendPage extends StatelessWidget {
  AddFriendPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstnamecontroller = TextEditingController();
  final TextEditingController lastnamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController mobilecontroller = TextEditingController();
  final FriendsController friendsController = Get.find();
  Widget _buildFnameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'First Name',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: firstnamecontroller,
            keyboardType: TextInputType.text,
            validator: ValidationBuilder().required().build(),
            style: GoogleFonts.openSans(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
              hintText: 'Enter your first name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLnameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Last Name',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: lastnamecontroller,
            keyboardType: TextInputType.text,
            validator: ValidationBuilder().required().build(),
            style: GoogleFonts.openSans(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
              hintText: 'Enter your last name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: emailcontroller,
            keyboardType: TextInputType.emailAddress,
            validator: ValidationBuilder().email().build(),
            style: GoogleFonts.openSans(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
              hintText: 'Enter your email address',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

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
            controller: mobilecontroller,
            maxLength: 10,
            keyboardType: TextInputType.phone,
            validator: ValidationBuilder().phone().build(),
            style: GoogleFonts.openSans(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14.0),
                prefixIcon: const Icon(
                  Icons.person_outline,
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

  Widget _buildAddBtn() {
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
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            friendsController.addaFriend(
                fname: firstnamecontroller.text,
                lname: lastnamecontroller.text,
                mobile: mobilecontroller.text,
                email: emailcontroller.text);
          }
        },
        child: Text('Add a friend',
            style: GoogleFonts.openSans(
              color: const Color(0xFF527DAA),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add friend'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 15.0),
              _buildFnameTF(),
              const SizedBox(
                height: 15.0,
              ),
              _buildLnameTF(),
              const SizedBox(
                height: 15.0,
              ),
              _buildMobileTF(),
              const SizedBox(
                height: 15.0,
              ),
              _buildEmailTF(),
              const SizedBox(
                height: 15.0,
              ),
              _buildAddBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
