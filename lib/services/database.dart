import 'package:stress_detection_app/models/user.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference accountCollection = Firestore.instance.collection(
      'userInfo');

  Future<void> updateUserData(String name, String emailid, String profilePic) async {
    return await accountCollection.document(uid).setData({
      'name': name,
      'emailid': emailid,
      'profilePic': profilePic
    });
  }

  // userData from snapshot
  Info _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Info(
        uid: uid,
        name: snapshot.data['name'],
        emailid: snapshot.data['emailid'],
        profilePic: snapshot.data['profilePic'],
        weight: 69,
        height: 170,
        dob: DateTime(2000, 04, 29),
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

// Future<void> updateUserData(String name, String emailid, String profilePic) async {
//   return await accountCollection.document(uid).setData({
//     'name': name,
//     'emailid': emailid,
//     'profilePic': profilePic,
//     'dob': "29/04/2000",
//     'weight': 69,
//     'height': 170
//   });
// }
//
// // userData from snapshot
// Info _userDataFromSnapshot(DocumentSnapshot snapshot) {
//   return Info(
//     uid: uid,
//     name: snapshot.data['name'],
//     emailid: snapshot.data['emailid'],
//     profilePic: snapshot.data['profilePic'],
//     weight: snapshot.data['weight'],
//     height: snapshot.data['height'],
//     dob: snapshot.data['dob'],
//   );
// }