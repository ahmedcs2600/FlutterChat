class PeopleItem {
  String FullName;
  String InstID;
  String MemberEmail;
  String MemberID;
  String ProfileImage;
  String Role;
  String StandardNumber;
  String UserBio;

  PeopleItem.fromJson(Map<dynamic, dynamic> data, dynamic key) {
    FullName = data["FullName"];
    InstID = data["InstID"];
    MemberEmail = data["MemberEmail"];
    MemberID = data["MemberID"];
    MemberID = data["MemberID"];
    ProfileImage = data["ProfileImage"];
    Role = data["Role"];
    StandardNumber = data["StandardNumber"];
    UserBio = data["UserBio"];
  }
}
