class UserData {
  String name;
  int age;
  String phone;
  List<String> address;
  String email;
  String password;
  String confirmPassword;

  UserData(
      {this.name = '',
      this.age = 0,
      this.phone = '',
      this.address = const [],
      this.email = '',
      this.password = '',
      this.confirmPassword = ''});
}
