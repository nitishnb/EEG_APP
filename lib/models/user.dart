class User {

  final String uid;

  User({ required this.uid });

}

class Info {

  final String uid;
  final String name;
  final String emailid;
  final String profilePic;
  final double height;
  final double weight;
  final DateTime dob;

  Info({required this.uid, required this.name, required this.emailid, required this.profilePic, required this.weight, required this.height, required this.dob});

}