class ApiConstants {
  // static const baseUrl = "https://33f8-119-73-110-142.ngrok-free.app/api/v1/";
  static const baseUrl = "https://api.remembermylove.life/api/v1/";
  static const login = "auth/login";
  static const socialLogin = "auth/social";
  static const logout = "auth/logout";
  static const signup = "auth/signup";
  static const forgotPass = "auth/forgot-password";
  static const verifyOTP = "auth/verify-otp";
  static const resetPass = "auth/reset-password";
  static const updatePassword = "auth/change-password";
  static const deleteUser = "users/delete/";
  static const verifyFingerPrint = "auth/verify-fingerprint";
  // user RUD
  static const getUserDetails = "users/get-me";
  static const updateUserDetails = "users/update-me";
  static const getAvailableUsers = "users/find/all-users";

  // Memories CRUD
  static const getAllMemories = "memory/all";
  static const getMemoryDetailByImage = "memory/get/";
  static const getMemoriesDates = "memory/calender/memories";
  static const getAllMemoriesImages = "memory/all/images";
  static const findMemories = "memory/find/";
  static const deleteMemory = "memory/";
  static const createMemories = "memory/create";
  static const updateMemory = "memory/update";

  //categories CRUD
  static const getcategories = "category/all";
// upload media
  static const uploadPictures = "media/uploads";
  static const uploadMimTypes = "media/signed-url";
  static const getPicture = "https://remember-my-love-bucket.s3.amazonaws.com";
  static const deleteMemoryFromS3 = "media/delete";
// packcages
  static const getAllPackages = "package/all";
  static const buySubscription = "users/buy-subscription";
  static const renewSubscription = "users/renew-subscription";
  static const cancelSubscription = "users/cancel-Subscription";
  static const updateSubscription = "users/update-subscription";
  // cards
  static const getAllCards = "users/payment-methods";
  static const getDefaltCard = "users/default-card";
  static const attatchCard = "users/attach-card";
  static const deAttatchCard = "users/detach-card";
  static const setDefaltCard = "users/default-card";
  // notification
  static const getAllNotification = "notifications";
  static const seenNotification = "notifications/seen";
  // fingerPrint
  static const attatchFinger = "${baseUrl}auth/attach-fingerprint";
  // static const logout = "${_baseUrl}api/logout";
  // static const qanswers = "${_baseUrl}api/questions-and-answers";
  // concerns
  static const createConcerns = "concerns/create";
  static const updateConcerns = "users/update-me";
  static const getConcerns = "concerns/user/all";

}
