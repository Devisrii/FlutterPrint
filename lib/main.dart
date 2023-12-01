import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../batch_label_pdf.dart';
import '../cheque_print.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: ElevatedButton(
        //   child: const Text("Print"),
        //   onPressed: () {
        //     print("data");
        //   },
        // ),
        child: PdfPreview(
          build: (_) {
            return generateBatchLabel(data, config);
            // return buildCheque(data, config);
            // salesByIncharge(salesInchargeData);
            // stockAnalysis(stockAnalysisData);
            // expiryAnalysis(expiryAnalysisData);

            // customerWiseSales(cwsData);
            // customerWiseSalesDetail(cwsDetaildata);

            // saleRegisterDetail(saleRegDetailData);
            // saleRegisterDetailMode(saleRegDetailData);
            // saleRegisterGroupView(saleRegData);
            // saleRegisterGroupViewDetailMode(saleRegData);

            // purchaseRegisterDetail(purchaseRegDetailData);
            // purchaseRegisterDetailMode(purchaseRegDetailData);
            // purchaseRegisterGroupView(purchaseRegData);
            // purchaseRegisterGroupViewDetailMode(purchaseRegData);

            // reorderAnalysis(reorderAnalysisData);
          },
        ),
      ),
    );
  }
}
