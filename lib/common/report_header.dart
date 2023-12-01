import 'package:pdf/widgets.dart' as pw;

import './branch_info.dart';

pw.Widget buildReportHeader({
  required String organizationName,
  BranchInfo? branchInfo,
  required String title,
  String? fromDate,
  String? toDate,
  String? asOnDate,
}) {
  return pw.Center(
    child: pw.Column(
      children: [
        pw.Text(
          organizationName,
          style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold),
        ),
        if (branchInfo != null) ...[
          if (branchInfo.addressInfo.address != null)
            pw.Text(
              branchInfo.addressInfo.address!,
              style: const pw.TextStyle(fontSize: 12),
            ),
          if (branchInfo.addressInfo.city != null)
            pw.Text(
              '${branchInfo.addressInfo.city!} - ${branchInfo.addressInfo.pincode ?? 1}',
              style: const pw.TextStyle(fontSize: 12),
            ),
        ],
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
        ),
        if (fromDate != null)
          pw.Text(
            '$fromDate to $toDate',
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
          ),
        if (asOnDate != null)
          pw.Text(
            'As On Date : $asOnDate',
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
          ),
      ],
    ),
  );
}
