import 'package:easy_mask/easy_mask.dart';

class MaskUtils {
  static final TextInputMask moneyMask = TextInputMask(
    mask: '9+.999,99',
    placeholder: '0',
    maxPlaceHolders: 3,
    reverse: true,
  );

  static double parseMoney(String text) {
    String cleanText =
        text.replaceAll(RegExp(r'[^0-9,]'), '').replaceAll(',', '.');
    return double.tryParse(cleanText) ?? 0.0;
  }
}
