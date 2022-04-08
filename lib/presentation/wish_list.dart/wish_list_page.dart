import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_eco/global/cardtheme.dart';
import 'package:demo_eco/global/products.dart';
import 'package:demo_eco/provider/fetchData/fetch_all_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  ValueNotifier totalPrice = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 15),
          child: Text(
            'My WishList',
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 30),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.65,
          child: StreamBuilder<QuerySnapshot>(
            stream: DataRepository().getProductStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: LinearProgressIndicator());
              }

              for(var i in snapshot.data!.docs){
                int price = i['productPrice'];
                totalPrice.value = totalPrice.value + price;
              }
        
              return  ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  ValueNotifier quantity = ValueNotifier(1);
                  ValueNotifier price = ValueNotifier(snapshot.data!.docs[index]['productPrice']);
                  int maxquantity = snapshot.data!.docs[index]['productQuantity'];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: cardTheme[snapshot.data!.docs[index]
                                      ['productTheme']],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Image(
                                image: AssetImage(
                                    snapshot.data!.docs[index]['productImage']),
                                height: 120,
                                width: 120,
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.55,
                                  child: Text(
                                    snapshot.data!.docs[index]['productTitle'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: price,
                                  builder: (BuildContext context, dynamic q,Widget? child) {
                                    return Text(
                                      '\u{20B9}' + q.toString(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 14, fontWeight: FontWeight.w600),
                                    );
                                  }
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 15,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        onPressed: () {
                                            if(quantity.value != maxquantity){
                                              quantity.value= quantity.value+1;
                                            price.value = price.value+snapshot.data!.docs[index]['productPrice'];
                                            }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ValueListenableBuilder(
                                        valueListenable: quantity,
                                        builder: (BuildContext context, dynamic q,Widget? child) {
                                          return Text(
                                            q.toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          );
                                        }
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 15,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        onPressed: () {
                                          if(quantity.value != 1){
                                            quantity.value= quantity.value-1;
                                            price.value = price.value-snapshot.data!.docs[index]['productPrice'];
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 177, 177, 177),
                            child: IconButton(icon: Icon(Icons.delete_outline_rounded, color: Colors.black,),
                            onPressed: (){},),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: MaterialButton(
            minWidth: 200,
            height: 50,
            shape: StadiumBorder(),
            color: Colors.black,
            onPressed: (){},
            child: ValueListenableBuilder(
              valueListenable: totalPrice,
              builder: (BuildContext context, dynamic q,Widget? child) {
                return Text('Checkout ${'\u{20B9}'+q.toString()}', style: GoogleFonts.poppins(color: Colors.white),);
              }
            ),
          ),
        ),
      ],
    );
  }
}
