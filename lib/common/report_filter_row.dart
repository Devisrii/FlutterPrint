import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget buildFilterRow({
  required String keyText,
  required String valueText,
  double? keyWidth,
  PdfColor? textColor,
}) {
  return pw.Row(
    children: [
      pw.SizedBox(
        width: keyWidth ?? 105,
        child: pw.Text(
          keyText,
          style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(
        width: 20,
        child: pw.Text(
          ':',
          style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.Text(
        valueText,
        style: pw.TextStyle(
          fontSize: 11,
          fontWeight: pw.FontWeight.bold,
          color: textColor,
        ),
      ),
    ],
  );
}
