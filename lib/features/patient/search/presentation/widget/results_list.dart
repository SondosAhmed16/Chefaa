import 'package:chefaa/features/patient/search/presentation/cubit/search_doctor_cubit.dart';
import 'package:chefaa/features/patient/search/presentation/cubit/search_doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_card.dart';

class ResultsList extends StatelessWidget {
  const ResultsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchDoctorCubit, SearchDoctorState>(
      builder: (context, state) {
        if (state is SearchDoctorLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SearchHistoryLoadedState ||
            state is SearchDoctorInitialState) {
          final history = context.read<SearchDoctorCubit>().searchHistory;

          if (history.isEmpty) {
            return const Center(
              child: Text(
                'No recent searches',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Recent Searches',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final item = history[index];
                    return ListTile(
                      leading: const Icon(Icons.history, color: Colors.grey),
                      title: Text(item),
                      trailing: const Icon(Icons.north_west, size: 16),
                      onTap: () {
                        context.read<SearchDoctorCubit>().searchDoctors(
                          searchText: item,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }

        if (state is SearchDoctorErrorState) {
          return Center(child: Text(state.errorModel.message));
        }

        if (state is SearchDoctorSuccessState) {
          final doctors = state.doctors;
          if (doctors.isEmpty) {
            return const Center(child: Text('No doctors found'));
          }

          return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: doctors.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return SearchCard(doctor: doctors[index]);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
