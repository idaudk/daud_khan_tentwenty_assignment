part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {
}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  Search search;
  SearchLoaded({required this.search});
}

final class SearchEmpty extends SearchState {}

final class SearchFailed extends SearchState {}
