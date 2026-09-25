import 'package:chefaa/features/patient/search/data/data%20source/local/search_doctor_local_ds.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchDoctorLocalDsImp implements SearchDoctorLocalDs{

  final SharedPreferences sharedPreferences;
  static const String _historyKey = 'SEARCH_HISTORY_KEY';

  SearchDoctorLocalDsImp({required this.sharedPreferences});

  @override
  Future<List<String>> getSearchHistory() async {
    final history = sharedPreferences.getStringList(_historyKey);
    return history ?? [];
  }

  @override
  Future<void> saveSearchQuery(String query) async {
    List<String> history = sharedPreferences.getStringList(_historyKey) ?? [];
    
    history.remove(query);
    history.insert(0, query);

    if (history.length > 10) {
      history = history.sublist(0, 10);
    }

    await sharedPreferences.setStringList(_historyKey, history);
  }

  @override
  Future<void> clearSearchHistory() async {
    await sharedPreferences.remove(_historyKey);
  }

  @override
  Future<void> deleteSearchQuery(String query) async {
    List<String> history = sharedPreferences.getStringList(_historyKey) ?? [];
    history.remove(query);
    await sharedPreferences.setStringList(_historyKey, history);
  }
}