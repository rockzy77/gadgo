import 'package:demo_eco/presentation/authentication_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatelessWidget {
  final Widget scaffold;
  final AdvancedDrawerController advancedDrawerController;
  CommonAppBar({ required this.scaffold , required this.advancedDrawerController});
  @override
  Widget build(BuildContext context) {
  
    return AdvancedDrawer(
      backdropColor: Color.fromARGB(255, 0, 0, 0),
      controller: advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: scaffold,
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Container(
                //   width: 128.0,
                //   height: 128.0,
                //   margin: const EdgeInsets.only(
                //     top: 24.0,
                //     bottom: 64.0,
                //   ),
                //   clipBehavior: Clip.antiAlias,
                //   decoration: BoxDecoration(
                //     color: Colors.black26,
                //     shape: BoxShape.circle,
                //   ),
                //   child: Image.asset(
                //     'assets/images/flutter_logo.png',
                //   ),
                // ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Profile'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.favorite),
                  title: Text('Favourites'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                  },
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                 ListTile(
                  onTap: () async{
                    final _auth = FirebaseAuth.instance;
                    try{
                      await _auth.signOut();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                    }
                    catch(e){

                    }
                  },
                  leading: Icon(Icons.logout),
                  title: Text('Log Out'),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  }
