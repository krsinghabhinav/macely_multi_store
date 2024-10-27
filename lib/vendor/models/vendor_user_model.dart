class VendorUserModel {
  final bool? approved;
  final String? bussinessName;
  final String? cityValue;
  final String? countryValue;
  final String? email;
  final String? image;
  final String? phoneNumber;
  final String? stateValue;
  final String? taxNumber;
  final String? taxRegister;

  // Named parameters constructor
  VendorUserModel({
    required this.approved,
    required this.bussinessName,
    required this.cityValue,
    required this.countryValue,
    required this.email,
    required this.image,
    required this.phoneNumber,
    required this.stateValue,
    required this.taxNumber,
    required this.taxRegister,
  });

  // fromJson constructor
  VendorUserModel.fromJson(Map<String, dynamic> json)
      : approved = json['approved'] as bool?,
        bussinessName = json['bussinessName'] as String?,
        cityValue = json['cityValue'] as String?,
        countryValue = json['countryValue'] as String?,
        email = json['email'] as String?,
        image = json['image'] as String?,
        phoneNumber = json['phoneNumber'] as String?,
        stateValue = json['stateValue'] as String?,
        taxNumber = json['taxNumber'] as String?,
        taxRegister = json['taxRegister'] as String?;

  // toJson method (optional) for converting model to JSON
  Map<String, dynamic> toJson() {
    return {
      'approved': approved,
      'bussinessName': bussinessName,
      'cityValue': cityValue,
      'countryValue': countryValue,
      'email': email,
      'image': image,
      'phoneNumber': phoneNumber,
      'stateValue': stateValue,
      'taxNumber': taxNumber,
      'taxRegister': taxRegister,
    };
  }
}
