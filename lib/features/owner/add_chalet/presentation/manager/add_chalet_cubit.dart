import 'dart:developer';

import 'package:chalet_spot/features/owner/add_chalet/data/repositories/add_chalet_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_sources/add_chalet_dto.dart';
import '../../data/models/add_chalet.dart';
import 'add_chalet_state.dart';

class AddChaletCubit extends Cubit<AddChaletState> {
  AddChaletDto source;

  AddChaletCubit(this.source) : super(AddChaletInitial());

  static AddChaletCubit get(context) => BlocProvider.of(context);

  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cityRegControllerController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController videoController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController nightPriceController = TextEditingController();
  TextEditingController dayPriceController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  List<Imgs> imgs = [];

  final TextEditingController imgController = TextEditingController();
  final TextEditingController featureTitleController = TextEditingController();
  final TextEditingController featureDescriptionController =
      TextEditingController();

  final addChaletFormKey = GlobalKey<FormState>();
  final addFeaturesFormKey = GlobalKey<FormState>();

  ///--- City ---///

  final List<String> cities = ["Amman", "Jerash", "Ajloun", "DeadSea", "Aqaba"];

  String selectedCityValue = "Amman";

  void updateSelectedValue(String? value) {
    selectedCityValue = value ?? "";
    emit(AddChaletUpdatedState());
  }

  ///--- Features ---///

  final List<String> featuresList = ["pets", "spa"];
  List<Features> features = [];

  ///--- Multi-choice Options ---///

  void toggleOption(String option) {
    // Check if the feature with the given title exists in the features list
    final featureIndex = features.indexWhere((e) => e.title == option);
    if (featureIndex != -1) {
      // If it exists, remove it
      features.removeAt(featureIndex);
    } else {
      // If it does not exist, add it
      features.add(Features(title: option, discription: ""));
    }
    emit(AddChaletUpdatedState());
  }

  addChalet() async {
    emit(AddChaletLoading());
    AddChaletRepo addChaletRepo = AddChaletRepo(source);

    var response = await addChaletRepo.addChalet(
      AddChalet(
        name: nameController.text,
        description: descriptionController.text,
        priority: 50,
        city: selectedCityValue,
        address: addressController.text,
        video: videoController.text,
        state: stateController.text,
        imgs: imgs,
        features: features,
        prices: [
          Prices(
              stayType: "NightStay",
              price: int.tryParse(nightPriceController.text) ?? 0),
          Prices(
              stayType: "DayStay",
              price: int.tryParse(nightPriceController.text) ?? 0),
        ],
      ),
    );
    response.fold((l) {
      log('chalet error ${1.toString()}');
      emit(AddChaletError(l));
    }, (r) {
      log('chalet successfully added');
      emit(AddChaletSuccess(r.toString()));
    });
  }

  void addChaletOnPressed(BuildContext context, Widget content) {
    if (addChaletFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: content,
        ),
      );
      addChalet();
    } else {
      autoValidateMode = AutovalidateMode.always;
      emit(AddChaletUpdatedState());
    }
  }

  void addImage() {
    if (imgController.text.isNotEmpty) {
      imgs.add(Imgs(img: imgController.text));
      imgController.clear();
      emit(AddChaletUpdatedState());
    }
  }

  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a number';
    }
    final number = int.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    return null;
  }
}
