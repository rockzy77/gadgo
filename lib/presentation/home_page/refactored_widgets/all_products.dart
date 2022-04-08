import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_eco/global/cardtheme.dart';
import 'package:demo_eco/global/products.dart';
import 'package:demo_eco/models/product_card_model.dart';
import 'package:demo_eco/provider/fetchData/fetch_all_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


  class AllProducts extends StatefulWidget {
    final String searchValue;
    final List<DocumentSnapshot> snapshot;
    const AllProducts({ required this.searchValue, required this.snapshot});
  
    @override
    State<AllProducts> createState() => _AllProductsState();
  }
  
  class _AllProductsState extends State<AllProducts> {
    List<ProductCardModel> allproducts = [];

    @override
    void initState() {
        widget.snapshot.forEach((e) { 
        allproducts.add(ProductCardModel(
          productTitle: e['productTitle'],
          productImage: e['productImage'],
          productPrice: e['productPrice'],
          productTags: e['productTags'],
          productTheme: e['productTheme'],
          productQuantity: e['productQuantity']
        ));
      });
      fetchedProducts = allproducts;
    super.initState();
  }

  void getSearchProduct(String value){
    allproducts = fetchedProducts;
    List<ProductCardModel> temproducts = [];
    for(var i in allproducts){
      if(i.productTitle!.toLowerCase().contains(value)){
        temproducts.add(i);
      }
    }
    setState(() {
      allproducts = temproducts;
    });
  }
    @override
    Widget build(BuildContext context) {
      if(widget.searchValue.isNotEmpty){
        getSearchProduct(widget.searchValue);
      }
      return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
               Padding(
                       padding: const EdgeInsets.only(left: 15.0, top: 15),
                       child: Text('Explore The Products', style: GoogleFonts.poppins(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w500)),
                     ),

      
           allproducts.isNotEmpty? Container(child: allItems(), height: 500,) : Padding(
             padding: const EdgeInsets.only(top: 58.0),
             child: Center(child: Text('No Items Found..', style: GoogleFonts.poppins(fontSize: 18),)),
           )
          
        ],
    );
    }


    Widget allItems(){
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    scrollDirection: Axis.vertical,
    itemCount: allproducts.length,
    itemBuilder: (BuildContext context, int index){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: cardTheme[allproducts[index].productTheme]
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image(image: AssetImage(allproducts[index].productImage.toString()), height: 150, width: 150,)),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(allproducts[index].productTitle.toString(), style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,maxLines: 1,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('\u{20B9}'+allproducts[index].productPrice.toString(), style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700),),
            )
          ],
        ),
      );
    },
  );
}

  }