class PhoneCompany {
  int? slotIndex;
  String? companyName;
  bool selected = false;

  PhoneCompany({
    this.slotIndex,
    this.companyName,
  });

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
