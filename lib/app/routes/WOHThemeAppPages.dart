// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:get/get.dart' show GetPage, Transition;
import '../modules/auth/views/WOHPolitique.dart';
import '../modules/fidelisation/binding/WOHValidationBinding.dart';
import '../modules/fidelisation/views/WOHAttributePointsView.dart';
import '../modules/home/views/WOHEmployeeHomeView.dart'; 
import '../modules/home/widgets/WOHContactView.dart';
import '../modules/home/widgets/WOHFidelityCardView.dart';
import '../modules/identity_files/Views/WOHIdentityAttachmentListView.dart';
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
import '../modules/identity_files/Views/WOHImportIdentityFilesFormView.dart';
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
import '../modules/userBookings/views/WOHFacturationView.dart';
import '../modules/userBookings/views/WOHInterfacePOSView.dart';
import 'WOHRoutes.dart';

class WOHThemeAppPages {
  static const INITIAL = WOHRoutes.SPLASH_VIEW;

  static final routes = [
    GetPage(
      name: WOHRoutes.SPLASH_VIEW,
      page: () => WOHSplashView(),
      binding: WOHAuthBinding(),
    ),
    GetPage(
      name: WOHRoutes.ROOT,
      page: () => WOHRootView(),
      binding: WOHRootBinding(),
    ),
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
      page: () => WOHIdentityAttachmentListView(),
      binding: WOHImportIdentityFilesBinding(),
    ),
    GetPage(
      name: WOHRoutes.ADD_IDENTITY_FILES,
      page: () => WOHImportIdentityFilesFormView(),
      binding: WOHImportIdentityFilesBinding(),
    ),
    GetPage(
      name: WOHRoutes.SETTINGS_LANGUAGE,
      page: () => WOHLanguageView(),
      binding: WOHSettingsBinding(),
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
      page: () => WOHContactView(),
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
      page: () => WOHFidelityCardView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.FACTURATION,
      page: () => WOHFacturationView(),
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
      page: () => WOHAttributePointsView(),
      binding: WOHValidationBinding(), //WOHValidationBinding(),
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