import 'package:demo_eco/presentation/authentication_screen/phone_auth_screen.dart';
import 'package:demo_eco/presentation/home_page/home_page.dart';
import 'package:demo_eco/provider/authentication/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({ Key? key }) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  void singUp(BuildContext context) async{
    if(!loading){
      if(_formKey.currentState!.validate()){
        setState(() {
          loading = true;
        });
       List result = await FirebaseAuthRepository().signUp(emailController.text, passController.text);
    if(result.contains(true)){
      if(result[1] != null){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PhoneAuthScreen()), (route) => false);
      }
    }
    else{
      setState(() {
        loading = false;
      });
    }
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:SizedBox(
    height: 120,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('New here?', style: GoogleFonts.poppins(color: Color.fromARGB(255, 173, 173, 173),fontSize: 15, fontWeight: FontWeight.w600),),
            TextButton(onPressed: (){
              Navigator.pop(context);
            },
             child:  Text('SignIn', style: GoogleFonts.poppins(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w600),),)
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width / 1.7,
            height: 60,
            shape: const StadiumBorder(),
            color: Colors.white,
            onPressed: (){
              singUp(context);
            },
            child: loading? CircularProgressIndicator(
              color: Colors.black,
            ) : Text('SignUp', style: GoogleFonts.poppins(color: Colors.black,fontSize: 15, fontWeight: FontWeight.w500),)
          ),
        ),
      ],
    ),
  ),
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

        child: Form(
          key:  _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/17,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Join Us \nNow.', style: GoogleFonts.poppins(color:Colors.white, fontSize: 45 , fontWeight: FontWeight.w600),),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Create an account to access our products', style: GoogleFonts.poppins(color:Colors.white, fontSize: 23 , fontWeight: FontWeight.w400),),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  controller: nameController,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Name cannot be empty';
                    }
                  },
                  style: GoogleFonts.poppins(color:Colors.white, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    hintText: 'Full Name',
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
        
               Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  controller: emailController,
                   validator: (value){
                     final bool isValid = EmailValidator.validate(value.toString());
                    if(value!.isEmpty){
                      return 'Email cannot be empty';
                    }
                    else if(!isValid){
                        return 'Invalid Email';
                    }
                  },
                  style: GoogleFonts.poppins(color:Colors.white, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    hintText: 'Email',
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
               Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  controller: passController,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Password cannot be empty';
                    }
                    else if(value.length < 8){
                      return 'Password must be more than 8 character';
                    }
                  },
                  style: GoogleFonts.poppins(color:Colors.white, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    hintText: 'Password',
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
        
              InkWell(
                onTap: (){},
                child: Container(
                  padding:  EdgeInsets.all(15),
                  margin:  EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('Assets/images/google.png'),
                        height: 30,
                        width: 30,
                      ),
              
                      SizedBox(width: 10,),
              
                      Text('SignUp Using Google Account', style: GoogleFonts.poppins(color:Colors.black, fontWeight: FontWeight.w500),)
              
                    ],
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