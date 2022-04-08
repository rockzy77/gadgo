
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository{
  Future<List> signIn(String email, String password) async{
    final _auth = FirebaseAuth.instance;
  try{
    List newUser = [];
    return [true, newUser];                    
  }
  catch(e){
    return [false];
  }
}

Future<List> signUp(String email, String password) async{
  final _auth = FirebaseAuth.instance;
  try{
    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
    return [true, newUser];                    
  }
  catch(e){
    return [false];
  }
}
}