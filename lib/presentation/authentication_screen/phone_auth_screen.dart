import 'dart:async';

import 'package:demo_eco/presentation/authentication_screen/refactored_widgets/otp_input.dart';
import 'package:demo_eco/presentation/home_page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({ Key? key }) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {

   final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  bool otpload = false;
  bool numberload = true;
  String countryCode = '';
  String verificationId = '';

  int _counter = 60;
  late Timer _timer;
  void _startTimer() {
    _counter = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer.cancel();
      }
    });
  }


  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 8, 8, 8),
              Color.fromARGB(255, 24, 24, 24)
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text('Add your phone number to make orders', style: GoogleFonts.poppins(color:Colors.white,fontSize: 26, fontWeight: FontWeight.w400),),
            ),
          Visibility(
            visible: numberload,
            child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: _formKey,
                    child: IntlPhoneField(
                      validator: (value){
                        if(value!.number.length != 10){
                          return 'Invalid Number';
                        }
                      },
                      initialCountryCode: 'IN',
                      dropdownIcon: Icon(Icons.arrow_drop_down, color: Colors.white,),
                      dropdownTextStyle: GoogleFonts.poppins(color:Colors.white, fontWeight: FontWeight.w400),
                      controller: phoneController,
                      disableLengthCheck: true,
                      autovalidateMode: AutovalidateMode.always,
                      onCountryChanged: (value){
                        setState(() {
                          countryCode = value.dialCode;
                        });
                      },
                      style: GoogleFonts.poppins(color:Colors.white, fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: GoogleFonts.poppins(color:Colors.white, fontWeight: FontWeight.w400),
                        filled: true,
                        fillColor: Color.fromARGB(87, 26, 26, 26),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color.fromARGB(255, 112, 112, 112), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color.fromARGB(255, 112, 112, 112)),
                        ),
                      ),
                    ),
                  ),
                ),
          ),
           Visibility(
             visible: otpload,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                  OtpInput(_fieldOne, true),
              OtpInput(_fieldTwo, false),
              OtpInput(_fieldThree, false),
              OtpInput(_fieldFour, false),
              OtpInput(_fieldFive, false),
              OtpInput(_fieldSix, false),
               ],
             ),
           ),
           SizedBox(
             height: 10,
           ),
           Visibility(
             visible: numberload,
             child: Center(
                     child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width / 1.7,
              height: 60,
              shape: const StadiumBorder(),
              color: Colors.white,
              onPressed: (){
                if(_formKey.currentState!.validate()){
                 verifyPhoneNumber();
                }
              },
              child:  Text('Get OTP', style: GoogleFonts.poppins(color: Colors.black,fontSize: 15, fontWeight: FontWeight.w500),)
                     ),
                   ),
           ),
           Visibility(
             visible: otpload,
             child: Center(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width / 4,
              height: 60,
              shape: const StadiumBorder(),
              color: Colors.white,
              onPressed: (){
                setState(() {
                  _timer.cancel();
                  otpload = false;
                  numberload = true;
                });
              },
              child:  Text('Edit Number', style: GoogleFonts.poppins(color: Colors.black,fontSize: 15, fontWeight: FontWeight.w500),)
                           ),
                         ),

                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width / 4,
              height: 60,
              shape: const StadiumBorder(),
              color: Colors.white,
              onPressed: (){
                verifyCode();
              },
              child:  Text('Verify', style: GoogleFonts.poppins(color: Colors.black,fontSize: 15, fontWeight: FontWeight.w500),)
                           ),
                         ),
                       ],
                     ),
                   ),
           ),
           SizedBox(
             height: 10,
           ),

           Visibility(visible: otpload,child: Center(child: Text('OTP expires in ${_counter.toString()} seconds', style: GoogleFonts.poppins(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w500),))),
           _counter == 0 ? Visibility(
             visible: otpload,
             child: Center(child: TextButton(onPressed: (){
               setState(() {
                 _startTimer();
               });
             }, child: Text('resend OTP', style: GoogleFonts.poppins(color: Colors.blue,fontSize: 15, fontWeight: FontWeight.w500),))),
           ): Text(''),
          ]
      ),
      ),
    );
  }

  void verifyPhoneNumber() async{
    String phoneNumber = '+$countryCode${phoneController.text}';
    print(phoneNumber);
    _auth.verifyPhoneNumber(phoneNumber: phoneNumber, 
    verificationCompleted: (PhoneAuthCredential credential)async{
    },
     verificationFailed: (FirebaseAuthException exception){
       print(exception.message);
     },
      codeSent: (String verificationID, int? resendToken){
        setState(() {
          verificationId = verificationID;
          otpload = true;
          numberload = false;
          _startTimer();
        });
      },
       codeAutoRetrievalTimeout: (String verificationId){
         print('timedout');
       });
  }

  void verifyCode() async{
    String otp = _fieldOne.text + _fieldTwo.text + _fieldThree.text + _fieldFour.text + _fieldFive.text + _fieldSix.text;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);

    await firebaseUser!.linkWithCredential(credential).then((user){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeConnect()), (route) => false);
    }).catchError((e){
      print(e);
    });
  }
}