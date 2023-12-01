import '../common/common.dart';

class ScheduleDrug {
  final String title;
  final String organizationName;
  final BranchInfo branchInfo;
  final String date;
  final List<ScheduleDrugRecord> records;

  ScheduleDrug({
    required this.title,
    required this.organizationName,
    required this.branchInfo,
    required this.date,
    required this.records,
  });
}

class ScheduleDrugRecord {
  final AddressInfo address;
  final String? patient;
  final String? doctor;
  final String? licNo;
  final String voucherNo;
  final List<InventoryTransaction> invTrns;

  ScheduleDrugRecord({
    required this.address,
    this.patient,
    this.doctor,
    this.licNo,
    required this.voucherNo,
    required this.invTrns,
  });
}

class InventoryTransaction {
  final String inventory;
  final String? manufacturer;
  final String? batchNo;
  final String? expiry;
  final num qty;
  InventoryTransaction({
    required this.inventory,
    this.manufacturer,
    this.batchNo,
    this.expiry,
    required this.qty,
  });
}

final ScheduleDrug scheduleDrug = ScheduleDrug(
  title: 'SCHEDULED DRUG REPORT',
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
  date: '11-12-2023',
  records: [
    ScheduleDrugRecord(
      doctor: 'Raju',
      licNo: 'DPO890',
      patient: 'Gokul',
      address: const AddressInfo(
        address: 'south address',
        city: 'tuticorin',
        pincode: '628001',
        state: 'TAMILNADU',
        country: '',
      ),
      voucherNo: 'Dp89056',
      invTrns: [
        InventoryTransaction(
          inventory: 'Vicks Candy',
          qty: 10,
          batchNo: 'BOAGV036',
          expiry: '2024-07-01',
        ),
        InventoryTransaction(
          inventory: 'dolo11',
          manufacturer: 'TEST MANUFACTURER',
          batchNo: 'S1',
          expiry: '2024-07-01',
          qty: 2.0,
        ),
      ],
    ),
  ],
);
