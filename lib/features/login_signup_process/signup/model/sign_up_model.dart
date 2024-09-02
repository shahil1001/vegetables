import 'package:flutter_api_call_with_mvc/core/extensions/string_extensions.dart';

class SignUpModel {
  bool? success;
  Data? data;
  String? text;

  SignUpModel({this.success, this.data, this.text});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    success = (json['success'] != null && json['success'] is bool)
        ? json['success']
        : false;
    data = json['data'] != null && json['data'] is Map
        ? Data.fromJson(json['data'])
        : null;
    text = json['text'].toString().toStringConversion();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['text'] = this.text;
    return data;
  }
}

class Data {
  String? profileId;
  String? loginId;
  String? profilePic;
  String? fullName;
  String? username;
  String? countryCode;
  String? mobileNumber;
  String? address;
  String? state;
  String? city;
  String? timezone;
  String? profession;
  String? aboutMe;
  String? latitude;
  String? longitude;
  String? pofDoc;
  String? docUploadedDate;
  String? createdDate;
  String? modifyDate;
  String? isActive;
  String? emailAddress;
  String? token;
  String? plan;
  int? userStatus;
  int? isPropertyUploadNoti;
  int? isFindMyDealNoti;
  int? isPropertyViewNoti;
  int? isPropertyTrendingNoti;
  int? isUnderContractNoti;
  int? isPropertyPriceNoti;
  int? isRateNoti;
  String? deviceType;
  String? androidToken;
  String? iosToken;
  String? webToken;
  int? isPremiumUser;
  int? emailVerified;
  int? stateId;
  int? cityId;
  int? professionId;
  String? loginType;

  Data(
      {this.profileId,
        this.loginId,
        this.profilePic,
        this.fullName,
        this.username,
        this.countryCode,
        this.mobileNumber,
        this.address,
        this.state,
        this.city,
        this.timezone,
        this.profession,
        this.aboutMe,
        this.latitude,
        this.longitude,
        this.pofDoc,
        this.docUploadedDate,
        this.createdDate,
        this.modifyDate,
        this.isActive,
        this.emailAddress,
        this.token,
        this.plan,
        this.userStatus,
        this.isPropertyUploadNoti,
        this.isFindMyDealNoti,
        this.isPropertyViewNoti,
        this.isPropertyTrendingNoti,
        this.isUnderContractNoti,
        this.isPropertyPriceNoti,
        this.isRateNoti,
        this.deviceType,
        this.androidToken,
        this.iosToken,
        this.webToken,
        this.isPremiumUser,
        this.emailVerified,
        this.stateId,
        this.cityId,
        this.professionId,
        this.loginType});

  Data.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'].toString().toStringConversion();
    loginId = json['login_id'].toString().toStringConversion();
    profilePic = json['profile_pic'].toString().toStringConversion();
    fullName = json['full_name'].toString().toStringConversion();
    username = json['username'].toString().toStringConversion();
    countryCode = json['country_code'].toString().toStringConversion();
    mobileNumber = json['mobile_number'].toString().toStringConversion();
    address = json['address'].toString().toStringConversion();
    state = json['state'].toString().toStringConversion();
    city = json['city'].toString().toStringConversion();
    timezone = json['timezone'].toString().toStringConversion();
    profession = json['profession'].toString().toStringConversion();
    aboutMe = json['about_me'].toString().toStringConversion();
    latitude = json['latitude'].toString().toStringConversion();
    longitude = json['longitude'].toString().toStringConversion();
    pofDoc = json['pof_doc'].toString().toStringConversion();
    docUploadedDate = json['doc_uploaded_date'].toString().toStringConversion();
    createdDate = json['created_date'].toString().toStringConversion();
    modifyDate = json['modify_date'].toString().toStringConversion();
    isActive = json['is_active'].toString().toStringConversion();
    emailAddress = json['email_address'].toString().toStringConversion();
    token = json['token'].toString().toStringConversion();
    plan = json['plan'].toString().toStringConversion();
    userStatus = json['user_status'].toString().toIntConversion();
    isPropertyUploadNoti =
        json['is_property_upload_noti'].toString().toIntConversion();
    isFindMyDealNoti =
        json['is_find_my_deal_noti'].toString().toIntConversion();
    isPropertyViewNoti =
        json['is_property_view_noti'].toString().toIntConversion();
    isPropertyTrendingNoti =
        json['is_property_trending_noti'].toString().toIntConversion();
    isUnderContractNoti =
        json['is_under_contract_noti'].toString().toIntConversion();
    isPropertyPriceNoti =
        json['is_property_price_noti'].toString().toIntConversion();
    isRateNoti = json['is_rate_noti'].toString().toIntConversion();
    deviceType = json['device_type'].toString().toStringConversion();
    androidToken = json['android_token'].toString().toStringConversion();
    iosToken = json['ios_token'].toString().toStringConversion();
    webToken = json['web_token'].toString().toStringConversion();
    isPremiumUser = json['is_premium_user'].toString().toIntConversion();
    emailVerified = json['email_verified'].toString().toIntConversion();
    stateId = json['state_id'].toString().toIntConversion();
    cityId = json['city_id'].toString().toIntConversion();
    professionId = json['profession_id'].toString().toIntConversion();
    loginType = json['login_type'].toString().toStringConversion();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['profile_id'] = this.profileId;
    data['login_id'] = this.loginId;
    data['profile_pic'] = this.profilePic;
    data['full_name'] = this.fullName;
    data['username'] = this.username;
    data['country_code'] = this.countryCode;
    data['mobile_number'] = this.mobileNumber;
    data['address'] = this.address;
    data['state'] = this.state;
    data['city'] = this.city;
    data['timezone'] = this.timezone;
    data['profession'] = this.profession;
    data['about_me'] = this.aboutMe;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['pof_doc'] = this.pofDoc;
    data['doc_uploaded_date'] = this.docUploadedDate;
    data['created_date'] = this.createdDate;
    data['modify_date'] = this.modifyDate;
    data['is_active'] = this.isActive;
    data['email_address'] = this.emailAddress;
    data['token'] = this.token;
    data['plan'] = this.plan;
    data['user_status'] = this.userStatus;
    data['is_property_upload_noti'] = this.isPropertyUploadNoti;
    data['is_find_my_deal_noti'] = this.isFindMyDealNoti;
    data['is_property_view_noti'] = this.isPropertyViewNoti;
    data['is_property_trending_noti'] = this.isPropertyTrendingNoti;
    data['is_under_contract_noti'] = this.isUnderContractNoti;
    data['is_property_price_noti'] = this.isPropertyPriceNoti;
    data['is_rate_noti'] = this.isRateNoti;
    data['device_type'] = this.deviceType;
    data['android_token'] = this.androidToken;
    data['ios_token'] = this.iosToken;
    data['web_token'] = this.webToken;
    data['is_premium_user'] = this.isPremiumUser;
    data['email_verified'] = this.emailVerified;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['profession_id'] = this.professionId;
    data['login_type'] = this.loginType;
    return data;
  }
}

