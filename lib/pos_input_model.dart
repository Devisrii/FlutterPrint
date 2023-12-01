class PosTransaction {
  final OrgInfo orgInfo;
  final BranchInfo branchInfo;
  final String terminalName;
  final SaleBreakup saleBreakup;
  final CashBreakup cashBreakup;
  final num saleTotal;
  final num cashTotal;
  final Map<String, num> denomination;
  final num? denominationTotal;

  PosTransaction({
    this.orgInfo = const OrgInfo(name: 'Velavan Medical'),
    this.branchInfo = const BranchInfo(
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
    this.terminalName = 'Raju',
    this.saleBreakup = const SaleBreakup(
      cashAmount: 500,
      creditAmount: 100,
    ),
    this.cashBreakup = const CashBreakup(
      sale: 500,
    ),
    this.saleTotal = 14300.00,
    this.cashTotal = 12300.00,
    this.denomination = const {
      '500': 5,
      '200': 1,
      '100': 5,
      '50': 2,
      '10': 10,
      '1': 5,
    },
    this.denominationTotal = 0.0,
  });
}

class OrgInfo {
  final String name;

  const OrgInfo({
    required this.name,
  });
}

class BranchInfo {
  final String displayName;
  final String? gstNo;
  final AddressInfo addressInfo;
  final String? licNo;
  final List<String>? mobileNo;
  final String? email;
  final String? phone;
  const BranchInfo({
    required this.displayName,
    this.gstNo,
    required this.addressInfo,
    this.licNo,
    this.mobileNo,
    this.email,
    this.phone,
  });
}

class AddressInfo {
  final String? address;
  final String? city;
  final String? pincode;
  final String? state;
  final String? country;
  const AddressInfo({
    this.address,
    this.city,
    this.pincode,
    this.state,
    this.country,
  });
}

class SaleBreakup {
  final num? cashAmount;
  final num? creditAmount;
  final num? adjsAmount;
  final num? bankAmount;
  final num? eftAmount;
  const SaleBreakup({
    this.cashAmount,
    this.creditAmount,
    this.adjsAmount,
    this.bankAmount,
    this.eftAmount,
  });
}

class CashBreakup {
  final num? sale;
  final num? creditNote;

  const CashBreakup({
    this.sale,
    this.creditNote,
  });
}
