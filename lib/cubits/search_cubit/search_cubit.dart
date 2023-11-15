import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_db_app/data/models/genre_model.dart';
import 'package:movie_db_app/data/models/search_model.dart';
import 'package:movie_db_app/repo/search/search_repo_impl.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  TextEditingController textEditingController = TextEditingController();
  final SearchRepoImpl _searchRepoImpl = SearchRepoImpl();
  List<Genres> genres = <Genres>[];

  SearchCubit() : super(SearchInitial());

  void getAllGenre() async {
    emit(SearchLoading());
    final response = await _searchRepoImpl.getAllGenre();
    response.fold((l) {
      emit(SearchFailed());
    }, (genreResponse) {
      genres.addAll(genreResponse.genres!);
      emit(SearchInitial());
    });
  }

  searchStart({required String keyword}) async {
    emit(SearchLoading());
    if (keyword.isNotEmpty) {
      final response = await _searchRepoImpl.search(keyword: keyword);
      response.fold((l) {
        emit(SearchFailed());
      }, (r) {
        if (r.totalPages == 0) {
          emit(SearchEmpty());
        } else {
          emit(SearchLoaded(search: r));
        }
      });
    } else {
      emit(SearchInitial());
    }
  }

  clearSearchField() {
    textEditingController.clear();
    emit(SearchInitial());
  }

  String getGenreNameById(int genreId, List<Genres> genresList) {
  for (Genres genre in genresList) {
    if (genre.id == genreId) {
      return genre.name ?? "Unknown Genre";
    }
  }
  return "Unknown Genre";
}
}
