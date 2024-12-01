import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/services/device_info/device_info_service.dart';
import '../../../../core/theme/extension.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final deviceInfoService = GetIt.I<DeviceInfoService>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.theme.primaryColor,
            ),
            child: const Text(
              "Marvel Characters",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Device Info:',
                  style: context.theme.textTheme.headlineSmall,
                ),
                FutureBuilder<String>(
                  future: deviceInfoService.getDeviceInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return Text(snapshot.data ?? '');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
