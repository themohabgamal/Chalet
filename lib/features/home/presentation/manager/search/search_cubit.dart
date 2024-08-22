import 'package:chalet_spot/features/home/data/repositories/search_repo.dart';
import 'package:chalet_spot/features/home/presentation/manager/search/search_state.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_sources/search_data_sources.dart';
import '../../../data/models/chalet_model_response.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchDto source;

  SearchCubit(this.source) : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  final List<String> cities = [
    "الكل",
    "Amman",
    "Jerash",
    "Ajloun",
    "DeadSea",
    "Aqaba"
  ];

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  List<ChaletModel> chalets = [];
  List<ChaletModel> filteredChalets = [];

  ///--- Search ---///
  bool isSearch = false;
  TextEditingController searchTextEditingController = TextEditingController();

  getAllChalets() async {
    emit(SearchGetAllChaletsLoading());
    SearchRepo searchRepo = SearchRepo(source);

    var result = await searchRepo.getChalets();

    result.fold((l) {
      emit(SearchGetAllChaletsError(l));
    }, (r) async {
      chalets = r.chalets;
      emit(
        SearchGetAllChaletsSuccess(),
      );
    });
  }

  getSearchProduct(String value) {
    emit(GetFilterChaletsLoading());
    searchTextEditingController.text.isEmpty
        ? isSearch = false
        : isSearch = true;
    value == 'الكل'
        ? filteredChalets = chalets
        : filteredChalets = chalets
            .where((element) =>
                element.name.toLowerCase().startsWith(value) ||
                element.name.startsWith(value) ||
                element.city.toLowerCase().startsWith(selectedValue ?? value) ||
                element.city == value)
            .toList();

    filteredChalets.isEmpty
        ? value.isNotEmpty
            ? emit(NotFoundFilterChalets())
            : emit(SearchGetAllChaletsSuccess())
        : emit(GetFilterChaletsSuccess());
  }

  selectValue(value) {
    selectedValue = value;
    getSearchProduct(value);
  }
}
