import 'package:demo_eco/presentation/authentication_screen/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _bottomBar(context),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/12,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Welcome \nBack.', style: GoogleFonts.poppins(color:Colors.white, fontSize: 45 , fontWeight: FontWeight.w600),),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Sign in to access your account', style: GoogleFonts.poppins(color:Colors.white, fontSize: 23 , fontWeight: FontWeight.w400),),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/12,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                style: GoogleFonts.poppins(color:Colors.white, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  hintText: 'Phone, email',
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
              child: TextField(
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
            
                    Text('SignIn Using Google Account', style: GoogleFonts.poppins(color:Colors.black, fontWeight: FontWeight.w500),)
            
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


Widget _bottomBar(BuildContext context){
  return SizedBox(
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
              Navigator.of(context).push(PageTransition(
                type: PageTransitionType.bottomToTop,
                child: RegistrationScreen()
              ));
            },
             child:  Text('SignUp', style: GoogleFonts.poppins(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w600),),)
          ],
          
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: MaterialButton(
            minWidth: 250,
            height: 60,
            shape: const StadiumBorder(),
            color: Colors.white,
            onPressed: (){},
            child:  Text('SignIn', style: GoogleFonts.poppins(color: Colors.black,fontSize: 15, fontWeight: FontWeight.w500),)
          ),
        ),
      ],
    ),
  );
}
