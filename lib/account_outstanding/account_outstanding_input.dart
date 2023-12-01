class AccountOutstanding {
  final String title;
  final String organizationName;
  final String asOnDate;
  final String sort;
  final List<String> group;
  final List<String> accounts;
  final List<String> branches;
  final String printedOn;
  final Map<String, List<AccountOutstandingRecord>> records;
  final AccountOutstandingSummary summary;

  AccountOutstanding({
    required this.title,
    required this.organizationName,
    required this.asOnDate,
    required this.sort,
    this.group = const [],
    this.accounts = const [],
    this.branches = const [],
    required this.printedOn,
    required this.records,
    required this.summary,
  });
}

class AccountOutstandingRecord {
  final String? branchName;
  final String? accountName;
  final num debit;
  final num credit;
  final num closing;

  AccountOutstandingRecord({
    this.branchName,
    this.accountName,
    required this.debit,
    required this.credit,
    required this.closing,
  });
}

class AccountOutstandingSummary {
  final num debit;
  final num credit;
  final num closing;
  AccountOutstandingSummary({
    required this.debit,
    required this.credit,
    required this.closing,
  });
}

//group1
final AccountOutstanding accountOutstanding = AccountOutstanding(
  title: 'Account Outstanding Report',
  organizationName: 'VELAVAN MEDICAL',
  asOnDate: '11-12-2023',
  sort: 'account',
  group: ['account', 'branch'],
  printedOn: '11-12-2023',
  // accounts: ['AJITH KUMAR'],
  records: {
    /* group account */
    // : [
    //   AccountOutstandingRecord(
    //     accountName: 'AJITH KUMAR',
    //     debit: 7130,
    //     credit: 7359,
    //     closing: -229,
    //   ),
    //   AccountOutstandingRecord(
    //     accountName: 'ARYA VAIDYA SALAI MADURAI',
    //     debit: 710,
    //     credit: 359,
    //     closing: -22,
    //   ),
    // ],
    /* group branch */
    // : [
    //   AccountOutstandingRecord(
    //     branchName: 'Dp Branch',
    //     debit: 7130,
    //     credit: 7359,
    //     closing: -229,
    //   ),
    //   AccountOutstandingRecord(
    //     branchName: 'SS Branch',
    //     debit: 710,
    //     credit: 359,
    //     closing: -22,
    //   ),
    // ],

/* group(branch, account) ,sort(branch)*/
    // Dp Branch: [
    //   AccountOutstandingRecord(
    //     accountName: 'AJITH KUMAR',
    //     debit: 7130,
    //     credit: 7359,
    //     closing: -229,
    //   ),
    //   AccountOutstandingRecord(
    //     accountName: 'ARYA VAIDYA SALAI MADURAI',
    //     debit: 710,
    //     credit: 359,
    //     closing: -22,
    //   ),
    // ],
    // New Branch: [
    //   AccountOutstandingRecord(
    //     accountName: 'AJITH KUMAR',
    //     debit: 7130,
    //     credit: 7359,
    //     closing: -229,
    //   ),
    //   AccountOutstandingRecord(
    //     accountName: 'ARYA VAIDYA SALAI MADURAI',
    //     debit: 710,
    //     credit: 359,
    //     closing: -22,
    //   ),
    //   AccountOutstandingRecord(
    //     accountName: 'ARYA VAIDYA SALAI MADURAI',
    //     debit: 710,
    //     credit: 359,
    //     closing: -22,
    //   ),
    // ],

    /* group(branch, account) ,sort(account)*/
    'AJITH KUMAR': [
      AccountOutstandingRecord(
        branchName: 'Dp Branch',
        debit: 7130,
        credit: 7359,
        closing: -229,
      ),
      AccountOutstandingRecord(
        branchName: 'New Branch',
        debit: 710,
        credit: 359,
        closing: -22,
      ),
    ],
    'ARYA VAIDYA SALAI MADURAI': [
      AccountOutstandingRecord(
        branchName: 'Dp Branch',
        debit: 7130,
        credit: 7359,
        closing: -229,
      ),
      AccountOutstandingRecord(
        branchName: 'New Branch',
        debit: 710,
        credit: 359,
        closing: -22,
      ),
      AccountOutstandingRecord(
        branchName: 'New Branch',
        debit: 710,
        credit: 359,
        closing: -22,
      ),
    ],
  },
  summary: AccountOutstandingSummary(
    debit: 45284,
    credit: 638751,
    closing: -593467,
  ),
);

/* Detail */

class AccountOutstandingDetail {
  final String title;
  final String organizationName;
  final String asOnDate;
  final String sort;
  final List<String> group;
  final List<String> accounts;
  final List<String> branches;
  final String printedOn;
  final Map<String, List<AccountOutstandingDetailRecord>> records;
  final AccountOutstandingSummary summary;

  AccountOutstandingDetail({
    required this.title,
    required this.organizationName,
    required this.asOnDate,
    required this.sort,
    this.group = const [],
    this.accounts = const [],
    this.branches = const [],
    required this.printedOn,
    required this.records,
    required this.summary,
  });
}

class AccountOutstandingDetailRecord {
  final String? effDate;
  final String? accountName;
  final String? branchName;
  final String? voucherType;
  final String? voucherNo;
  final String? refNo;
  final num principalAmount;
  final num days;
  final num closing;

  AccountOutstandingDetailRecord({
    this.effDate,
    this.branchName,
    this.accountName,
    this.voucherType,
    this.voucherNo,
    this.refNo,
    required this.principalAmount,
    required this.days,
    required this.closing,
  });
}

final AccountOutstandingDetail accountOutstandingDetail = AccountOutstandingDetail(
  title: 'Account Outstanding Report',
  organizationName: 'VELAVAN MEDICAL',
  asOnDate: '11-12-2023',
  sort: 'days',
  group: [],
  printedOn: '11-12-2023',
  accounts: ['AJITH KUMAR'],
  records: {
    'Dp Branch': [
      AccountOutstandingDetailRecord(
        effDate: '2022-08-02',
        voucherNo: 'DP222319',
        closing: 25,
        accountName: 'AP',
        branchName: 'DP branch',
        voucherType: 'SALE',
        principalAmount: 25,
        days: 478,
      ),
    ],
    'New Branch': [
      AccountOutstandingDetailRecord(
        effDate: '2022-08-02',
        voucherNo: 'DP222319',
        closing: 25,
        accountName: 'AP',
        branchName: 'DP branch',
        voucherType: 'SALE',
        principalAmount: 25,
        days: 478,
      ),
      AccountOutstandingDetailRecord(
        effDate: '2022-08-02',
        voucherNo: 'DP222319',
        refNo: 'SP1',
        closing: 25,
        accountName: 'AP',
        branchName: 'DP branch',
        voucherType: 'PURCHASE',
        principalAmount: 25,
        days: 478,
      ),
    ],
  },
  summary: AccountOutstandingSummary(
    debit: 45284,
    credit: 638751,
    closing: -593467,
  ),
);
