import 'package:chefaa/core/DI/injection_container.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/book/presentation/cubit/book_cubit.dart';
import 'package:chefaa/features/patient/book/presentation/cubit/book_state.dart';
import 'package:chefaa/features/patient/book/presentation/pages/choose_clinics_page.dart';
import 'package:chefaa/features/patient/book/presentation/pages/choose_time_page.dart';
import 'package:chefaa/features/patient/book/presentation/pages/confirm_page.dart';
import 'package:chefaa/features/patient/book/presentation/pages/search_doctor_page.dart';
import 'package:chefaa/features/patient/book/presentation/widget/steps.dart';
import 'package:chefaa/features/patient/search/presentation/cubit/search_doctor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingAllPages extends StatelessWidget {
  const BookingAllPages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(
      buildWhen: (previous, current) =>
          current is ChangeStepState || current is BookingInitialState,

      builder: (context, state) {
        final cubit = context.read<BookCubit>();
        final doctor = cubit.selectedDoctor;
        final allPAges = [
          BlocProvider(
            create: (context) => getIt<SearchDoctorCubit>()..getSearchHistory(),
            child: const SearchDoctorPage(),
          ),
          ChooseClinicsPage(
            doctorId: doctor?.id ?? '',
            doctorName: doctor?.name ?? '',
            doctorSpecialization: doctor?.specialization ?? '',
            doctorRating: (doctor?.rating ?? 0.0).toDouble(),
            doctor: doctor,
          ),
          ChooseTimePage(),
          ConfirmPage(),
        ];

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
              MediaQuery.of(context).size.height * 0.17,
            ),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ColorManager.lightGray,
              elevation: 0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        cubit.previousStep();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: ColorManager.black,
                          size: 20,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    Text(
                      'Book Appointment',
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Steps(activeStep: cubit.activeStep, totalSteps: 5),
                  ],
                ),
              ),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
            ),
          ),

          body: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: cubit.pageController,
                  itemCount: allPAges.length,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: cubit.goToStep,
                  itemBuilder: (context, index) => allPAges[index],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
