import 'package:flutter/material.dart';
import 'dart:io';

import './zpl_input_model.dart';

Future<void> printToZPLPrinter() async {
  const data = InventoryInfo();
  String bytes = '''
^XA
    ^CFB,17,12
    ^FO5,50^TBN,220,20^FDVicks Candy^FS
    ^CFA,22,10
    ^FO10,80^FDRs.100.00/PCS^FS
    ^FO10,88^GB150,0,1,B^FS
    ^FO10,110^FDRs.80.00/PCS^FS
    ^FO180,75^BY4,2.0,4^BQN,2,3^FDl123^FS
     ^CFB,6,4
    ^FO10,160^FDMfg.dt:2029^FS
    ^FO140,160^FDExp.dt:^FS
    

    ^CFB,17,12
    ^FO285,50^TBN,220,20^FDAshirvad Chakki atta 1 kg^FS
    ^CFA,22,10
    ^FO290,80^FDRs.80.00/PCS^FS
    ^FO290,88^GB150,0,1,B^FS
    ^FO290,110^FDRs.70.00/PCS^FS
    ^FO460,75^BY4,2.0,4^BQN,2,3^FDlAshirvad Chakki atta 1 kg^FS
     ^CFB,6,4
    ^FO290,160^FDMfg.dt:^FS
    ^FO420,160^FDExp.dt:^FS
    

    ^CFB,17,12
    ^FO565,50^TBN,220,20^FDVicks Candy^FS
    ^CFA,22,10
    ^FO570,80^FDRs.100.00/PCS^FS
    ^FO570,88^GB150,0,1,B^FS
    ^FO570,110^FDRs.80.00/PCS^FS
    ^FO740,75^BY4,2.0,4^BQN,2,3^FDl123^FS
     ^CFB,6,4
    ^FO570,160^FDMfg.dt:20-1-2023^FS
    ^FO700,160^FDExp.dt:^FS
    

^XZ
  ''';

  var file = File('\\\\LOCAL-DEV1\\\\ZD230-203dpi');
  file.writeAsStringSync(bytes);
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
                await printToZPLPrinter();
              },
            ),
          ),
        ),
      ),
    );
  }
}
