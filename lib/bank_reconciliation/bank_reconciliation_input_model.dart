import '../common/common.dart';

class BankReconciliation {
  final String title;
  final String organizationName;
  final BranchInfo branchInfo;
  final String fromDate;
  final String toDate;
  final String branch;
  final String account;
  final List<BankReconciliationRecord> records;
  final BankReconciliationSummary summary;

  BankReconciliation({
    required this.title,
    required this.organizationName,
    required this.branchInfo,
    required this.fromDate,
    required this.toDate,
    required this.branch,
    required this.account,
    required this.records,
    required this.summary,
  });
}

class BankReconciliationRecord {
  final String date;
  final String? bankDate;
  final String? particulars;
  final String voucherNo;
  final String voucherType;
  final num debit;
  final num credit;
  BankReconciliationRecord({
    required this.date,
    this.bankDate,
    this.particulars,
    required this.voucherNo,
    required this.voucherType,
    required this.debit,
    required this.credit,
  });
}

class BankReconciliationSummary {
  final num balanceAsPerCompanyBook;
  final num amountNotReflectedInBank;
  final num balanceAsPerBank;
  BankReconciliationSummary({
    required this.balanceAsPerCompanyBook,
    required this.amountNotReflectedInBank,
    required this.balanceAsPerBank,
  });
}

final BankReconciliation bankReconciliation = BankReconciliation(
  title: 'Bank Reconciliation Statement',
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
  branch: 'Dp Road Branch',
  account: 'Sbi Acc',
  records: [
    BankReconciliationRecord(
      date: '10-11-2023',
      bankDate: '13-10-2023',
      particulars: 'dia',
      voucherNo: 'EPRCP23246',
      voucherType: 'Receipt',
      credit: 0,
      debit: 1641,
    ),
  ],
  summary: BankReconciliationSummary(
    balanceAsPerCompanyBook: 1456,
    amountNotReflectedInBank: -456,
    balanceAsPerBank: 908,
  ),
);
