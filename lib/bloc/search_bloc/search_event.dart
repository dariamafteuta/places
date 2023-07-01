abstract class SearchEvent {}

class PerformSearch extends SearchEvent {
  final String searchText;

  PerformSearch(this.searchText);
}
