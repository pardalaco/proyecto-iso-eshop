class User {
  late String name;
  late String phone;

  User({
    required this.name,
    required this.phone,
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
      };
}
