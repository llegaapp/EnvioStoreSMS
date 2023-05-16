class PhoneCompany {
  int? slotIndex;
  String? companyName;
  bool selected = false;

  PhoneCompany({
    this.slotIndex,
    this.companyName,
  });
  factory PhoneCompany.fromJson(Map<String, dynamic> json) {
    return PhoneCompany(
      slotIndex: json['slotIndex'] == null ? '' : json['slotIndex'],
      companyName: json['companyName'] == null ? '' : json['companyName'],
    );
  }
  Map<String, dynamic> toJson(PhoneCompany item) {
    return <String, dynamic>{
      'slotIndex': item.slotIndex,
      'companyName': item.companyName,
    };
  }

  factory PhoneCompany.Copy(PhoneCompany o) {
    return PhoneCompany(
      slotIndex: o.slotIndex,
      companyName: o.companyName,
    );
  }

  get isEmpty => null;

  String toString() {
    return 'PhoneCompany(  slotIndex: $slotIndex,\n carrierName: $companyName,\n  ' +
        ',)\n )\n';
  }
}
