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
    var a = json['content'];

    email = a['email'];
    password = a['password'];
    name = a['name'];
    surname = a['surname'];
    payment = a['payment'];
    address = a['address'];
  }
}
