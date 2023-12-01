import '../common/common.dart';

//Detail

class AccountBookDetail {
  final String title;
  final String organizationName;
  final BranchInfo branchInfo;
  final String fromDate;
  final String toDate;
  final String group;
  final List<String> branches;
  final String account;
  final List<AccountBookDetailRecord> records;
  final AccountBookSummary summary;

  AccountBookDetail({
    required this.title,
    required this.organizationName,
    required this.branchInfo,
    required this.fromDate,
    required this.toDate,
    required this.group,
    required this.branches,
    required this.account,
    required this.records,
    required this.summary,
  });
}

class AccountBookDetailRecord {
  final String? date;
  final String particulars;
  final num debit;
  final num credit;
  final String? refNo;
  final String voucherNo;
  final String voucherType;
  AccountBookDetailRecord({
    this.date,
    required this.particulars,
    required this.debit,
    required this.credit,
    this.refNo,
    required this.voucherNo,
    required this.voucherType,
  });
}

class AccountBookSummary {
  final num opening;
  final num closing;
  final num debit;
  final num credit;
  AccountBookSummary({
    required this.opening,
    required this.closing,
    required this.debit,
    required this.credit,
  });
}

final AccountBookDetail accountBookDetail = AccountBookDetail(
  title: 'Account Book Detail Report',
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
  account: 'Cash',
  records: [
    AccountBookDetailRecord(
      date: '11-02-2023',
      particulars: 'Purchases@12%',
      voucherType: 'PURCHASE',
      voucherNo: 'Dp23292456',
      refNo: 'P1',
      debit: 58,
      credit: 88,
    ),
    AccountBookDetailRecord(
      date: '16-03-2023',
      particulars: 'Cash',
      voucherType: 'SALE',
      voucherNo: 'Dp2398765',
      refNo: 'S12',
      debit: 58,
      credit: 76,
    ),
    AccountBookDetailRecord(
      date: '22-04-2023',
      particulars: 'eft',
      voucherType: 'SALE',
      voucherNo: 'Dp2324456',
      debit: 34,
      credit: 45,
    ),
    AccountBookDetailRecord(
      date: '11-05-2023',
      particulars: 'Credit',
      voucherType: 'PURCHASE',
      voucherNo: 'Dp2324092456',
      debit: 58,
      credit: 100,
    ),
  ],
  summary: AccountBookSummary(
    opening: -17890,
    closing: 12345,
    debit: 123434,
    credit: 456222,
  ),
);

//daily/monthly
class AccountBook {
  final String title;
  final String organizationName;
  final BranchInfo branchInfo;
  final String fromDate;
  final String toDate;
  final String group;
  final List<String> branches;
  final String account;
  final List<AccountBookRecord> records;
  final AccountBookSummary summary;

  AccountBook({
    required this.title,
    required this.organizationName,
    required this.branchInfo,
    required this.fromDate,
    required this.toDate,
    required this.group,
    required this.branches,
    required this.account,
    required this.records,
    required this.summary,
  });
}

class AccountBookRecord {
  final String particulars;
  final num debit;
  final num credit;
  AccountBookRecord({
    required this.particulars,
    required this.debit,
    required this.credit,
  });
}

final AccountBook accountBook = AccountBook(
  title: 'Account Book Report',
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
  account: 'Cash',
  records: [
    AccountBookRecord(
      particulars: '11-02-2023',
      debit: 58,
      credit: 88,
    ),
    AccountBookRecord(
      particulars: '16-03-2023',
      debit: 58,
      credit: 76,
    ),
    AccountBookRecord(
      particulars: '22-04-2023',
      debit: 34,
      credit: 45,
    ),
    AccountBookRecord(
      particulars: '11-05-2023',
      debit: 58,
      credit: 100,
    ),
  ],
  summary: AccountBookSummary(
    opening: 17890,
    closing: 12345,
    debit: 1234,
    credit: 456,
  ),
);
