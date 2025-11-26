class SignUpDto {
  const SignUpDto({
    required this.email,
    required this.password,
    required this.fullName,
    required this.cpf,
    required this.cellphone,
  });

  final String email;
  final String password;
  final String fullName;
  final String cpf;
  final String cellphone;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fullname': fullName,
      'document': cpf,
      'phone': cellphone,

    };
  }
}