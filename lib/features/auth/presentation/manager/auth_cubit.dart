import 'package:chalet_spot/features/auth/data/data_sources/auth_data_sources.dart';
import 'package:chalet_spot/features/auth/data/models/reg_response_model.dart';
import 'package:chalet_spot/features/auth/data/repositories/auth_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/google_sign_in.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthDataSources sources;

  AuthCubit(this.sources) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  ///--- Register ---///
  TextEditingController nameRegController = TextEditingController();

  TextEditingController userNameRegController = TextEditingController();

  TextEditingController passwordRegController = TextEditingController();
  TextEditingController emailRegController = TextEditingController();

  TextEditingController phoneRegController = TextEditingController();

  TextEditingController cityRegController = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();

  void register(String? firebaseUid, UserModel user) async {
    emit(AuthRegisterLoading());

    AuthRepo authRepo = AuthRepo(sources);

    var result = await authRepo.register(
      UserModel(
        name: user.name ?? nameRegController.text,
        userName: userNameRegController.text,
        password: passwordRegController.text,
        email: user.email ?? emailRegController.text,
        phone: user.phone ?? phoneRegController.text,
        city: selectedValue,
        firebaseUid: firebaseUid,
      ),
    );
    result.fold((l) {
      emit(AuthRegisterError(l));
    }, (r) async {
      emit(AuthRegisterSuccess());
    });
  }

  ///--- Login ---///
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final loginFormKey = GlobalKey<FormState>();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  bool isPasswordSecure = true;

  login() async {
    emit(AuthLoginLoading());
    AuthRepo authRepo = AuthRepo(sources);

    var result = await authRepo.login(
      UserModel(
        userName: userNameController.text,
        password: passwordController.text,
      ),
    );
    result.fold(
      (l) {
        emit(AuthLoginError(l));
      },
      (r) async {
        emit(
          AuthLoginSuccess(
              name: r.name ?? "", token: r.token ?? "", role: r.role!),
        );
      },
    );
  }

  void loginUpOnPressed(BuildContext context, Widget content) {
    if (AuthCubit.get(context).loginFormKey.currentState!.validate()) {
      login();
    } else {
      autoValidateMode = AutovalidateMode.always;
      emit(RegisterUpdatedState());
    }
  }

  ///--- Login With Google ---///
  loginWithGoogle(BuildContext context) async {
    try {
      // Emit loading state
      emit(AuthLoginLoading());

      // Initialize the authentication repository
      AuthRepo authRepo = AuthRepo(sources);

      // Sign in with Google and get the user credential
      UserCredential? userCredential =
          await FirebaseFunctions.signInWithGoogle(context);

      String? idToken;
      if (userCredential?.user != null) {
        // Get the ID token for the signed-in user
        idToken = await userCredential!.user!.getIdToken();
      }

      // Call the loginWithGoogle method from the authentication repository
      var result = await authRepo.loginWithGoogle(idToken ?? "");

      // Handle the result of the login attempt
      result.fold(
        (l) {
          // If additional information is required for first-time login
          if (l.message ==
              "First time login, additional information required") {
            // Set text controllers with user details
            nameRegController.text = userCredential?.user?.displayName ?? "";
            emailRegController.text = userCredential?.user?.email ?? "";
            phoneRegController.text = userCredential?.user?.phoneNumber ?? "";

            // Emit a state indicating that additional information is required
            emit(FirstTimeErrorState(userCredential!.user!.uid));
          } else {
            // Emit an error state with the error message
            emit(AuthLoginError(l));
          }
        },
        (r) async {
          // Emit a success state with user details
          emit(
            AuthLoginSuccess(
              name: r.name ?? "",
              token: r.token ?? "",
              role: r.role ?? "USER",
            ),
          );
        },
      );
    } catch (e) {}
  }

  ///--- Validate ---///

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password'.tr();
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters'.tr();
    }
    return null;
  }

  String? validateGeneral(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required'.tr();
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name'.tr();
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email'.tr();
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email'.tr();
    }
    return null;
  }

  void signUpOnPressed(BuildContext context, Widget content,
      String? firebaseUid, UserModel user) {
    if (registerFormKey.currentState!.validate()) {
      register(firebaseUid, user);
    } else {
      autoValidateMode = AutovalidateMode.always;
      emit(RegisterUpdatedState());
    }
  }

  onPasswordEyeTap() {
    isPasswordSecure = !isPasswordSecure;
    emit(RegisterUpdatedState());
  }

  ///--- City ---///

  final List<String> cities = ["Amman", "Jerash", "Ajloun", "DeadSea", "Aqaba"];

  String selectedValue = "Amman";

  void updateSelectedValue(String? value) {
    selectedValue = value ?? "";
    emit(RegisterUpdatedState());
  }
}
