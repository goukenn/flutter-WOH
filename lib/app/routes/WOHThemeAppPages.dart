// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:get/get.dart' show GetPage, Transition;
import '../modules/auth/views/WOHPolitique.dart';
import '../modules/fidelisation/binding/WOHValidationBiding.dart';
import '../modules/fidelisation/views/WOHAttributePoints.dart';
import '../modules/home/views/WOHEmployeeHome.dart';
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
      page: () => SplashView(),
      binding: AuthBinding(),
    ),
    GetPage(name: WOHRoutes.ROOT, page: () => RootView(), binding: RootBinding()),
    GetPage(
      name: WOHRoutes.RATING,
      page: () => RatingView(),
      binding: RatingBinding(),
    ),
    GetPage(
      name: WOHRoutes.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: WOHRoutes.SETTINGS_ADDRESSES,
      page: () => AddressesView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: WOHRoutes.SETTINGS_THEME_MODE,
      page: () => ThemeModeView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: WOHRoutes.IDENTITY_FILES,
      page: () => AttachmentView(),
      binding: ImportIdentityFilesBinding(),
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
      page: () => AddressPickerView(),
    ),
    GetPage(
      name: WOHRoutes.TRAVEL_INSPECT,
      page: () => InspectView(),
      binding: InspectBinding(),
    ),

    GetPage(
      name: WOHRoutes.CONTACT,
      page: () => ContactWidget(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.INTERFACE_POS,
      page: () => InterfacePOSView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.EMPLOYEE_HOME,
      page: () => EmployeeHomeView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.APPOINTMENT_BOOK,
      page: () => BookingsView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.FIDELITY_CARD,
      page: () => FidelityCardWidget(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.FACTURATION,
      page: () => EmployeeReceipt(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: WOHRoutes.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.CATEGORIES,
      page: () => CategoriesView(),
      binding: CategoryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.VALIDATE_TRANSACTION,
      page: () => AttributionView(),
      binding: ValidationBinding(),
    ),
    GetPage(
      name: WOHRoutes.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: WOHRoutes.REGISTER,
      page: () => RegisterView(),
      binding: AuthBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: WOHRoutes.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: WOHRoutes.VERIFICATION,
      page: () => VerificationView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: WOHRoutes.E_SERVICE,
      page: () => EServiceView(),
      binding: EServiceBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: WOHRoutes.POLITIQUE,
      page: () => Politique(),
      binding: AuthBinding(),
    ),

    //GetPage(name: WOHRoutes.GALLERY, page: () => GalleryView(), binding: GalleryBinding(), transition: Transition.fadeIn),
    GetPage(
      name: WOHRoutes.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WOHRoutes.NOTIFICATION_DETAIL,
      page: () => NotificationDetailsView(),
      binding: NotificationsBinding(),
      transition: Transition.fadeIn,
    ),
    //GetPage(name: WOHRoutes.WALLETS, page: () => WalletsView(), binding: WalletsBinding(), middlewares: [WOHAuthMiddleware()]),
    //GetPage(name: WOHRoutes.WALLET_FORM, page: () => WalletFormView(), binding: WalletsBinding(), middlewares: [WOHAuthMiddleware()]),
  ];
}