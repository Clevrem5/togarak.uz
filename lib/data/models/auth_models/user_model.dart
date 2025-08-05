class UserModel {
  final String email;
  final String givenName;
  final String deviceId;
  final String familyName;

  UserModel({
    required this.deviceId,
    required this.givenName,
    required this.email,
    required this.familyName,
  });

  Map<String, dynamic> toQuery() => {
    "device_Id": deviceId,
    "email": email,
    "given_name": givenName,
    "family_name": familyName,
  };
}
