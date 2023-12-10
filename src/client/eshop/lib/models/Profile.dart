class Profile {
  late String email;
  late String name;
  late String surname;
  late String password;
  late String? payment;
  late String? address;

  Profile(
      {required this.email,
      required this.password,
      required this.name,
      required this.surname,
      this.payment,
      this.address});

  Profile.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    surname = json['surname'];
    payment = json['payment'];
    address = json['address'];
  }
}
