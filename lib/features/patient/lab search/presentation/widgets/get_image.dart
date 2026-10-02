import 'package:chefaa/features/patient/lab%20search/data/model/center.dart';

extension CenterImageExtension on CenterModel {
  String get imagePath {
    if (facilityType?.toLowerCase() == "lab") {
      return "assets/images/lab_background.jpg";
    } else if (facilityType?.toLowerCase() == "both") {
      return "assets/images/mri.jpg";
    } else {
      return "assets/images/x_ray.jpg";
    }
  }
}