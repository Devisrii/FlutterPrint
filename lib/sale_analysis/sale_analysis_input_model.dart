import '../common/common.dart';

class SaleAnalysis {
  final String title;
  final String organizationName;
  final BranchInfo branchInfo;
  final String branch;
  final String fromDate;
  final String toDate;
  final String? group;
  final List<SaleAnalysisRecord> records;
  final SaleAnalysisSummary summary;

  SaleAnalysis({
    required this.title,
    required this.organizationName,
    required this.branchInfo,
    required this.branch,
    required this.fromDate,
    required this.toDate,
    this.group,
    required this.records,
    required this.summary,
  });
}

class SaleAnalysisRecord {
  final String? name;
  final num assetValue;
  final num saleValue;
  final num sold;
  final num profitValue;
  final num profitPercent;
  SaleAnalysisRecord({
    this.name,
    required this.assetValue,
    required this.saleValue,
    required this.sold,
    required this.profitValue,
    required this.profitPercent,
  });
}

class SaleAnalysisSummary {
  final num assetValue;
  final num saleValue;
  final num sold;
  final num profitValue;
  final num profitPercent;

  SaleAnalysisSummary({
    required this.assetValue,
    required this.saleValue,
    required this.sold,
    required this.profitValue,
    required this.profitPercent,
  });
}

final SaleAnalysis saleAnalysis = SaleAnalysis(
  title: 'Sale Analysis',
  organizationName: 'VELAVAN MEDICAL',
  group: 'manufacturer',
  branchInfo: const BranchInfo(
    displayName: 'Dp Road Branch',
    gstNo: '33AANFV6837B1Z2',
    addressInfo: AddressInfo(
      address: 'south address',
      city: 'tuticorin',
      pincode: '628001',
      state: 'TAMILNADU',
      country: '',
    ),
    licNo: 'SBL01',
    mobileNo: ['9876543210', '8963251475'],
    email: 'vmdproad@gmailcom',
    phone: '',
  ),
  fromDate: '11-02-2023',
  toDate: '15-11-2023',
  branch: 'Dp Road Branch',
  records: [
    SaleAnalysisRecord(
      name: 'Dolo',
      assetValue: 2,
      saleValue: 4.98,
      sold: 1,
      profitValue: 2.98,
      profitPercent: 14,
    ),
    SaleAnalysisRecord(
      name: 'Vicks Candy',
      assetValue: 2,
      saleValue: 4.98,
      sold: 200,
      profitValue: 2.98,
      profitPercent: 14,
    ),
    SaleAnalysisRecord(
      name: 'Horlicks',
      assetValue: 2,
      saleValue: 4.98,
      sold: 10,
      profitValue: 2.98,
      profitPercent: 14,
    ),
    SaleAnalysisRecord(
      name: 'Dolo',
      assetValue: 2,
      saleValue: 4.98,
      sold: 1,
      profitValue: 2.98,
      profitPercent: -23,
    ),
  ],
  summary: SaleAnalysisSummary(
    assetValue: 100,
    saleValue: 123.50,
    sold: 10,
    profitValue: 20.50,
    profitPercent: 34,
  ),
);
