import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../common/common.dart';

class BatchLabelData {
  String inventoryCode;
  String inventoryName;
  double mrp;
  double rate;
  String unit;
  String? mfg;
  String? expiry;

  BatchLabelData({
    required this.inventoryCode,
    required this.inventoryName,
    required this.mrp,
    required this.rate,
    required this.unit,
    this.mfg,
    this.expiry,
  });
}

class Position {
  final double x;
  final double y;

  Position({
    required this.x,
    required this.y,
  });
}

class TextConfig {
  final String? title;
  final Position pos;
  final double? width;
  final double? size;

  TextConfig({
    this.title,
    required this.pos,
    this.width,
    this.size,
  });
}

class BatchLabelConfig {
  final double width;
  final double height;
  final int noOfLabels;
  final double? labelGap;
  final double inventoryX;
  final double inventoryY;
  final double inventoryWidth;
  final double mrpX;
  final double mrpY;
  final double sRateX;
  final double sRateY;
  final double qrCodeX;
  final double qrCodeY;
  final double mfgDateX;
  final double mfgDateY;
  final double expiryDateX;
  final double expiryDateY;

  BatchLabelConfig({
    required this.width,
    required this.height,
    this.labelGap,
    this.noOfLabels = 1,
    required this.inventoryX,
    required this.inventoryY,
    required this.inventoryWidth,
    required this.mrpX,
    required this.mrpY,
    required this.sRateX,
    required this.sRateY,
    required this.qrCodeX,
    required this.qrCodeY,
    required this.mfgDateX,
    required this.mfgDateY,
    required this.expiryDateX,
    required this.expiryDateY,
  });
}

final config = BatchLabelConfig(
  noOfLabels: 3,
  width: 105,
  height: 22,
  inventoryX: 1,
  inventoryY: 4,
  inventoryWidth: 30,
  mrpX: 1,
  mrpY: 8,
  sRateX: 1,
  sRateY: 12,
  qrCodeX: 24,
  qrCodeY: 8,
  mfgDateX: 1,
  mfgDateY: 18,
  expiryDateX: 18,
  expiryDateY: 18,
);
final data = [
  BatchLabelData(
    inventoryCode: '123',
    inventoryName: 'Vicks Candy',
    mrp: 3456.0,
    rate: 80.0,
    unit: 'PCS',
    mfg: '10-02-2029',
    expiry: '10-02-2029',
  ),
  BatchLabelData(
    inventoryCode: "Ashirvad Chakki atta 1 kg",
    inventoryName: "Ashirvad Chakki atta 1 kg",
    mrp: 80.0,
    rate: 70.0,
    unit: 'PCS',
  ),
  BatchLabelData(
    inventoryCode: '123',
    inventoryName: 'Vicks Candy',
    mrp: 100.0,
    rate: 80.0,
    unit: 'PCS',
    mfg: '20-1-2023',
    expiry: '20-1-2023',
  ),
  BatchLabelData(
    inventoryCode: "124",
    inventoryName: "Halls Candy",
    mrp: 80.0,
    rate: 70.0,
    unit: 'PCS',
    expiry: '20-1-2023',
  ),
  BatchLabelData(
    inventoryCode: '123',
    inventoryName: 'Vicks Candy',
    mrp: 100.0,
    rate: 80.0,
    unit: 'PCS',
    mfg: '2029',
    expiry: '20-1-2023',
  ),
  BatchLabelData(
    inventoryCode: "124",
    inventoryName: "Halls Candy",
    mrp: 80.0,
    rate: 70.0,
    unit: 'PCS',
  ),
];

Future<Uint8List> generateBatchLabel(
  List<BatchLabelData> data,
  BatchLabelConfig config,
) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  final font = pw.Font.helvetica();
  final bold = pw.Font.helveticaBold();
  final pageFormat = PdfPageFormat(mm(config.width), mm(config.height));
  for (final records in data.slices(config.noOfLabels)) {
    print(records.length);
    List<pw.Widget> children = [];
    for (var i = 0; i < records.length; i++) {
      children.addAll(
        [
          pw.Positioned(
            left: mm(config.inventoryX + i * 35),
            top: mm(config.inventoryY),
            child: pw.SizedBox(
              width: mm(config.inventoryWidth),
              child: pw.Text(
                records[i].inventoryName,
                maxLines: 1,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          pw.Positioned(
            left: mm(config.mrpX + i * 35),
            top: mm(config.mrpY),
            child: pw.Text(
              'Rs.${records[i].mrp}/${records[i].unit}',
              style: pw.TextStyle(
                fontSize: 9,
                fontWeight: pw.FontWeight.bold,
                decoration: pw.TextDecoration.lineThrough,
              ),
            ),
          ),
          pw.Positioned(
            left: mm(config.sRateX + i * 35),
            top: mm(config.sRateY),
            child: pw.Text(
              'Rs.${records[i].rate}/${records[i].unit}',
              style: pw.TextStyle(
                fontSize: 9,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Positioned(
            left: mm(config.qrCodeX + i * 35),
            top: mm(config.qrCodeY),
            child: pw.BarcodeWidget(
              barcode: pw.Barcode.qrCode(),
              data: records[i].inventoryCode,
              width: 25,
              height: 25,
            ),
          ),
          pw.Positioned(
            left: mm(config.mfgDateX + i * 35),
            top: mm(config.mfgDateY),
            child: pw.Text(
              'Mfg.Dt: ${records[i].mfg ?? ''}',
              style: pw.TextStyle(fontSize: 5, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Positioned(
            left: mm(config.expiryDateX + i * 35),
            top: mm(config.expiryDateY),
            child: pw.Text(
              'Exp.Dt: ${records[i].expiry ?? ''}',
              style: pw.TextStyle(fontSize: 5, fontWeight: pw.FontWeight.bold),
            ),
          ),
        ],
      );
    }

    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          theme: pw.ThemeData.withFont(base: font, bold: bold),
          pageFormat: pageFormat,
        ),
        build: (context) {
          {
            return pw.Stack(
              children: children,
            );
          }
        },
      ),
    );
  }

  return pdf.save();
}
