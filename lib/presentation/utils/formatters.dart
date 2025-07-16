import 'package:intl/intl.dart';

class FormatterFunctions {
  static String formatarDoubleParaMoedaBRL(double valor) {
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: '');
    return formatter.format(valor);
  }

  static double converterMoedaParaDouble(String valorFormatado) {
    String valorLimpo = valorFormatado.replaceAll(RegExp(r'[^0-9,]'), '');
    valorLimpo = valorLimpo.replaceAll(',', '.');
    return double.tryParse(valorLimpo) ?? 0.0;
  }
}
