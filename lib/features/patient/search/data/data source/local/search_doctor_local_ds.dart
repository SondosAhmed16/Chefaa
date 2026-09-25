abstract class SearchDoctorLocalDs {
  Future<List<String>> getSearchHistory();
  Future<void> saveSearchQuery(String query);
  Future<void> clearSearchHistory();
  Future<void> deleteSearchQuery(String query);
}
