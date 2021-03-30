class Users{

  final String uid;
  final String displayName;
  final String photoURL;

  Users(this.uid, this.displayName, this.photoURL);

  //getter
  String get Uid => this.uid;
  String get DisplayName => this.displayName;
  String get PhotoURL => this.photoURL;
}