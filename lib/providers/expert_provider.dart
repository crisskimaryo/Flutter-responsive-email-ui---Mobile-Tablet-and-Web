import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:outlook/exceptions/expert_exception.dart';
import 'package:outlook/models/expert_model.dart';
import 'package:outlook/services/expert_services.dart';

final expertPaginationQueryVal = StateProvider<Map>((ref) => {});

final expertPaginationControllerProvider =
    StateNotifierProvider.autoDispose<ExpertPaginationController>((ref) {
  // final queryVal = ref.watch(ExpertPaginationQueryVal).state;
  // print(queryVal);
  final expertservice = ref.read(expertServiceProvider);
  return ExpertPaginationController(expertservice);
});

class ExpertPaginationController extends StateNotifier<ExpertPagination> {
  ExpertPaginationController(
    this._expertservice, [
    ExpertPagination state,
  ]) : super(state ?? ExpertPagination.initial()) {
    awaitExpertsList();
  }

  final ExpertService _expertservice;

  Future<void> awaitExpertsList() async {
    try {
      state = state.copyWith(isLoading: true);
      List<ExpertModel> experts =
          await _expertservice.awaitExpertsList(state.skip, state.queryVal);

      state = state.copyWith(experts: experts, isLoading: false);
    } on ExpertException catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    }
  }

  Future<void> refreshexperts() async {
    try {
      state = state.copyWith(isLoading: false, isRefreshing: true);
      List<ExpertModel> experts =
          await _expertservice.awaitExpertsList(0, state.queryVal);
      print(experts.length);
      print('refresh ----------------experts.length');
      state = state.copyWith(
          experts: experts.toSet().toList(),
          page: state.page,
          skip: state.skip,
          queryVal: state.queryVal,
          isLoading: false,
          isRefreshing: false);
    } on ExpertException catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
        isRefreshing: false,
        isLoading: false,
      );
    }
  }

  Future<void> searchExperts(queryVal) async {
    try {
      state = state.copyWith(isLoading: true, queryVal: queryVal);
      List<ExpertModel> experts =
          await _expertservice.expertsSearch(state.queryVal);
      print(experts.length);
      print('search ----------------experts.length');
      state = state.copyWith(
          experts: experts.toSet().toList(),
          page: state.page,
          skip: state.skip,
          queryVal: state.queryVal,
          isLoading: false,
          isRefreshing: false);
    } on ExpertException catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
        isRefreshing: false,
        isLoading: false,
      );
    }
  }

  setQueryVal(queryVal) {
    state = state.copyWith(queryVal: queryVal);
    awaitExpertsList();
  }

  Future<void> loadMorePost() async {
    print(state.experts.length);
    print(state.skip);
    print(' ---- check ----');
    print('get data -------------------');
    // state = state.copyWith(page: state.page, );
    try {
      state = state.copyWith(isRefreshing: true, skip: state.experts.length);
      List<ExpertModel> experts = await _expertservice.awaitExpertsList(
          state.experts.length, state.queryVal);
      print(experts);
      print('loadmore  ----------------experts.length');
      state = state.copyWith(
          experts: [...state.experts, ...experts],
          page: state.page,
          queryVal: state.queryVal,
          isLoading: false,
          isRefreshing: false);
    } on ExpertException catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
        isRefreshing: false,
        isLoading: false,
      );
    }
  }
}
