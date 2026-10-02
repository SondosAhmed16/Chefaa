import 'dart:async';

import 'package:chefaa/core/di/injection_container.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/features/patient/lab%20search/data/model/center.dart';
import 'package:chefaa/features/patient/lab%20search/presentation/cubit/lab_search_cubit.dart';
import 'package:chefaa/features/patient/lab%20search/presentation/cubit/lab_search_state.dart';
import 'package:chefaa/features/patient/lab%20search/presentation/widgets/filter_items.dart';
import 'package:chefaa/features/patient/lab%20search/presentation/widgets/lab_details.dart';
import 'package:chefaa/features/patient/lab%20search/presentation/widgets/lab_search_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindLab extends StatefulWidget {
  const FindLab({super.key});

  @override
  State<FindLab> createState() => _FindLabState();
}

class _FindLabState extends State<FindLab> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilterIndex = 0;
  Timer? _debounce;

  GoogleMapController? _mapController;
  final bool _canShowMyLocation = true;
  LatLng? _currentPosition;
  final LatLng _fallbackPosition = const LatLng(29.9602, 31.2569);
  Set<Marker> _markers = {};
  BitmapDescriptor? _customIcon;

  final List<String> _filters = ["All", "Lab only", "Radiology", "Home scan"];

  @override
  void dispose() {
    _searchController.dispose();
    _mapController?.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _triggerSearch();
    });
  }

  void _triggerSearch() {
    context.read<LabSearchCubit>().serachLAb(
      requiredServices: _searchController.text.trim().isNotEmpty
          ? _searchController.text.trim()
          : null,
      homeService: _selectedFilterIndex == 3 ? true : null,
    );
  }

  List<CenterModel> _getFilteredCenters(List<CenterModel> originalCenters) {
    var list = originalCenters;
    if (_selectedFilterIndex == 1) {
      list = list.where((c) => c.facilityType?.toLowerCase() == 'lab').toList();
    } else if (_selectedFilterIndex == 2) {
      list = list
          .where(
            (c) =>
                c.facilityType?.toLowerCase() == 'scan' ||
                c.facilityType?.toLowerCase() == 'both',
          )
          .toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LabSearchCubit>()..serachLAb(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(175),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              left: 16,
              right: 16,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 20,
                        color: ColorManager.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Find Lab",
                      style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Search for Lab / Service You want",
                    style: getMediumStyle(
                      color: ColorManager.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: _searchController,
                    text: "Search LAb , Radiology or Services",
                    prefixIcon: "assets/icons/search-normal.svg",
                    isSearch: true,
                    onChanged: _onSearchChanged,
                  ),
                  const SizedBox(height: 20),
                  _buildFilterList(),
                  const SizedBox(height: 20),
                  BlocBuilder<LabSearchCubit, LabSearchState>(
                    builder: (context, state) {
                      if (state is LabSearchLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.primary,
                          ),
                        );
                      } else if (state is LabSearchErrorState) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.error.message,
                                style: getBoldStyle(
                                  color: ColorManager.error,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<LabSearchCubit>().serachLAb();
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      } else if (state is LabSearchSuccessState) {
                        final filteredCenters = _getFilteredCenters(state.centers);

                        if (filteredCenters.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32),
                              child: Text(
                                "No Centers Yet",
                                style: getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildMapSection(filteredCenters.length),
                            const SizedBox(height: 20),
                            _buildSectionHeader(),
                            const SizedBox(height: 16),
                            _buildRecommendedList(filteredCenters),
                          ],
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterList() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return FilterItems(
            label: _filters[index],
            isSelected: _selectedFilterIndex == index,
            onTap: () {
              setState(() {
                _selectedFilterIndex = index;
              });
              _triggerSearchWithContext(context);
            },
          );
        },
      ),
    );
  }

  void _triggerSearchWithContext(BuildContext context) {
    context.read<LabSearchCubit>().serachLAb(
      requiredServices: _searchController.text.trim().isNotEmpty
          ? _searchController.text.trim()
          : null,
      homeService: _selectedFilterIndex == 3 ? true : null,
    );
  }

  Widget _buildMapSection(int centersCount) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.input, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: _canShowMyLocation,
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _currentPosition ?? _fallbackPosition,
              zoom: 14,
            ),
            markers: _markers,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
            onTap: (LatLng position) {
              setState(() {
                _currentPosition = position;
                _markers = {
                  Marker(
                    markerId: const MarkerId("selected"),
                    position: position,
                    icon: _customIcon ?? BitmapDescriptor.defaultMarker,
                  ),
                };
              });
              _mapController?.animateCamera(CameraUpdate.newLatLng(position));
            },
          ),
          PositionedDirectional(
            bottom: 12,
            start: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorManager.input, width: 1),
              ),
              child: Text(
                "$centersCount Centers found in Maadi",
                style: getMediumStyle(color: ColorManager.black, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "AI Recommended",
          style: getBoldStyle(color: ColorManager.black, fontSize: 20),
        ),
        Text(
          "Sort by: Relevance",
          style: getSemiBoldStyle(color: ColorManager.primary, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildRecommendedList(List<CenterModel> centers) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: centers.length,
      itemBuilder: (context, index) {
        return LabSearchCard(
          center: centers[index],
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => LabDetails(center: centers[index]),
            );
          },
        );
      },
    );
  }
}