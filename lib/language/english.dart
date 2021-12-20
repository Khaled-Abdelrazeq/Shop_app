import 'languages.dart';

class EnglishLanguage extends Languages {
  @override
  Map<String, String> settingsMap = {
    'update': 'Update',
    'instruction': 'Instruction',
    'dark': 'Dark Mode',
    'light': 'Light Mode',
    'lang': 'English',
    'logout': 'Logout',
    'username': 'Username',
    'email': 'Email',
    'phone': 'Phone',
    'emailValidation': 'Email Can\'t be empty!',
    'phoneValidation': 'Phone Can\'t be empty!',
    'nameValidation': 'Username Can\'t be empty!',
  };

  @override
  Map<String, String> productsMap = {
    'categories': 'Categories',
    'mostSales': 'Most Sales',
  };

  @override
  Map<String, String> homeMap = {
    'categoriesTitle': 'Categories',
    'productsTitle': 'Products',
    'favouritesTitle': 'Favorites',
    'settingsTitle': 'Settings',
  };

  @override
  Map<String, String> detailsMap = {
    'title': 'Details',
    'price': 'Price:',
    'name': 'Name:',
    'description': 'Description:',
    'discount': 'Discount:',
  };

  @override
  Map<String, String> loginMap = {
    'loginTextTitle': 'Login into ShopApp',
    'emailValidation': 'Please, enter your email',
    'passwordValidation': 'Please, enter your password',
    'buttonTextLogin': 'Login',
    'donotHaveAccount': 'Don\'t have an account?',
    'signUpText': 'Registration',
    'forgetPassword': 'Forget Password?',
    'email': 'Email',
    'password': 'Password',
  };

  @override
  Map<String, String> registerMap = {
    'registerTitle': 'Register to ShopApp',
    'nameValidation': 'Name can\'t be empty!',
    'emailValidation': 'Email can\'t be empty!',
    'passwordValidation': 'Password can\'t be empty!',
    'repeatPasswordValidation': 'Confirm password can\'t be empty!',
    'repeatPasswordValidation2': 'Confirm Password did\'t match to password',
    'phoneValidation': 'Phone can\'t be empty!',
    'email': 'Email',
    'password': 'Password',
    'username': 'Username',
    'confirmPassword': 'Confirm Password',
    'phone': 'Phone',
    'registerButton': 'Register',
    'loginBtn': 'Login',
    'alreadyHaveAccount': 'Already have an account?',
  };

  @override
  Map<String, String> onBoardingMap = {
    'finish': 'Finish',
    'next': 'Next',
    'skip': 'Skip',
    'title1_1': 'Online',
    'title1_2': 'Shopping',
    'title2_1': 'Add-To',
    'title2_2': 'Cart',
    'title3_1': 'Payment',
    'title3_2': 'Online',
    'title4_1': 'Order',
    'title4_2': 'Deliverd',
    'body':
        'Its long establish fact that a reader will be distracted by the readable content.',
  };

  @override
  Map<String, String> forgetPasswordMap = {
    'title': 'Reset Password',
    'validationEmail': 'Email can\'t be empty!',
    'validationCode': 'Code can\'t be empty!',
    'validationPassword': 'Password can\'t be empty!',
    'emailText': 'Email',
    'getCode': 'Get Code',
    'gotoLogin': 'Goto Login',
    'sendCodeAgain': 'Send code again',
    'resetPassword': 'Reset Password',
    'newPasswordText': 'New Password',
    'codeText': 'Code',
  };

  @override
  Map<String, String> searchMap = {
    'title': 'Search',
  };
}
