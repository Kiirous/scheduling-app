import 'package:app_agendamento/core/device/app_location.dart';
import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_loading_indicator.dart';
import 'package:app_agendamento/core/widgets/base/app_stateful.dart';
import 'package:app_agendamento/features/home/pages/home/sections/home_map/home_map_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeMapSection extends StatefulWidget {
  const HomeMapSection({super.key});

  @override
  State<HomeMapSection> createState() => _HomeMapSectionState();
}

class _HomeMapSectionState extends AppState<HomeMapSection> {
  GoogleMapController? _controller;

  final HomeMapCubit cubit = HomeMapCubit();

  @override
  void initState() {
    super.initState();
    cubit.loadUserLocation();
  }

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return BlocProvider.value(
      value: cubit,
      child: AspectRatio(
        aspectRatio: 1,
        child: BlocBuilder<HomeMapCubit, HomeMapState>(
          builder: (context, state) {
            if (state.locationStatus == null || state.userLocation == null) {
              return const Center(child: AppLoadingIndicator());
            } else if (state.locationStatus != AppLocationStatus.allowed) {
              return const Text('Localização não permitida');
            } else {
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(target: state.userLocation!.toLatLng(), zoom: 14.4746),
                onMapCreated: (GoogleMapController controller) async {
                  _controller = controller;
                  final region = await _controller!.getVisibleRegion();
                  final midleLat = (region.northeast.latitude + region.southwest.latitude) / 2;
                },
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
