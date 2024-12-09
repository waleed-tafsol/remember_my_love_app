class ApiConstants {
  // static const baseUrl = "https://7l60bxbl-3059.inc1.devtunnels.ms/api/v1/";
  static const baseUrl =
      "https://rml-backend-6a1ccbd78c62.herokuapp.com/api/v1/";
  static const login = "auth/login";
  static const socialLogin = "auth/social";
  static const logout = "auth/logout";
  static const signup = "auth/signup";
  static const forgotPass = "auth/forgot-password";
  static const verifyOTP = "auth/verify-otp";
  static const resetPass = "auth/reset-password";
  static const updatePassword = "/auth/change-password";
  static const deleteUser = "/users/delete/";
  static const verifyFingerPrint = "auth/verify-fingerprint";
  // user RUD
  static const getUserDetails = "users/get-me";
  static const updateUserDetails = "users/update-me";
  static const getAvailableUsers = "users/find/all-users";

  // Memories CRUD
  static const getAllMemories = "memory/all";
  static const getAllMemoriesImages = "/memory/all/images";
  static const findMemories = "api/memory/find/";
  static const createMemories = "memory/create";
  // static const findMemories = "api/memory/find/";

  //categories CRUD
  static const getcategories = "category/all";
// upload media
  static const uploadPictures = "media/uploads";
  static const uploadMimTypes = "/media/signed-url";
  static const getPicture = "https://remember-my-love-bucket.s3.amazonaws.com";
// packcages
  static const getAllPackages = "package/all";
  static const buySubscription = "/package/buy-subscription";
  // static const profile = "${_baseUrl}api/profile";
  // static const logout = "${_baseUrl}api/logout";
  // static const qanswers = "${_baseUrl}api/questions-and-answers";
}
