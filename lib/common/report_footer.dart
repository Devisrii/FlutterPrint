import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

pw.Widget buildPageFooter(Context context) {
  return pw.Container(
    padding: const pw.EdgeInsets.only(bottom: -15),
    alignment: pw.Alignment.bottomRight,
    child: pw.Text(
      'Page ${context.pageNumber}/${context.pagesCount}',
      style: const pw.TextStyle(fontSize: 10),
    ),
  );
}
