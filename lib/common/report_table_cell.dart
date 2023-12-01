import 'package:pdf/widgets.dart' as pw;

pw.Widget buildTableCell({
  bool isHeader = false,
  String? valueText,
  pw.Alignment? alignment,
  pw.TextStyle? textStyle,
  double? width,
  pw.Widget? widget,
  pw.EdgeInsets? padding,
}) {
  return pw.Container(
    padding: (padding != null)
        ? padding
        : isHeader
            ? const pw.EdgeInsets.symmetric(horizontal: 2)
            : const pw.EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 2,
              ),
    alignment: alignment,
    width: width,
    child: widget ??
        pw.Text(
          valueText ?? '',
          style: isHeader
              ? textStyle ??
                  pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  )
              : textStyle ??
                  const pw.TextStyle(
                    fontSize: 11,
                  ),
        ),
  );
}
