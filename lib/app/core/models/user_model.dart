class User {
  final String username;
  final String fullName;
  final String phone;
  final String accountType;
  final String status;
  final String id;

  User({
    required this.username,
    required this.fullName,
    required this.phone,
    required this.accountType,
    required this.status,
    required this.id,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        username: json["username"],
        fullName: json["fullName"],
        phone: json["phone"],
        accountType: json["accountType"],
        status: json["status"],
        id: json["_id"],
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "fullName": fullName,
        "phone": phone,
        "accountType": accountType,
        "status": status,
        "_id": id,
      };
}
