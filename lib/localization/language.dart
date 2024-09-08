import 'package:get/get.dart';

class Languages implements Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'ar': {
          'language': 'اللغة',
          'sign_in': 'تسجيل الدخول',
          'sign_in_header': 'الدخول إلى حسابك',
          'user_email': 'بريد المستخدم',
          'password': 'كلمة المرور',
          'invalid_login': 'بيانات الدخول خاطئة',
          'invalid_user': 'اسم المستخدم غير صحيح',
          'or': 'أو',
          'forget_password': 'نسيت كلمة المرور',
          'remember_me': 'تذكرني دائماً',
          'no_account_press_here': 'ليس لديك حساب ؟ اضغط هنا !ً',
          'name': 'الإسم',
          'address': 'العنوان',
          'phone_number': 'رقم الهاتف',
          'delete_account': 'إلغاء الحساب',
          'sign_out': 'تسجيل الخروج',
          'profile_total_money': 'إجمالي الرصيد',
          'profile_total_shipment': 'عدد الشحنات',
          'currency_rs': 'ريال',
          'profile_settings': 'الإعدادات',
          'save': 'حفظ',
          'update': 'حفظ',
          'saved_email': 'تم حفظ البريد بنجاح',

          //** Empty Data Widget
          'no_data': 'لا يوجد بيانات',
          'will_display_data_when_available': 'ستظهر عندما تكون متاحة',

          ///**** Welcome Screen ***********
          'start_here': 'ابدأ الأن !',
          'line_1': 'تخلص من الكراكيب',
          'line_2': 'واكسب فلوس',
          'iam_driver': 'المهام',

          ///**** MyOrders Screen ***********
          'points': 'نقاط',
          'point': 'نقطة',
          'sr': 'ريال',
          'my_orders': 'طلباتي',
          'status_open': 'قائمة الإنتظار',
          'status_progress': 'في الطريق',
          'status_complete': 'تم بنجاح',

          ///**** View QR Code Screen ***********
          'go_back': 'رجوع',
          'shipment_code': 'كود الشحنة',
          'confirm': 'استلام',
          'confirmed':'هل تريد تأكيد الاستلام ؟',
          'cancel':'اغلاق',
          'ok':'موافق',


          ///**** Loading Widget ***********
          'loading': 'جاري التحميل',
          'please_wait': 'من فضلك انتظر ...',

          ///**** Settings Page ***********
          'basic_info': 'بيانات أساسية',
          'Account & Security': 'الحساب والأمان',
          'User Account': 'حساب المستخدم',
          'settings_description_1': 'تغير الاسم والهاتف والعنوان',
          'settings_description_2': 'اعدادات الأمان واختيارات الحساب',
          'settings_description_3': 'تغير حساب الدخول',
          'email_account': 'البريد الإليكتروني',
          'User Interface': 'واجهة المستخدم',
          'Dark Theme': 'نمط ليلي',
          'Toggle Theme Light / Dark': 'تبديل بين النمط الداكن والفاتح',
          'Interface Language': 'اللغة المستخدمة',

          ///**** Account & Security Settings Widget ***********
          'my_account': 'حسابي',

          ///**** Main Page ***********
          'browse_all_orders': 'استعراض طلباتك',
          'Press here': 'اضغط هنا !',
          'you_have': 'لديك',
          'welcome': 'مرحبا',

          ///**** My Tasks Page ***********
          'my_tasks': 'أوامر الشغل',
          'new_tasks': 'مهام جديدة',
          'you_have_:': 'لديك : ',
          "BackgroundServiceTitle": 'المهام',
          "BackgroundServiceBody": 'فحص المهام والاحداث الجديدة',
          'app_name': 'تجميع',
          'delivered': 'تم تأكيد استلام شحنتك',

          ///**** My notifications Page ***********
          'notifications': 'الاشعارات',

          ///**** My Image Page ***********
          'change_image': 'تغير الصورة',
          'save_image': 'حفظ الصورة',
          'cancel_image': 'الغاء الصورة',
          'avatar': 'الصورة الشخصية',
          'avatar_saved': 'تم حفظ الصورة بنجاح',
          'user_image':'صورة المستخدم',

          'delivery_code': 'كود التسليم',
          'main_page':'الصفحة الرئيسية',
          'shipment_details':'تفاصيل شحنة',
          'code':'كود',
          'error':'خطأ',
          'connection_error':'خطأ في الاتصال بالبيانات',
          'item':'الصنف',
          'items':'أصناف',
          'quantity':'الكمية',
          'my_cart':'سلة التعبئة',
          'total':'الإجمالى',
          'confirm_request':'إتمام الطلب',
          'wait_for_connection':'عند رجوع الاتصال ستعود الصفحة كما كانت',
          'collect_points':'جمع نقاط',
          'win':'واكسب',
          'money':'فلوس',
          'registered':'لدي حساب بالفعل',
          'create_account':'إنشاء حساب جديد',
          'call_support':'للإستفسار اتصل على'
        },
        'en': {
          'language': 'Language',
          'sign_in': 'Sign in',
          'sign_in_header': 'Login to your account',
          'user_email': 'User email',
          'password': 'Password',
          'invalid_login': 'Invalid login',
          'invalid_user': 'Invalid user',
          'or': 'OR',
          'forget_password': 'Forget password',
          'remember_me': 'Remember me',
          'no_account_press_here': 'No account ? Create one',
          'name': 'Name',
          'address': 'Address',
          'phone_number': 'Phone number',
          'delete_account': 'Delete Account',
          'sign_out': 'Sign out',
          'profile_total_money': 'Total Money',
          'profile_total_shipment': 'Total Shipments',
          'currency_rs': 'SR',
          'profile_settings': 'Settings',
          'save': 'Save',
          'update': 'Update',
          'saved_email': 'Email saved successfully',

          //** Empty Data Widget
          'no_data': 'No data',
          'will_display_data_when_available': 'Will display data when available',

          ///**** Welcome Screen ***********
          'start_here': 'Start Here!',
          'line_1': 'Make money',
          'line_2': 'From your wastes!',
          'iam_driver': 'My Tasks',

          ///**** MyOrders Screen ***********
          'my_orders': 'My Orders',
          'points': 'Points',
          'point': 'Point',
          'sr': 'SR',
          'status_open': 'Pending',
          'status_progress': 'On the way',
          'status_complete': 'Successfully',

          ///**** View QR Code Screen ***********
          'go_back': 'Go Back !',
          'shipment_code': 'Shipment QR Code',

          ///**** View QR Code Screen ***********
          'welcome': 'Welcome',
          'confirm': 'Accept',
          'confirmed':'Are you sure ?',
          'cancel':'Cancel',
          'ok':'Ok',

          ///**** Loading Widget ***********
          'loading': 'Loading',
          'please_wait': 'Please wait ...',

          ///**** Settings Page ***********
          'basic_info': 'Basic info',
          'Account & Security': 'Account & Security',
          'User Account': 'User Account',
          'settings_description_1': 'change name, phone, address ..',
          'settings_description_2': 'Change password, Account options, ...',
          'settings_description_3': 'change email account',
          'email_account': 'Email Account',

          ///**** Basic info Widget ***********

          ///**** Account Settings Widget ***********
          'my_account': 'My Account',

          ///**** Main Page ***********
          'browse_all_orders': 'Browse all orders',
          'Press here': 'Press here',
          'you_have': 'You have',
          'welcome': 'Welcome',

          ///**** My Tasks Page ***********
          'my_tasks': 'My Tasks',
          'new_tasks': 'New Tasks',
          'you_have_:': 'You Have : ',
          "BackgroundServiceTitle": 'Tasks',
          "BackgroundServiceBody": 'Check for new tasks and events',
          'app_name': 'Tagmee3',
          'delivered': 'You\'r shipment has been delivered',

          ///**** My notifications Page ***********
          'notifications': 'Notificactions',

          ///**** My Image Page ***********
          'change_image': 'Change your image',
          'save_image': 'Save Image',
          'cancel_image': 'Cancel Image',
          'avatar': 'User avatar',
          'avatar_saved': 'Avatar saved successfully !',
          'user_image':'User Image',

          'delivery_code': 'Delivery Code',
          'main_page':'Main Page',
          'shipment_details':'Shipment Details',
          'code':'Code',
          'error':'Error',
          'connection_error':'Connection Error',
          'item':'Item',
          'items':'Items',
          'quantity':'Quantity',
          'my_cart':'Client Cart',
          'total':'Total',
          'confirm_request':'Confirm Request',
          'wait_for_connection':'Wait for Connection',
          'collect_points':'Collect Points',
          'win':'Win',
          'money':'Money',
          'registered':'Already Registered',
          'create_account':'Create Account',
          'call_support':'Need Help Support',



        },
      };
}
