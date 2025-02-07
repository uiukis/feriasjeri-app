import 'package:cloud_firestore/cloud_firestore.dart';

class Voucher {
  final String tour;
  final Timestamp startDate;
  final Timestamp endDate;
  final String name;
  final String phone;
  final String boarding;
  final String time;
  final num adult;
  final num? child;
  final double partialValue;
  final double? boardingValue;
  final double totalValue;
  final String? obs;
  final String? createdBy;

  Voucher({
    required this.tour,
    required this.startDate,
    required this.endDate,
    required this.name,
    required this.phone,
    required this.boarding,
    required this.time,
    required this.adult,
    this.child,
    required this.partialValue,
    this.boardingValue,
    required this.totalValue,
    this.obs,
    this.createdBy,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      tour: json['tour'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      name: json['name'],
      phone: json['phone'],
      boarding: json['boarding'],
      time: json['time'],
      adult: json['adult'],
      child: json['child'] ?? 0,
      partialValue: json['partialValue'],
      boardingValue: json['boardingValue'] ?? 0.0,
      totalValue: json['totalValue'],
      obs: json['obs'],
      createdBy: json['createdBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tour': tour,
      'startDate': startDate,
      'endDate': endDate,
      'name': name,
      'phone': phone,
      'boarding': boarding,
      'time': time,
      'adult': adult,
      'child': child,
      'partialValue': partialValue,
      'boardingValue': boardingValue,
      'totalValue': totalValue,
      'obs': obs,
      'createdBy': createdBy,
    };
  }
}
