import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feriasjeri_app/data/models/voucher.dart';
import 'package:flutter/material.dart';

class VoucherUtils {
  static Future<void> generateSampleVouchers() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    List<Voucher> vouchers = [
      Voucher(
        tour: 'Tour pela cidade',
        startDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 1))),
        endDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 7))),
        name: 'João Silva',
        phone: '123456789',
        boarding: 'Ponto A',
        time: '10:00',
        adult: 2,
        child: 1,
        partialValue: 100.0,
        boardingValue: 10.0,
        totalValue: 110.0,
        obs: 'Voucher de teste',
      ),
      Voucher(
        tour: 'Passeio no parque',
        startDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 2))),
        endDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 5))),
        name: 'Maria Oliveira',
        phone: '987654321',
        boarding: 'Ponto B',
        time: '14:00',
        adult: 1,
        child: 2,
        partialValue: 80.0,
        boardingValue: 5.0,
        totalValue: 90.0,
        obs: 'Voucher de teste adicional',
      ),
      Voucher(
        tour: 'Passeio de barco',
        startDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 3))),
        endDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 4))),
        name: 'Carlos Souza',
        phone: '1122334455',
        boarding: 'Porto Municipal',
        time: '08:00',
        adult: 2,
        child: 0,
        partialValue: 120.0,
        boardingValue: 15.0,
        totalValue: 135.0,
        obs: 'Voucher exclusivo',
      ),
      Voucher(
        tour: 'Tour gastronômico',
        startDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 5))),
        endDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 6))),
        name: 'Ana Costa',
        phone: '2233445566',
        boarding: 'Restaurante A',
        time: '18:00',
        adult: 3,
        child: 0,
        partialValue: 150.0,
        boardingValue: 0.0,
        totalValue: 150.0,
        obs: 'Voucher de jantar',
      ),
      Voucher(
        tour: 'Passeio cultural',
        startDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 10))),
        endDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 12))),
        name: 'Pedro Lima',
        phone: '3344556677',
        boarding: 'Museu X',
        time: '09:00',
        adult: 2,
        child: 1,
        partialValue: 75.0,
        boardingValue: 10.0,
        totalValue: 85.0,
        obs: 'Voucher com visita guiada',
      ),
      Voucher(
        tour: 'Aventura no parque',
        startDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 15))),
        endDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 17))),
        name: 'Paula Santos',
        phone: '4455667788',
        boarding: 'Entrada principal',
        time: '11:00',
        adult: 1,
        child: 3,
        partialValue: 200.0,
        boardingValue: 0.0,
        totalValue: 200.0,
        obs: 'Voucher de aventura familiar',
      ),
      Voucher(
        tour: 'Expedição na floresta',
        startDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 20))),
        endDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 22))),
        name: 'Lucas Almeida',
        phone: '5566778899',
        boarding: 'Ponto de encontro',
        time: '07:00',
        adult: 4,
        child: 0,
        partialValue: 180.0,
        boardingValue: 20.0,
        totalValue: 200.0,
        obs: 'Voucher para expedição com guia',
      ),
      Voucher(
        tour: 'Visita ao zoológico',
        startDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 30))),
        endDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 35))),
        name: 'Juliana Oliveira',
        phone: '6677889900',
        boarding: 'Entrada principal',
        time: '10:00',
        adult: 1,
        child: 2,
        partialValue: 50.0,
        boardingValue: 5.0,
        totalValue: 55.0,
        obs: 'Voucher para entrada com acompanhante',
      ),
      Voucher(
        tour: 'Passeio em parque aquático',
        startDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 40))),
        endDate:
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 42))),
        name: 'Felipe Rocha',
        phone: '7788990011',
        boarding: 'Portão 3',
        time: '12:00',
        adult: 2,
        child: 2,
        partialValue: 250.0,
        boardingValue: 10.0,
        totalValue: 260.0,
        obs: 'Voucher para ingressos familiares',
      ),
    ];

    for (var voucher in vouchers) {
      await firestore.collection('vouchers').add(voucher.toJson());
    }

    debugPrint('Vouchers gerados com sucesso!');
  }
}
