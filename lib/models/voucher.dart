class Voucher {
  final String tour;
  final String name;
  final String phone;
  final String boarding;
  final String adts;
  final String obs;

  Voucher({
    required this.tour,
    required this.name,
    required this.phone,
    required this.boarding,
    required this.adts,
    required this.obs,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      tour: json['tour'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      boarding: json['boarding'] ?? '',
      adts: json['adts'] ?? '',
      obs: json['obs'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tour': tour,
      'name': name,
      'phone': phone,
      'boarding': boarding,
      'adts': adts,
      'obs': obs,
    };
  }
}
