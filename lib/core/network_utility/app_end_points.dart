class EndPoints {
  // static const String baseUrl = "http://3.130.66.173/v15";
  static const String baseUrl = "https://shareittofriends.com/demo/flutter";
  static const String threeDMapBaseUrl = "https://b209-103-163-58-226.ngrok-free.app";
  static const String getProductsList = "/productList.php";
  static const String addProductsList = "/addProduct.php";
  static const String editProductsList = "/editProduct.php";
  static const String deleteProduct= "/deleteProduct.php";
  static const String login = "/Login.php";
  static const String register = "/Register.php";
  static const String forgotPassword = "/forgot_password";
  static const String otpSend = "/email/otp/sent";
  static const String verifyOtp = "/email/otp/verify";
  static const String getProfile = "/get_other_user_details";
  static const String notification = "/all/notification/status/update";
  static const String editProfile = "/edit_profile";
  static const String professionList = "/profession/list";
  static const String supportHelp = "/help/mail";
  static const String changePassword = "/change_password";
  static const String checkSearchAddress = "/property/search";
  static const String requestProperty = "/property/search/all";
  static const String propertyList = "/common/property";
  static const String propertyDetail = "/common/property/details";
  static const String addPropertyDocument = "/common/upload_files";
  static const String propertyDocumentDetail = "/common/document/list";
  static const String deletePropertyDocument = "/common/document/delete";
  static const String iPortalStatus = "/user/premium/status";
  static const String statesList = "/state";
  static const String assetType = "/common/type";
  static const String cityList = "/city";
  static const String logout = "/logout";
  static const String deleteAccount = "/user/delete";
  static const String reportProperty = "/submit/review";
  static const String deleteProperty = "/property/my/delete";
  static const String addManualProperty = "/property/manual/create";
  static const String addProperty = "/property/my/new";
  static const String editProperty = "/property/my/edit";
  static const String editPropertyManually = "/property/manual/edit";
  static const String addInvestorLicenceInfo = "/user/iportal/add";
  static const String myUploadProperty = "/common/property";
  static const String propertyType = "/common/type";
  static const String threeDMap = "/get-map-link";
  static const String allStatePropertyList = "/get/allstate/property/list";
  static const String allVerifiedInvestorList = "/premium/user/list";

  static const String googleSearch = "https://places.googleapis.com/v1/places:autocomplete";
  static const String googleSearchDetail = "https://places.googleapis.com/v1/places";


  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;
}
