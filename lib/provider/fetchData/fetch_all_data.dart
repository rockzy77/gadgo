import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_eco/models/product_card_model.dart';

class DataRepository{
  final CollectionReference collection = FirebaseFirestore.instance.collection('products');

   Stream<QuerySnapshot> getProductStream() {
    return collection.snapshots();
  }

  
}