class ApiConfig {
  static String baseDomain = 'https://qp.forca.id/';
  static String baseUrl = '${baseDomain}api/v1/distributor/';

  static String urlLogin = '${baseUrl}auth/login';
  static String urlResetPass = '${baseUrl}auth/forgot_password';
  static String urlProfile = '${baseUrl}auth/profile';
}
