import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'pos_input_model.dart';

Future<void> printToPrinter() async {
  final profile = await CapabilityProfile.load();
  final gen = Generator(PaperSize.mm80, profile);
  List<int> bytes = [];
  final data = PosTransaction();
  bytes += gen.text(
    data.orgInfo.name,
    styles: const PosStyles(
      bold: true,
      height: PosTextSize.size2,
      width: PosTextSize.size2,
      align: PosAlign.left,
    ),
    linesAfter: 1,
  );
  bytes += gen.text(
    'Branch : ${data.branchInfo.displayName}',
    styles: const PosStyles(
      align: PosAlign.left,
    ),
  );
  if (data.branchInfo.addressInfo.address != null) {
    bytes += gen.text(
      data.branchInfo.addressInfo.address!,
      styles: const PosStyles(
        align: PosAlign.left,
      ),
    );
  }

  if (data.branchInfo.addressInfo.city != null) {
    bytes += gen.row([
      PosColumn(
        text: data.branchInfo.addressInfo.city!,
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 3,
      ),
      PosColumn(
        text: '-',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 1,
      ),
      PosColumn(
        text: data.branchInfo.addressInfo.pincode ?? '1',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 8,
      ),
    ]);
  }

  if (data.branchInfo.mobileNo != null && data.branchInfo.mobileNo!.isNotEmpty) {
    bytes += gen.row([
      PosColumn(
        text: 'Mobile',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 2,
      ),
      PosColumn(
        text: ':',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 1,
      ),
      PosColumn(
        text: data.branchInfo.mobileNo?.length == 2
            ? '${data.branchInfo.mobileNo?.first} , ${data.branchInfo.mobileNo?.last}'
            : data.branchInfo.mobileNo?.first ?? '',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 9,
      ),
    ]);
  }
  if (data.branchInfo.email != null) {
    bytes += gen.row([
      PosColumn(
        text: 'Email',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 2,
      ),
      PosColumn(
        text: ':',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 1,
      ),
      PosColumn(
        text: data.branchInfo.email ?? '',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 9,
      ),
    ]);
  }
  if (data.branchInfo.gstNo != null) {
    bytes += gen.row([
      PosColumn(
        text: 'GSTIN',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 2,
      ),
      PosColumn(
        text: ':',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 1,
      ),
      PosColumn(
        text: data.branchInfo.gstNo ?? '',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 9,
      ),
    ]);
  }
  if (data.branchInfo.licNo != null) {
    bytes += gen.row([
      PosColumn(
        text: 'LIC.No',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 2,
      ),
      PosColumn(
        text: ':',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 1,
      ),
      PosColumn(
        text: data.branchInfo.licNo ?? '',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 9,
      ),
    ]);
  }
  bytes += gen.emptyLines(1);

  bytes += gen.text(
    'TERMINAL CLOSING STATEMENT FOR : ${data.terminalName}',
    styles: const PosStyles(
      align: PosAlign.left,
    ),
  );

  bytes += gen.row([
    PosColumn(
      text: 'Printed On',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
      width: 5,
    ),
    PosColumn(
      text: ':',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
      width: 1,
    ),
    PosColumn(
      text: '22-08-2023 11:20 AM',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
      width: 6,
    ),
  ]);
  bytes += gen.row([
    PosColumn(
      text: 'Terminal CLosing On',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
      width: 5,
    ),
    PosColumn(
      text: ':',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
      width: 1,
    ),
    PosColumn(
      text: '21-08-2023 10:25 PM',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
      width: 6,
    ),
  ]);
  bytes += gen.hr(ch: '_');
  bytes += gen.emptyLines(1);
  bytes += gen.text(
    'SALE SUMMARY',
    styles: const PosStyles(
      bold: true,
      align: PosAlign.left,
      underline: true,
    ),
    linesAfter: 1,
  );
  if (data.saleBreakup.cashAmount != null) {
    bytes += gen.row([
      PosColumn(
        text: 'Cash',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 6,
      ),
      PosColumn(
        text: data.saleBreakup.cashAmount!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 6,
      ),
    ]);
  }
  if (data.saleBreakup.creditAmount != null) {
    bytes += gen.row([
      PosColumn(
        text: 'Credit',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 6,
      ),
      PosColumn(
        text: data.saleBreakup.creditAmount!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 6,
      ),
    ]);
  }
  if (data.saleBreakup.adjsAmount != null) {
    bytes += gen.row([
      PosColumn(
        text: 'Adjusted',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 6,
      ),
      PosColumn(
        text: data.saleBreakup.adjsAmount!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 6,
      ),
    ]);
  }
  if (data.saleBreakup.bankAmount != null) {
    bytes += gen.row([
      PosColumn(
        text: 'Bank',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 6,
      ),
      PosColumn(
        text: data.saleBreakup.bankAmount!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 6,
      ),
    ]);
  }
  if (data.saleBreakup.eftAmount != null) {
    bytes += gen.row([
      PosColumn(
        text: 'Eft',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 6,
      ),
      PosColumn(
        text: data.saleBreakup.eftAmount!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 6,
      ),
    ]);
  }
  bytes += gen.emptyLines(1);
  bytes += gen.row([
    PosColumn(
      text: 'Total Sale',
      styles: const PosStyles(
        align: PosAlign.left,
        bold: true,
      ),
      width: 6,
    ),
    PosColumn(
      text: data.saleTotal.toString(),
      styles: const PosStyles(
        align: PosAlign.right,
        bold: true,
      ),
      width: 6,
    ),
  ]);
  bytes += gen.emptyLines(1);
  bytes += gen.hr(
    ch: '_',
    linesAfter: 1,
  );
  bytes += gen.text(
    'CASH DETAILS',
    styles: const PosStyles(
      bold: true,
      align: PosAlign.left,
      underline: true,
    ),
    linesAfter: 1,
  );
  if (data.cashBreakup.sale != null) {
    bytes += gen.row([
      PosColumn(
        text: 'Sale',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 6,
      ),
      PosColumn(
        text: data.cashBreakup.sale!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 6,
      ),
    ]);
  }
  if (data.cashBreakup.creditNote != null) {
    bytes += gen.row([
      PosColumn(
        text: 'Credit Note',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        width: 6,
      ),
      PosColumn(
        text: data.cashBreakup.creditNote!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 6,
      ),
    ]);
  }

  bytes += gen.emptyLines(1);
  bytes += gen.row([
    PosColumn(
      text: 'Balance',
      styles: const PosStyles(
        align: PosAlign.left,
        bold: true,
      ),
      width: 6,
    ),
    PosColumn(
      text: data.cashTotal.toString(),
      styles: const PosStyles(
        align: PosAlign.right,
        bold: true,
      ),
      width: 6,
    ),
  ]);
  bytes += gen.emptyLines(1);
  bytes += gen.text(
    'DENOMINATION',
    styles: const PosStyles(
      align: PosAlign.left,
      underline: true,
      bold: true,
    ),
    linesAfter: 1,
  );
  if (data.denomination['500'] != null) {
    bytes += gen.row([
      PosColumn(
        text: '500',
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: '*',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
        width: 1,
      ),
      PosColumn(
        text: data.denomination['500']!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: (500 * data.denomination['500']!).toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 7,
      ),
    ]);
  }
  if (data.denomination['200'] != null) {
    bytes += gen.row([
      PosColumn(
        text: '200',
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: '*',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
        width: 1,
      ),
      PosColumn(
        text: data.denomination['200']!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: (200 * data.denomination['200']!).toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 7,
      ),
    ]);
  }
  if (data.denomination['100'] != null) {
    bytes += gen.row([
      PosColumn(
        text: '100',
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: '*',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
        width: 1,
      ),
      PosColumn(
        text: data.denomination['100']!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: (100 * data.denomination['100']!).toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 7,
      ),
    ]);
  }
  if (data.denomination['50'] != null) {
    bytes += gen.row([
      PosColumn(
        text: '50',
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: '*',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
        width: 1,
      ),
      PosColumn(
        text: data.denomination['50']!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: (50 * data.denomination['50']!).toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 7,
      ),
    ]);
  }
  if (data.denomination['20'] != null) {
    bytes += gen.row([
      PosColumn(
        text: '20',
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: '*',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
        width: 1,
      ),
      PosColumn(
        text: data.denomination['20']!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: (20 * data.denomination['20']!).toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 7,
      ),
    ]);
  }
  if (data.denomination['10'] != null) {
    bytes += gen.row([
      PosColumn(
        text: '10',
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: '*',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
        width: 1,
      ),
      PosColumn(
        text: data.denomination['10']!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: (10 * data.denomination['10']!).toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 7,
      ),
    ]);
  }
  if (data.denomination['5'] != null) {
    bytes += gen.row([
      PosColumn(
        text: '5',
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: '*',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
        width: 1,
      ),
      PosColumn(
        text: data.denomination['5']!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: (5 * data.denomination['5']!).toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 7,
      ),
    ]);
  }
  if (data.denomination['2'] != null) {
    bytes += gen.row([
      PosColumn(
        text: '2',
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: '*',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
        width: 1,
      ),
      PosColumn(
        text: data.denomination['2']!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: (2 * data.denomination['2']!).toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 7,
      ),
    ]);
  }
  if (data.denomination['1'] != null) {
    bytes += gen.row([
      PosColumn(
        text: '1',
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: '*',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
        width: 1,
      ),
      PosColumn(
        text: data.denomination['1']!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: (1 * data.denomination['1']!).toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 7,
      ),
    ]);
  }
  if (data.denomination['others'] != null) {
    bytes += gen.row([
      PosColumn(
        text: 'others',
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: '',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
        width: 1,
      ),
      PosColumn(
        text: '',
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 2,
      ),
      PosColumn(
        text: data.denomination['others']!.toString(),
        styles: const PosStyles(
          align: PosAlign.right,
        ),
        width: 7,
      ),
    ]);
  }
  bytes += gen.emptyLines(1);
  bytes += gen.row([
    PosColumn(
      text: 'Cash In Hand',
      styles: const PosStyles(
        align: PosAlign.left,
        bold: true,
      ),
      width: 6,
    ),
    PosColumn(
      text: data.denominationTotal.toString(),
      styles: const PosStyles(
        align: PosAlign.right,
        bold: true,
      ),
      width: 6,
    ),
  ]);
  bytes += gen.emptyLines(1);
  bool cashAvailable = false;
  num cashAmountTotal = 0;
  num diff = 0;
  if (data.denominationTotal != null) {
    cashAvailable = true;
    cashAmountTotal = (data.denominationTotal! - data.cashTotal);
  } else {
    diff = (0 - data.cashTotal);
  }
  bytes += gen.row([
    PosColumn(
      text: 'Difference',
      styles: const PosStyles(
        align: PosAlign.left,
        bold: true,
      ),
      width: 6,
    ),
    cashAvailable
        ? PosColumn(
            text: cashAmountTotal.toString(),
            styles: const PosStyles(
              align: PosAlign.right,
              bold: true,
            ),
            width: 6,
          )
        : PosColumn(
            text: diff.toString(),
            styles: const PosStyles(
              align: PosAlign.right,
              bold: true,
            ),
            width: 6,
          )
  ]);
  bytes += gen.emptyLines(1);
  bytes += gen.hr();

  bytes += gen.feed(2);
  bytes += gen.cut();
  var file = File('\\\\LOCAL-DEV1\\\\EPSON TM-T82 Receipt');
  file.writeAsBytesSync(bytes);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SizedBox(
            height: 70,
            width: 100,
            child: ElevatedButton(
              child: const Text('Print'),
              onPressed: () async {
                await printToPrinter();
              },
            ),
          ),
        ),
      ),
    );
  }
}
