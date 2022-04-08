import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatelessWidget {
  final Function changeCategory;
  const Categories({ required this.changeCategory});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          categoryItem(Icons.earbuds, 'Wearables', _onCategoryClick),
          categoryItem(Icons.smartphone, 'Mobile Phones',_onCategoryClick),
          categoryItem(Icons.tv, 'Tv/Monitor',_onCategoryClick),
          categoryItem(Icons.laptop, 'Lap/Computer',_onCategoryClick),
          categoryItem(Icons.print, 'Appliances',_onCategoryClick),
        ],
      ),
    );
  }

  void _onCategoryClick(String title){
    changeCategory(title);
  }
}

Widget categoryItem(IconData icon, String title, Function onClick){
  return  Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
          child: InkWell(
                onTap: (){
                  onClick(title);
                },
                child: Column(
            children: [
               CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black,
                  child: Icon(icon, color: Colors.white,),
                ),
              
              SizedBox(height: 5),
              Text(title, style: GoogleFonts.poppins(fontSize: 15),),
              
            ],
          ),
          ),
        );            
}