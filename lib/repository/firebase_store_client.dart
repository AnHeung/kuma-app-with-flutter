import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuma_flutter_app/model/api/firebase_user_item.dart';

class FireBaseStoreClient{

  final FirebaseFirestore firebaseFireStore =  FirebaseFirestore.instance;

  Future<FirebaseUserItem> getUserItem(String userId) async{
    DocumentSnapshot userData = await firebaseFireStore.collection("users").doc(userId).get();
    userData.data();
  }

  Future<bool> saveUserItem(String userId) async{
      try {
        await firebaseFireStore.collection("users").doc(userId).set({"isAutoScroll" : true, "homeItemCount":"15", "rankType":"airing,upcoming,movie" });
        return true;
      } catch (e) {
        print("saveUserItem error : $e");
        return false;
      }
  }

}