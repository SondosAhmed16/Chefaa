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

        return const Center(child: Text('Search for doctors or specialties'));
      },
    );
  }
}
