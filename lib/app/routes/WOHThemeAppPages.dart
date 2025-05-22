// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:get/get.dart' show GetPage, Transition;
import '../modules/auth/views/WOHPolitique.dart';
import '../modules/fidelisation/binding/WOHValidationBiding.dart';
import '../modules/fidelisation/views/WOHAttributePoints.dart';
import '../modules/home/views/WOHEmployeeHomeView.dart';
import '../modules/home/widgets/WOHContactView.dart';
import '../modules/home/widgets/WOHFidelityCardView.dart';
import '../modules/identity_files/Views/WOHAttachmentList.dart';
import '../modules/auth/bindings/WOHAuthBinding.dart';
import '../modules/auth/views/WOHForgotPasswordView.dart';
import '../modules/auth/views/WOHLoginView.dart';
import '../modules/auth/views/WOHRegisterView.dart';
import '../modules/auth/views/WOHSplashView.dart';
import '../modules/auth/views/WOHVerificationView.dart';
import '../modules/category/bindings/WOHCategoryBinding.dart';
import '../modules/category/views/WOHCategoriesView.dart';
import '../modules/e_service/bindings/WOHEServiceBinding.dart';
import '../modules/e_service/views/WOHEServiceView.dart';
import '../modules/identity_files/Views/WOHImportIdentityFilesForm.dart';
import '../modules/identity_files/binding/WOHImportIdentityFilesBinding.dart';
import '../modules/notifications/bindings/WOHNotificationsBinding.dart';
import '../modules/notifications/views/WOHNotificationDetails.dart';
import '../modules/notifications/views/WOHNotificationsView.dart';
import '../modules/profile/bindings/WOHProfileBinding.dart';
import '../modules/profile/views/WOHProfileView.dart';
import '../modules/rating/bindings/WOHRatingBinding.dart';
import '../modules/rating/views/WOHRatingView.dart';
import '../modules/root/bindings/WOHRootBinding.dart';
import '../modules/root/views/WOHRootView.dart';
import '../modules/settings/bindings/WOHSettingsBinding.dart';
import '../modules/settings/views/WOHAddressPickerView.dart';
import '../modules/settings/views/WOHAddressesView.dart';
import '../modules/settings/views/WOHLanguageView.dart';
import '../modules/settings/views/WOHSettingsView.dart';
import '../modules/settings/views/WOHThemeModeView.dart';
import '../modules/inspect/bindings/WOHInspectBinding.dart';
import '../modules/inspect/views/WOHInspectView.dart';
import '../modules/userBookings/views/WOHBookingsView.dart';
import '../modules/userBookings/views/WOHFacturation.dart';
import '../modules/userBookings/views/WOHInterfacePOS.dart';
import 'WOHRoutes.dart';

class WOHThemeAppPages {
  static const INITIAL = WOHRoutes.SPLASH_VIEW;

  static final routes = [
    GetPage(
      name: WOHRoutes.SPLASH_VIEW,
      page: () => WOHSplashView(),
      binding: WOHAuthBinding(),
    ),
    GetPage(name: WOHRoutes.ROOT, page: () => WOHRootView(), binding: WOHRootBinding()),
    GetPage(
      name: WOHRoutes.RATING,
      page: () => WOHRatingView(),
      binding: WOHRatingBinding(),
    ),
    GetPage(
      name: WOHRoutes.SETTINGS,
      page: () => WOHSettingsView(),
      binding: WOHSettingsBinding(),
    ),
    GetPage(
      name: WOHRoutes.SETTINGS_ADDRESSES,
      page: () => WOHAddressesView(),
      binding: WOHSettingsBinding(),
    ),
    GetPage(
      name: WOHRoutes.SETTINGS_THEME_MODE,
      page: () => WOHThemeModeView(),
      binding: WOHSettingsBinding(),
    ),
    GetPage(
      name: WOHRoutes.IDENTITY_FILES,
      page: () => WOHAttachmentView(),
      binding: WOHImportIdentityFilesBinding(),
    ),
    GetPage(
      name: WOHRoutes.ADD_IDENTITY_FILES,
      page: () => ImportIdentityFilesView(),
      binding: ImportIdentityFilesBinding(),
    ),
    GetPage(
      name: WOHRoutes.SETTINGS_LANGUAGE,
      page: () => LanguageView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: WOHRoutes.SETTINGS_ADDRESS_PICKER,
      page: () => WOHAddressPickerView(),
    ),
    GetPage(
      name: WOHRoutes.TRAVEL_INSPECT,
      page: () => WOHInspectView(),
      binding: WOHInspectBinding(),
    ),

    GetPage(
      name: WOHRoutes.CONTACT,
      page: () => WOHContactWidget(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.INTERFACE_POS,
      page: () => WOHInterfacePOSView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.EMPLOYEE_HOME,
      page: () => WOHEmployeeHomeView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.APPOINTMENT_BOOK,
      page: () => WOHBookingsView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.FIDELITY_CARD,
      page: () => WOHFidelityCardWidget(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.FACTURATION,
      page: () => WOHEmployeeReceipt(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: WOHRoutes.PROFILE,
      page: () => WOHProfileView(),
      binding: WOHProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.CATEGORIES,
      page: () => WOHCategoriesView(),
      binding: WOHCategoryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.VALIDATE_TRANSACTION,
      page: () => WOHAttributionView(),
      binding: WOHValidationBinding(),
    ),
    GetPage(
      name: WOHRoutes.LOGIN,
      page: () => WOHLoginView(),
      binding: WOHAuthBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: WOHRoutes.REGISTER,
      page: () => WOHRegisterView(),
      binding: WOHAuthBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: WOHRoutes.FORGOT_PASSWORD,
      page: () => WOHForgotPasswordView(),
      binding: WOHAuthBinding(),
    ),
    GetPage(
      name: WOHRoutes.VERIFICATION,
      page: () => WOHVerificationView(),
      binding: WOHAuthBinding(),
    ),
    GetPage(
      name: WOHRoutes.E_SERVICE,
      page: () => WOHEServiceView(),
      binding: WOHEServiceBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: WOHRoutes.POLITIQUE,
      page: () => WOHPolitique(),
      binding: WOHAuthBinding(),
    ),

    //GetPage(name: WOHRoutes.GALLERY, page: () => GalleryView(), binding: GalleryBinding(), transition: Transition.fadeIn),
    GetPage(
      name: WOHRoutes.NOTIFICATIONS,
      page: () => WOHNotificationsView(),
      binding: WOHNotificationsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.NOTIFICATION_DETAIL,
      page: () => WOHNotificationDetails(),
      binding: WOHNotificationsBinding(),
      transition: Transition.fadeIn,
    ),
    //GetPage(name: WOHRoutes.WALLETS, page: () => WalletsView(), binding: WalletsBinding(), middlewares: [WOHAuthMiddleware()]),
    //GetPage(name: WOHRoutes.WALLET_FORM, page: () => WalletFormView(), binding: WalletsBinding(), middlewares: [WOHAuthMiddleware()]),
  ];
}