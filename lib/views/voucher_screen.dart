import 'package:feriasjeri_app/models/voucher.dart';
import 'package:feriasjeri_app/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import '../services/voucher_service.dart';
import '../widgets/custom_input_field.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  final TextEditingController _tourController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _boardingController = TextEditingController();
  final TextEditingController _adtsController = TextEditingController();
  final TextEditingController _obsController = TextEditingController();

  final VoucherService _voucherService = VoucherService();

  void _saveVoucher() async {
    final voucher = Voucher(
      tour: _tourController.text,
      name: _nameController.text,
      phone: _phoneController.text,
      boarding: _boardingController.text,
      adts: _adtsController.text,
      obs: _obsController.text,
    );

    try {
      await _voucherService.saveVoucher(voucher);
      if (!mounted) return;
      showSnackBar(context, 'Voucher salvo com sucesso!');
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, 'Erro ao salvar voucher: $e', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Voucher')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: CustomInputField(
                  controller: _tourController,
                  label: 'Passeio',
                  prefixIcon: Icons.explore,
                ),
              ),
              ListTile(
                title: CustomInputField(
                  controller: _nameController,
                  label: 'Nome',
                  prefixIcon: Icons.person,
                ),
              ),
              ListTile(
                title: CustomInputField(
                  controller: _phoneController,
                  label: 'Telefone',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone,
                ),
              ),
              ListTile(
                title: CustomInputField(
                  controller: _boardingController,
                  label: 'Embarque',
                  prefixIcon: Icons.place,
                ),
              ),
              ListTile(
                title: CustomInputField(
                  controller: _adtsController,
                  label: 'ADTS',
                  prefixIcon: Icons.group,
                ),
              ),
              ListTile(
                title: CustomInputField(
                  controller: _obsController,
                  label: 'Observação',
                  prefixIcon: Icons.notes,
                ),
              ),
              ElevatedButton(
                onPressed: _saveVoucher,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
