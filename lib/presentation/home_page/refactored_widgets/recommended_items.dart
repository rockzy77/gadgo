import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_eco/global/cardtheme.dart';
import 'package:demo_eco/models/product_card_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


  class RecommendedItems extends StatefulWidget {
    final List<DocumentSnapshot> snapshot;
    const RecommendedItems({required this.snapshot });
  
    @override
    State<RecommendedItems> createState() => _RecommendedItemsState();
  }
  
  class _RecommendedItemsState extends State<RecommendedItems> {
    List<ProductCardModel> recommendedproducts = [];
    List<ProductCardModel> recommendedproducts_detailed = [];

    @override
    void initState() {
    widget.snapshot.forEach((e) { 
       if(e['productTags'].contains('wearables') || e['productTags'].contains('Mobile Phones')){
          recommendedproducts_detailed.add(ProductCardModel(
          productTitle: e['productTitle'],
          productImage: e['productImage'],
          productPrice: e['productPrice'],
          productTags: e['productTags'],
          productTheme: e['productTheme'],
          productQuantity: e['productQuantity']
        ));
       }
      });
       if(recommendedproducts_detailed.length > 10){
      for(var i = 0; i< 10;i++){
        recommendedproducts.add(recommendedproducts_detailed[i]);
      }
    }  
    else{
      recommendedproducts = recommendedproducts_detailed;
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
                       child: Text('Recommended', style: GoogleFonts.poppins(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w500)),
                     ),

              recommendedproducts_detailed.length > 10 ? Padding(
                       padding: const EdgeInsets.only(right: 15.0, top: 15),
                       child: Text('view all', style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
                     ) : Container(),   
             ],
           ), 
           Container(child: recommendedItem(), height: 360,)
          
        ],
    );
    }


    Widget recommendedItem(){
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: recommendedproducts.length,
    itemBuilder: (BuildContext context, int index){
      return Container(
        width: 250,
    margin: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: cardTheme[recommendedproducts[index].productTheme],
      borderRadius: BorderRadius.circular(20)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: AssetImage(recommendedproducts[index].productImage.toString()), height: 250,width: 250,),
        Padding(
          padding: const EdgeInsets.only(left:10.0, bottom:10),
          child: Text(recommendedproducts[index].productTitle.toString(), style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,maxLines: 1,),
        ),
        Padding(
          padding: const EdgeInsets.only(left:10.0, bottom:10),
          child: Text('\u{20B9}'+recommendedproducts[index].productPrice.toString(), style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
      ],
    ),
  );
    },
  );
}

  }