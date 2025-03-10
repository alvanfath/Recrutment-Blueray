class LoginModel {
  final bool login;
  final String? token;
  final String? message;
  final Map<String, dynamic>? customer;

  LoginModel({
    this.login = false,
    this.token,
    this.message,
    this.customer,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      login: json['login'] ?? false,
      token: json['token'],
      message: json['message'],
      customer: json['customer'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'token': token,
      'message': message,
      'customer': customer,
    };
  }
}
