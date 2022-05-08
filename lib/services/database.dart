import 'package:stress_detection_app/models/user.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference accountCollection = Firestore.instance.collection(
      'account');

  Future<void> updateUserData(String name, String phoneNumber, String email, String address, String profile_pic, List cart) async {
    return await accountCollection.document(uid).setData({
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address == '' ? null : address,
      'profile_pic': profile_pic,
      'cart' : cart,
    });
  }

  // userData from snapshot
  Info _userDataFromSnapshot(DocumentSnapshot snapshot) {
    print('This is ${snapshot.data['cart']}');
    return Info(
        uid: uid,
        name: snapshot.data['name'],
        email: snapshot.data['email'],
        phoneNumber: snapshot.data['phoneNumber'],
        address: snapshot.data['address'],
        cart: snapshot.data['cart'],
        profile_pic: snapshot.data['profile_pic'],
    );
  }


  // get user doc stream
  Stream<Info> get userData {
    return accountCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }


  Future getAccountList(String id) async {
    DocumentSnapshot variable = await accountCollection.document(id).get();
    return variable.data['cart'];
  }

  Future<void> addtoCart(String id, List<dynamic> cart) async {
    return await accountCollection.document(id).updateData({'cart': cart});
  }

}