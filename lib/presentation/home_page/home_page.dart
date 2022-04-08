import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_eco/models/product_card_model.dart';
import 'package:demo_eco/presentation/home_page/refactored_widgets/all_products.dart';
import 'package:demo_eco/presentation/home_page/refactored_widgets/bottom_navigation_bar.dart';
import 'package:demo_eco/presentation/home_page/refactored_widgets/categories.dart';
import 'package:demo_eco/presentation/home_page/refactored_widgets/home_app_bar.dart';
import 'package:demo_eco/presentation/home_page/refactored_widgets/home_search_bar.dart';
import 'package:demo_eco/presentation/home_page/refactored_widgets/popular_items.dart';
import 'package:demo_eco/presentation/home_page/refactored_widgets/recommended_items.dart';
import 'package:demo_eco/presentation/wish_list.dart/wish_list_page.dart';
import 'package:demo_eco/provider/fetchData/fetch_all_data.dart';
import 'package:demo_eco/widgets/app_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeConnect extends StatelessWidget {
  HomeConnect({ Key? key }) : super(key: key);
  final advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return  CommonAppBar(
      advancedDrawerController: advancedDrawerController,
      scaffold: HomePage(advancedDrawerController: advancedDrawerController,),
    );
  }
}

class HomePage extends StatefulWidget {
  final AdvancedDrawerController advancedDrawerController;
  // ignore: use_key_in_widget_constructors
  const HomePage( {required this.advancedDrawerController} );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  String category = 'all';
  String page = 'home';
  String searchValue = '';
  void changeCategory(String title){
    setState(() {
      category = title;
    });
  }

  void changePage(String val){
    setState(() {
      page = val;
    });
  }

  void getSearchContent(String value){
    setState(() {
      searchValue = value;
    });
  }

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBody: true,
      bottomNavigationBar: HomePageNavigator(changeValue: changePage, value: page,),
      backgroundColor: Colors.white,
          appBar:HomeAppBar(advancedDrawerController: widget.advancedDrawerController,),
          body: page == 'home' ?  _home() : page == 'fav' ? WishList() : Container()
        );
  }

  Widget _home(){
    return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                   padding: const EdgeInsets.only(left: 15.0, top: 15),
                   child: Text('GADGO', style: GoogleFonts.poppins(color: Colors.black, fontSize: 45),),
                 ),       
          
                 Padding(
                   padding: const EdgeInsets.only(left: 15.0),
                   child: Text('for those who seek the best', style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
                 ),    
          
                 const SizedBox(height: 20,),
          
                 Categories(changeCategory: changeCategory),

                HomeSearchBar(
                   textController: searchController,
                   hintText: 'Search',
                   getSearchValue: getSearchContent,
                 ),
          
                 Visibility(
                   visible: searchValue.isEmpty,child: StreamBuilder<QuerySnapshot>(
                  stream: DataRepository().getProductStream(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData) return Center(child: LinearProgressIndicator());
                    
                    
                      return PopularItems(snapshot: snapshot.data!.docs,);
                    
                  },
                )),

                 Visibility(
                   visible: searchValue.isEmpty,child:  StreamBuilder<QuerySnapshot>(
                  stream: DataRepository().getProductStream(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData) return LinearProgressIndicator();
                    
                    
                      return RecommendedItems(snapshot: snapshot.data!.docs,);
                    
                  },
                )),


                StreamBuilder<QuerySnapshot>(
                  stream: DataRepository().getProductStream(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData) return LinearProgressIndicator();
                    
                    
                      return AllProducts(searchValue: searchValue, snapshot: snapshot.data!.docs,);
                    
                  },
                )
              ],
            ),
          );
  }
   
}