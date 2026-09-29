import 'package:chefaa/core/services/storage_services.dart';
import 'package:chefaa/features/patient/search/data/data%20source/local/search_doctor_local_ds.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchDoctorLocalDsImp implements SearchDoctorLocalDs {
  final SharedPreferences sharedPreferences;

  SearchDoctorLocalDsImp({required this.sharedPreferences});

  Future<String> _getUserHistoryKey() async {
    final user = await StorageServices.getUser();
    final userId = user?.id ?? 'guest';
    return 'SEARCH_HISTORY_KEY_$userId';
  }

  @override
  Future<List<String>> getSearchHistory() async {
    final key = await _getUserHistoryKey();
    final history = sharedPreferences.getStringList(key);
    return history ?? [];
  }

  @override
  Future<void> saveSearchQuery(String query) async {
    if (query.trim().isEmpty) return;
    final key = await _getUserHistoryKey();
    List<String> history = sharedPreferences.getStringList(key) ?? [];

    history.remove(query);
    history.insert(0, query);

    if (history.length > 10) {
      history = history.sublist(0, 10);
    }

    await sharedPreferences.setStringList(key, history);
  }

  @override
  Future<void> clearSearchHistory() async {
    final key = await _getUserHistoryKey();
    await sharedPreferences.remove(key);
  }

  @override
  Future<void> deleteSearchQuery(String query) async {
    final key = await _getUserHistoryKey();
    List<String> history = sharedPreferences.getStringList(key) ?? [];
    history.remove(query);
    await sharedPreferences.setStringList(key, history);
  }
}
