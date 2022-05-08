class User {

  final String uid;

  User({ required this.uid });

}

class Info {

  final String uid;
  final String name;
  final String phoneNumber;
  final String email;
  final String address;
  final dynamic cart;
  final String profile_pic;

  Info({required this.uid, required this.name, required this.phoneNumber, required this.email, required this.address, this.cart, required this.profile_pic});

}