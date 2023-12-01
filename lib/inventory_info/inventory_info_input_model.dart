import '../common/common.dart';

class InventoryInfo {
  final String title;
  final String organizationName;
  final BranchInfo branchInfo;
  final List<String> branches;
  final String inventory;
  final List<InventoryInfoRecord> records;
  final InventoryInfoSummary summary;

  InventoryInfo({
    required this.title,
    required this.organizationName,
    required this.branchInfo,
    required this.branches,
    required this.inventory,
    required this.records,
    required this.summary,
  });
}

class InventoryInfoRecord {
  final String batchNo;
  final String? expiry;
  final num closing;
  final num pRate;
  final num mrp;
  final num sRate;
  final num value;
  InventoryInfoRecord({
    required this.batchNo,
    this.expiry,
    required this.closing,
    required this.pRate,
    required this.mrp,
    required this.sRate,
    required this.value,
  });
}

class InventoryInfoSummary {
  final num value;
  final num closing;

  InventoryInfoSummary({
    required this.value,
    required this.closing,
  });
}

final InventoryInfo inventoryInfo = InventoryInfo(
  title: 'Inventory Information',
  organizationName: 'VELAVAN MEDICAL',
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
  branches: ['Dp Road Branch'],
  inventory: 'Vicks Candy',
  records: [
    InventoryInfoRecord(
      batchNo: "ASaDNF0982DF1",
      expiry: "20-02-2021",
      closing: 1,
      pRate: 1.50,
      mrp: 2.50,
      sRate: 2.00,
      value: 22.50,
    ),
    InventoryInfoRecord(
      batchNo: "Vs23",
      expiry: "14-02-2021",
      closing: 1,
      pRate: 1.50,
      mrp: 2.50,
      sRate: 2.00,
      value: 22.50,
    ),
  ],
  summary: InventoryInfoSummary(
    value: 1500,
    closing: 230,
  ),
);
