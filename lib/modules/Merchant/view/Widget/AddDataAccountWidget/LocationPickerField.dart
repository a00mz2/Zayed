import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:zayed/modules/Merchant/controller/ProfileControllerMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';

class LocationPickerField extends StatelessWidget {
  const LocationPickerField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileControllerMerchant>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// الخريطة
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: SizedBox(
            height: 200,
            child: Obx(
              () => FlutterMap(
                mapController: controller.mapController,
                options: MapOptions(
                  initialCenter: controller.selectedLocation.value,
                  initialZoom: 14,
                  onTap: (tapPos, point) {
                    controller.setLocation(point);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: controller.selectedLocation.value,
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),
        Obx(
          () => ButtonAppWidget(
            statusRequest: controller.statusRequestButton.value,
            onPressed: controller.getCurrentLocation,
            icon: Icon(
              Icons.my_location,
              color: Theme.of(context).primaryColor,
            ),
            lable: "تحديد الموقع على الخريطة",
            primaryButton: false,
          ),
        ),
      ],
    );
  }
}
