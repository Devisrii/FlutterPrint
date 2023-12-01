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
