part of 'search_results_cubit.dart';

sealed class SearchResultsState extends Equatable {
  const SearchResultsState();

  @override
  List<Object> get props => [];
}

final class SearchResultsInitial extends SearchResultsState {}


final class SearchResultsLoading extends SearchResultsState {
  final List<Results> preSearchResults;
  final bool isFirstFetch;
  SearchResultsLoading(this.preSearchResults, {this.isFirstFetch = false});
}

final class SearchResultsLoaded extends SearchResultsState {
  List<Results> searchResults;
  SearchResultsLoaded(this.searchResults);
}

final class SearchResultsFailed extends SearchResultsState {}
