import 'package:app_agendamento/features/home/pages/home/sections/home_header_section.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'sections/next_schedules/home_next_schedule_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        const HomeHeaderSection(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const HomeNextScheduleSection(),
              const SizedBox(height: 32),
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(37.42796133580664, -122.085749655962),
                  zoom: 14.4746,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
