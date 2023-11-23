class Profile {
  late String email;
  late String name;
  late String surname;
  late List<String> payments;
  late List<String> addresses;

  Profile(
      {required this.email,
      required this.name,
      required this.surname,
      required this.payments,
      required this.addresses});

  Profile.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    surname = json['surname'];
    payments = json['payments'];
    addresses = json['addresses'];
  }
}
