import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_eco/global/cardtheme.dart';
import 'package:demo_eco/models/product_card_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


  class PopularItems extends StatefulWidget {
    final List<DocumentSnapshot> snapshot;
    const PopularItems({ required this.snapshot });
  
    @override
    State<PopularItems> createState() => _PopularItemsState();
  }
  
  class _PopularItemsState extends State<PopularItems> {
    List<ProductCardModel> popularproducts = [];
    List<ProductCardModel> popularproducts_detailed = [];

    @override
    void initState() {
    widget.snapshot.forEach((e) { 
       if(e['productTags'].contains('popular')){
          popularproducts_detailed.add(ProductCardModel(
          productTitle: e['productTitle'],
          productImage: e['productImage'],
          productPrice: e['productPrice'],
          productTags: e['productTags'],
          productTheme: e['productTheme'],
          productQuantity: e['productQuantity']
        ));
       }
      });
    if(popularproducts_detailed.length > 10){
      for(var i = 0; i< 10;i++){
        popularproducts.add(popularproducts_detailed[i]);
      }
    }  
    else{
      popularproducts = popularproducts_detailed;
    }
    super.initState();
  }
    @override
    Widget build(BuildContext context) {
      return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Padding(
                       padding: const EdgeInsets.only(left: 15.0, top: 15),
                       child: Text('Popular', style: GoogleFonts.poppins(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w500)),
                     ),

             popularproducts_detailed.length > 10 ? Padding(
                       padding: const EdgeInsets.only(right: 15.0, top: 15),
                       child: Text('view all', style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
                     ) : Container(), 
             ],
           ), 
           Container(child: popularItem(), height: 360,)
          
        ],
    );
    }


    Widget popularItem(){
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: popularproducts.length,
    itemBuilder: (BuildContext context, int index){
      return Container(
        width: 250,
    margin: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: cardTheme[popularproducts[index].productTheme],
      borderRadius: BorderRadius.circular(20)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Image(image: AssetImage(popularproducts[index].productImage.toString()), height: 250,width: 250,)),
        Padding(
          padding: const EdgeInsets.only(left:10.0, bottom:10),
          child: Text(popularproducts[index].productTitle.toString(), style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,maxLines: 1,),
        ),
        Padding(
          padding: const EdgeInsets.only(left:10.0, bottom:10),
          child: Text('\u{20B9}'+popularproducts[index].productPrice.toString(), style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
      ],
    ),
  );
    },
  );
}

  }