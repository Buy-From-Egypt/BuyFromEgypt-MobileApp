class CompanyInfoModel {
  final String companyName;
  final String companyType;
  final String coverImage;
  final String logoImage;
  final String followers;
  final String following;
  final String posts;
  final String about;
  final String phone;
  final String email;
  final String address;
  final String cityState;
  final String postCode;
  final List<String> socialMedia;

  CompanyInfoModel({
    required this.companyName,
    required this.companyType,
    required this.coverImage,
    required this.logoImage,
    required this.followers,
    required this.following,
    required this.posts,
    required this.about,
    required this.phone,
    required this.email,
    required this.address,
    required this.cityState,
    required this.postCode,
    required this.socialMedia,
  });

  factory CompanyInfoModel.fromJson(Map<String, dynamic> json) {
    return CompanyInfoModel(
      companyName: json["companyName"],
      companyType: json["companyType"],
      coverImage: json["coverImage"],
      logoImage: json["logoImage"],
      followers: json["followers"],
      following: json["following"],
      posts: json["posts"],
      about: json["about"],
      phone: json["phone"],
      email: json["email"],
      address: json["address"],
      cityState: json["cityState"],
      postCode: json["postCode"],
      socialMedia: List<String>.from(json["socialMedia"]),
    );
  }
}


