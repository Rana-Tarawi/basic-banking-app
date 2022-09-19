class customer {
  final String name;
  final String email;
  final int balance;

  customer({
    required this.name,
    required this.email,
    required this.balance,
  });

  Map<String, Object> toMap() {
    return {'name': name, 'email': email, 'balance': balance};
  }
}
