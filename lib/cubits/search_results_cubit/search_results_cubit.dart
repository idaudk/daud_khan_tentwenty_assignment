import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_db_app/data/models/upcoming_movies_model.dart';
import 'package:movie_db_app/repo/search/search_repo_impl.dart';

part 'search_results_state.dart';

class SearchResultsCubit extends Cubit<SearchResultsState> {
  int page = 1;
  String totalResults = '0';
  final SearchRepoImpl _searchRepoImpl = SearchRepoImpl();

  SearchResultsCubit() : super(SearchResultsInitial());

  void loadSearch(String keyword) async {
    print('loadSearch called');
    if (state is SearchResultsLoading) return;

    final currentState = state;

    var prevSearchResults = <Results>[];
    if (currentState is SearchResultsLoaded) {
      prevSearchResults = currentState.searchResults;
    }

    emit(SearchResultsLoading(prevSearchResults, isFirstFetch: page == 1));

    await _searchRepoImpl
        .search(keyword: keyword, pageNumber: page)
        .then((value) {
      print(value);
      value.fold((l) {
        emit(SearchResultsFailed());
      }, (newMovies) {
        if (newMovies.totalPages! >= page) {
          page++;
          final movies = (state as SearchResultsLoading).preSearchResults;
          movies.addAll(newMovies.results!);
          totalResults = newMovies.totalResults.toString();
          emit(SearchResultsLoaded(movies));
        }
      });
    });
  }
}
