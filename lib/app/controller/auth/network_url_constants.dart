class NetworkURL {
  static const apiKey = "T+O1NxvdHH50i5xl8Q9l22qv/HPl9OS2/+ztSIsCTPo=";

  //local host ios
  //static const baseUrl = "https://wostin.test";

  //static const baseUrl = "https://maystro.eu-1.sharedwithexpose.com/api";

  //local host android
  //static const baseUrl = "https://10.0.2.2:8000";

  static const baseUrl = "https://tagmee3.net";

  static String get checkUser => "/api/subscriber_login";

  static String get login => "/api/login";

  static String get tryToken => "/api/try_token";

  static String get createUser => "/api/create";

  static String get updateUserBasicInfo => "/api/subscriber/update";
  static String get updateUserEmail => "/api/subscriber/update_email";

  static String get testEmail => "/api/testEmail";

  static String get verify => "/api/verify";

  static String get catalog => "/api/catalog";

  static String get categories => "/api/categories";

  static String get postCart => "/api/cart/add";

  static String get catalogIcons => "/storage/waste/icons";

  static String get getHistory => "/api/cart/history";
  static String get getInvoiceById => "/api/cart/id";

  static String get getCartDetails => "/api/cart/details";

  static String get getUserHistoryTotals => "/api/cart/total";
  static String get newAcceptedItems => "/api/cart/accepted";

  static String get getTasks => "/api/driver/tasks";
  static String get completeTask => "/api/driver/tasks/set_complete";
  static String get unreadTasks => "/api/driver/tasks/unread";

  static Map<String, String>? get mainHeader => {
        "Content-type": "application/json; charset=utf8",
        "Authorization": NetworkURL.apiKey
      };

  static Map<String, String>? get mainHeaderUploadImage => {
        "Content-type": 'multipart/form-data',
        "Authorization": NetworkURL.apiKey
      };

  static String get uploadImage => "/api/subscriber/upload_avatar";
  static String get avatarUrl => "/storage/images/avatars/";

}


