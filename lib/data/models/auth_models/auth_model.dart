class AuthModel {
  final String? name;
  final String? surname;
  final String? phone;
  final String? password;

  AuthModel({
    this.name,
    this.surname,
    this.phone,
    this.password,
  });

  // JSONdan AuthModelga o'girish
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      phone: json['phone'] as String?,
      password: json['user_password'] as String?, // json key nomi o'zgargan
    );
  }

  // AuthModelni JSONga o'girish
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'phone': phone,
      'user_password': password, // bu yerda ham json key `user_password`
    };
  }

  // copyWith qoʻlda
  AuthModel copyWith({
    String? name,
    String? surname,
    String? phone,
    String? password,
  }) {
    return AuthModel(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'AuthModel(name: $name, surname: $surname, phone: $phone, password: $password)';
  }
}
