import 'package:chalet_spot/core/utils/cache_helper.dart';
import 'package:chalet_spot/features/edit_profile/data/repositories/edit_profile_repo.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/data/models/reg_response_model.dart';
import '../../data/data_sources/edit_profile_data_sources.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileDto source;

  TextEditingController nameController;
  TextEditingController emailController;

  final editFormKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  EditProfileCubit(this.source, String initialName, String initialEmail)
      : nameController = TextEditingController(text: initialName),
        emailController = TextEditingController(text: initialEmail),
        super(EditProfileInitial());

  static EditProfileCubit get(context) => BlocProvider.of(context);

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  editProfile() async {
    emit(EditProfileLoading());
    EditProfileRepo editProfileRepo = EditProfileRepo(source);

    var result = await editProfileRepo.editProfile(
      UserModel(
        name: nameController.text,
        email: emailController.text,
      ),
    );
    result.fold((l) {
      emit(EditProfileError(l));
    }, (r) async {
      CacheHelper.saveData(key: 'name', value: nameController.text);
      emit(EditProfileSuccess());
    });
  }

  void saveChangesOnPressed(BuildContext context, Widget content) {
    if (editFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: content,
        ),
      );
      editProfile();
    } else {
      autoValidateMode = AutovalidateMode.always;
      emit(EditUpdatedState());
    }
  }
}
