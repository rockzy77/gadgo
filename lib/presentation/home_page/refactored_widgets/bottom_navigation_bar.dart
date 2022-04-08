import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageNavigator extends StatefulWidget {
  Function changeValue;
  String value;
   HomePageNavigator({ required this.changeValue, required this.value });

  @override
  State<HomePageNavigator> createState() => _HomePageNavigatorState();
}

class _HomePageNavigatorState extends State<HomePageNavigator> {
  String value = 'home';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      height: 65,
      decoration: BoxDecoration(
        color: Color.fromARGB(253, 0, 0, 0),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          navigationItem(Icons.home, changeValue, value == 'home', 'home'),
          navigationItem(Icons.favorite, changeValue, value == 'fav', 'fav'),
          navigationItem(Icons.book, changeValue, value == 'orders', 'orders'),
          navigationItem(Icons.person, changeValue, value == 'user', 'user'),
        ],
      ),
    );
  }

  void changeValue(String val){
    setState(() {
      value = val;
    });
    widget.changeValue(val);
  }
}


Widget navigationItem(IconData icon, Function changeValue, bool active, String value){
  return InkWell(
    onTap: (){
      changeValue(value);
    },
    child: Container(
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(10)
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Icon(icon, color: active ? Colors.black : Colors.white,)
    ),
  );
}