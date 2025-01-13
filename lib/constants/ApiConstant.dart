class ApiConstants {
  static const baseUrl =
      "https://454a-2407-aa80-14-64a9-7171-707b-5c72-83fe.ngrok-free.app/api/v1/";
  // static const baseUrl =
  //     "https://remember-my-love-7be82b8be06b.herokuapp.com/api/v1/";
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
  static const buySubscription = "users/update-subscription";
  static const renewSubscription = "users/renew-subscription";
  static const cancelSubscription = "users/cancel-Subscription";
  // cards
  static const getAllCards = "users/payment-methods";
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
}
