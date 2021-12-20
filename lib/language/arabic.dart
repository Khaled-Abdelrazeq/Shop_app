import 'languages.dart';

class ArabicLanguage extends Languages {
  @override
  Map<String, String> settingsMap = {
    'update': 'تحديث',
    'instruction': 'تعليمات',
    'dark': 'وضع ليلي',
    'light': 'وضع نهاري',
    'lang': 'اللغه العربيه',
    'logout': 'تسجيل الخروج',
    'username': 'اسم المستخدم',
    'email': 'البريد الإلكتروني',
    'phone': 'رقم الهاثف',
    'emailValidation': 'حقل البريد لا يمكن أن يكون فارغ',
    'phoneValidation': 'حقل الهاتف لا يمكن أن يكون فارغ',
    'nameValidation': 'اسم المستخدم لا يمكن أن يكون فارغ',
  };

  @override
  Map<String, String> productsMap = {
    'categories': 'الأصناف',
    'mostSales': 'الأكثر مبيعاً',
  };

  @override
  Map<String, String> homeMap = {
    'categoriesTitle': 'الأصناف',
    'productsTitle': 'المنتجات',
    'favouritesTitle': 'المفضلة',
    'settingsTitle': 'الإعدادات',
  };

  @override
  Map<String, String> detailsMap = {
    'title': 'التفاصيل',
    'price': 'السعر:',
    'name': 'الإسم:',
    'description': 'المواصفات:',
    'discount': 'الخصم:',
  };

  @override
  Map<String, String> loginMap = {
    'loginTextTitle': 'تسجيل الدخول للتطبيق',
    'emailValidation': 'من فضلك أدخل بريدك الإلكتروني',
    'passwordValidation': 'من فضلك أدخل رقمك السري',
    'buttonTextLogin': 'تسجيل الدخول',
    'donotHaveAccount': 'ليس لديك حساب؟',
    'signUpText': 'الإشتراك',
    'forgetPassword': 'نسيت كلمة المرور؟',
    'email': 'البريد الإلكتروني',
    'password': 'كلمة المرور',
  };

  @override
  Map<String, String> registerMap = {
    'registerTitle': 'إنشاء حساب',
    'nameValidation': 'إسم المستخدم لا يمكن أن يكون فارغ',
    'emailValidation': 'البريد الإلكتروني لا يمكن أن يكون فارغ',
    'passwordValidation': 'كلمة المرور لا يمكن أن تكون فارغه',
    'repeatPasswordValidation': 'تأكيد كلمة المرور لا يمكن أن تكون فارغه',
    'repeatPasswordValidation2': 'تأكيد كلمة المرور ليست مطابقة لكلمة المرور',
    'phoneValidation': 'رقم الهاتف لا يمكن أن يكون فارغ',
    'email': 'البريد الإلكتروني',
    'password': 'كلمة المرور',
    'username': 'إسم المتسخدم',
    'confirmPassword': 'تأكيد كلمة المرور',
    'phone': 'رقم الهاتف',
    'registerButton': 'الإشتراك',
    'loginBtn': 'تسجيل الدخول',
    'alreadyHaveAccount': 'لديك حساب بالفعل؟',
  };

  @override
  Map<String, String> onBoardingMap = {
    'finish': 'إنهاء',
    'next': 'التالي',
    'skip': 'تخطي',
    'title1_1': 'التسوق',
    'title1_2': 'عبر الإنترنت',
    'title2_1': 'إضافه إلي',
    'title2_2': 'السله',
    'title3_1': 'إدفع',
    'title3_2': 'عبر الإنترنت',
    'title4_1': 'التوصيل',
    'title4_2': 'للمنزل',
    'body':
        'لقد أثبتت حقيقة أن المحتوى المقروء سيلهي القارئ عن التركيز لفترة طويلة.',
  };

  @override
  Map<String, String> forgetPasswordMap = {
    'title': 'إعادة تعيين كلمة المرور',
    'validationEmail': 'البريد الإلكتروني لا يمكن أن يكون فارغ',
    'validationCode': 'الرمز لا يمكن أن يكون فارغ',
    'validationPassword': 'كلمة المرور لا يمكن أن تكون فارغه',
    'emailText': 'البريد الإلكتروني',
    'getCode': 'الحصول على الرمز',
    'gotoLogin': 'الذهاب إلى صفحة التسجيل',
    'sendCodeAgain': 'إرسال الرمز مرة أخرى',
    'resetPassword': 'إعادة تعيين كلمة المرور',
    'newPasswordText': 'كلمة مرور جديدة',
    'codeText': 'الرمز',
  };

  @override
  Map<String, String> searchMap = {
    'title': 'بحث',
  };
}
