import '../../common/common.dart';

//Detail

class InventoryBookDetail {
  final String title;
  final String organizationName;
  final BranchInfo branchInfo;
  final String fromDate;
  final String toDate;
  final String group;
  final List<String> branches;
  final String inventory;
  final List<InventoryBookDetailRecord> records;
  final InventoryBookSummary summary;

  InventoryBookDetail({
    required this.title,
    required this.organizationName,
    required this.branchInfo,
    required this.fromDate,
    required this.toDate,
    required this.group,
    required this.branches,
    required this.inventory,
    required this.records,
    required this.summary,
  });
}

class InventoryBookDetailRecord {
  final String? date;
  final String particulars;
  final String inward;
  final String outward;
  final String? refNo;
  final String voucherNo;
  final String voucherType;
  InventoryBookDetailRecord({
    this.date,
    required this.particulars,
    required this.inward,
    required this.outward,
    this.refNo,
    required this.voucherNo,
    required this.voucherType,
  });
}

class InventoryBookSummary {
  final num opening;
  final num closing;
  final num inward;
  final num outward;
  InventoryBookSummary({
    required this.opening,
    required this.closing,
    required this.inward,
    required this.outward,
  });
}

final InventoryBookDetail inventoryBookDetail = InventoryBookDetail(
  title: 'Inventory Book Detail Report',
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
  fromDate: '11-02-2023',
  toDate: '15-11-2023',
  group: 'Detail',
  branches: ['Dp Road Branch'],
  inventory: 'Vicks Candy',
  records: [
    InventoryBookDetailRecord(
      date: '11-02-2023',
      particulars: 'Cash',
      voucherType: 'PURCHASE',
      voucherNo: 'Dp2324092456',
      refNo: 'P1',
      inward: '58',
      outward: '88',
    ),
    InventoryBookDetailRecord(
      date: '16-03-2023',
      particulars: 'Cash',
      voucherType: 'SALE',
      voucherNo: 'Dp2324098765',
      refNo: 'S12',
      inward: '58',
      outward: '76',
    ),
    InventoryBookDetailRecord(
      date: '22-04-2023',
      particulars: 'eft',
      voucherType: 'SALE',
      voucherNo: 'Dp2324092456',
      inward: '34',
      outward: '45',
    ),
    InventoryBookDetailRecord(
      date: '11-05-2023',
      particulars: 'Credit',
      voucherType: 'PURCHASE',
      voucherNo: 'Dp2324092456',
      inward: '58',
      outward: '100',
    ),
  ],
  summary: InventoryBookSummary(
    opening: 17890,
    closing: 12345,
    inward: 1234,
    outward: 456,
  ),
);

//daily/monthly
class InventoryBook {
  final String title;
  final String organizationName;
  final BranchInfo branchInfo;
  final String fromDate;
  final String toDate;
  final String group;
  final List<String> branches;
  final String inventory;
  final List<InventoryBookRecord> records;
  final InventoryBookSummary summary;

  InventoryBook({
    required this.title,
    required this.organizationName,
    required this.branchInfo,
    required this.fromDate,
    required this.toDate,
    required this.group,
    required this.branches,
    required this.inventory,
    required this.records,
    required this.summary,
  });
}

class InventoryBookRecord {
  final String particulars;
  final String inward;
  final String outward;
  InventoryBookRecord({
    required this.particulars,
    required this.inward,
    required this.outward,
  });
}

final InventoryBook inventoryBook = InventoryBook(
  title: 'Inventory Book',
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
  fromDate: '11-02-2023',
  toDate: '15-11-2023',
  group: 'Detail',
  branches: ['Dp Road Branch'],
  inventory: 'Vicks Candy',
  records: [
    InventoryBookRecord(
      particulars: '11-02-2023',
      inward: '58',
      outward: '88',
    ),
    InventoryBookRecord(
      particulars: '16-03-2023',
      inward: '58',
      outward: '76',
    ),
    InventoryBookRecord(
      particulars: '22-04-2023',
      inward: '34',
      outward: '45',
    ),
    InventoryBookRecord(
      particulars: '11-05-2023',
      inward: '58',
      outward: '100',
    ),
  ],
  summary: InventoryBookSummary(
    opening: 17890,
    closing: 12345,
    inward: 1234,
    outward: 456,
  ),
);
