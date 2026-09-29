import 'package:chefaa/features/patient/book/data/model/clinic.dart';
import 'package:chefaa/features/patient/book/domain/usecase/gwt_doctor_clinic_usecase.dart';
import 'package:chefaa/features/patient/book/presentation/cubit/book_state.dart';
import 'package:chefaa/features/patient/search/domain/entity/doctor_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:chefaa/features/patient/book/domain/usecase/book_appo_usecase.dart';
import 'package:chefaa/features/patient/book/domain/usecase/get_slots_usecase.dart';
import 'package:chefaa/features/patient/book/data/model/slot.dart';

class BookCubit extends Cubit<BookState> {
  final GetSlotsUsecase getSlotsUsecase;
  final BookAppoUsecase bookAppoUsecase;
  final GwtDoctorClinicUsecase gwtDoctorClinicUsecase;

  BookCubit({
    required this.getSlotsUsecase,
    required this.bookAppoUsecase,
    required this.gwtDoctorClinicUsecase,
  }) : super(BookingInitialState());

  static BookCubit get(BuildContext context) => BlocProvider.of(context);

  Clinic? selectedClinic;
  DateTime? selectedDay;
  String? selectedDate;
  String? selectedTime;

  List<Clinic> clinics = [];
  List<Slot> slots = [];

  int activeStep = 0;
  final PageController pageController = PageController();

  PaymentMethod? selectedPaymentMethod;

  final GlobalKey<FormState> cardFormKey = GlobalKey<FormState>();

  final cardNumberController = TextEditingController();
  final cardHolderNameController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();

  DoctorEntity? selectedDoctor;

  void selectDoctor(DoctorEntity doctor) {
    selectedDoctor = doctor;

    selectedClinic = null;
    clinics.clear();
    slots.clear();
    selectedDate = null;
    selectedTime = null;
    selectedDay = null;

    getDoctorClinics(doctorId: doctor.id);

    if (!isClosed) emit(ChangeStepState());
  }

  void selectClinic(Clinic clinic) {
    selectedClinic = clinic;
    slots.clear();
    selectedDate = null;
    selectedTime = null;
    selectedDay = null;
    if (!isClosed) emit(ChangeStepState());
  }

  bool get canChooseTime => selectedClinic != null;

  void updateSelectedDate(DateTime date) {
    selectedDay = date;

    final clinicId = selectedClinic?.id;
    if (clinicId == null) return;

    getDaySlots(clinicId: clinicId, date: date);
    if (!isClosed) emit(ChangeStepState());
  }

  void selectDay(DateTime date) {
    updateSelectedDate(date);
  }

  Future<void> getDoctorClinics({required String doctorId}) async {
    if (!isClosed) emit(ClinicsLoadingState());

    final result = await gwtDoctorClinicUsecase(doctorId: doctorId);

    result.fold(
      (failure) {
        if (!isClosed) {
          emit(ClinicsErrorState(error: failure.message));
        }
      },
      (fetchedClinics) {
        clinics = fetchedClinics;
        if (!isClosed) {
          emit(ClinicsSuccessState(clinics: clinics));
        }
      },
    );
  }

  Future<void> getDaySlots({
    required String clinicId,
    required DateTime date,
  }) async {
    if (!isClosed) emit(GetSlotsLoadingState());

    selectedDate = DateFormat('yyyy-MM-dd').format(date);

    final result = await getSlotsUsecase(
      clinicId: clinicId,
      date: selectedDate!,
    );

    result.fold(
      (failure) {
        if (!isClosed) {
          emit(GetSlotsErrorState(failure.message));
        }
      },
      (retrievedSlots) {
        slots = retrievedSlots;
        if (!isClosed) emit(GetSlotsSuccessState(slots));
      },
    );
  }

  void selectTime(String time) {
    selectedTime = time;
    if (!isClosed) emit(TimeSelectedState(time));
  }

  void selectPaymentMethod(PaymentMethod method) {
    selectedPaymentMethod = method;
    if (!isClosed) emit(ChangeStepState());
  }

  bool get needsCard => selectedPaymentMethod == PaymentMethod.creditCard;

  bool onConfirmBookPressed() {
    if (needsCard) {
      return cardFormKey.currentState?.validate() ?? false;
    }
    return true;
  }

  Future<void> bookAppointment({
    required String clinicId,
    required bool isFollowUp,
    required String paymentOption,
    String? cardNumber,
    String? expiryMonth,
    String? expiryYear,
    String? cvv,
    String? cardholderName,
  }) async {
    if (selectedDate == null || selectedTime == null) {
      if (!isClosed) {
        emit(BookingErrorState(error: "Error happened"));
      }
      return;
    }
    if (!isClosed) emit(BookingLoadingState());

    final result = await bookAppoUsecase(
      clinicId: clinicId,
      date: selectedDate!,
      time: selectedTime!,
      isFollowUp: isFollowUp,
      paymentOption: paymentOption,
      paymentStatus: "pending",
      cardNumber: cardNumber,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      cvv: cvv,
      cardholderName: cardholderName,
    );

    result.fold(
      (failure) {
        if (!isClosed) {
          emit(BookingErrorState(error: failure.message));
        }
      },
      (bookModel) {
        if (!isClosed) {
          emit(BookingSuccessState(message: bookModel.message));
        }
      },
    );
  }

  void nextStep() {
    if (activeStep < 3) {
      activeStep++;
      pageController.animateToPage(
        activeStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      if (!isClosed) emit(ChangeStepState());
    }
  }

  void previousStep() {
    if (activeStep > 0) {
      activeStep--;
      pageController.animateToPage(
        activeStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      if (!isClosed) emit(ChangeStepState());
    }
  }

  void goToStep(int index) {
    activeStep = index;
    if (!isClosed) emit(ChangeStepState());
  }

  @override
  Future<void> close() {
    cardNumberController.dispose();
    cardHolderNameController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    pageController.dispose();
    return super.close();
  }
}

enum PaymentMethod { creditCard, cash }
