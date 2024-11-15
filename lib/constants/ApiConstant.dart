class ApiConstants {
  // static const baseUrl = "https://remember-my-love-c7798dc8cf7c.herokuapp.com/";
  static const baseUrl = "https://7l60bxbl-3059.inc1.devtunnels.ms/";
  static const login = "api/v1/auth/login";
  static const logout = "api/v1/auth/logout";
  // user RUD
  static const getUserDetails = "api/v1/users/get-me";
  static const updateUserDetails = "api/v1/users/update-me";
  static const deleteDetails = "api/v1/users/update-me";

  // Memories CRUD
  static const getAllMemories = "api/memory/all";
  static const findMemories = "api/memory/find/";
  static const createMemories = "api/v1/memory/create";
  // static const findMemories = "api/memory/find/";

  //categories CRUD
  static const getcategories = "api/v1/category/all";
// upload media
  static const uploadPictures = "/api/v1/media/uploads";
  // static const register = "${_baseUrl}api/register";
  // static const profile = "${_baseUrl}api/profile";
  // static const logout = "${_baseUrl}api/logout";
  // static const qanswers = "${_baseUrl}api/questions-and-answers";
}
