class ProfileAccountModel {
  String? buyerId; // Corrected the spelling of 'buyerId'
  String? email;
  String? fullName;
  String? password; // You might not want to store this as it's sensitive data
  String? phoneNumber;
  String? profileImage;

  ProfileAccountModel({
    this.buyerId,
    this.email,
    this.fullName,
    this.password,
    this.phoneNumber,
    this.profileImage,
  });

  // Convert a ProfileAccountModel object into a Map object
  Map<String, dynamic> toJson() {
    return {
      'buyerId': buyerId,
      'email': email,
      'fullName': fullName,
      'password': password,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
    };
  }

  // Extract a ProfileAccountModel object from a Map object
  factory ProfileAccountModel.fromJson(Map<String, dynamic> json) {
    return ProfileAccountModel(
      buyerId: json['buyerId'],
      email: json['email'],
      fullName: json['fullName'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'],
    );
  }
}
