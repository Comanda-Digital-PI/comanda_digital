import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/config_controller.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';
import 'package:get/get.dart';

class ConfigScreen extends StatelessWidget {
  ConfigScreen({super.key});

  final ConfigController controller = Get.put(ConfigController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.zero,
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Colors.deepPurpleAccent,
                          Colors.purple,
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.showBottomSheet('mesa', 'Nova Mesa');
                      },
                      highlightColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.event_seat_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Add Mesa',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.zero,
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Colors.deepPurpleAccent,
                          Colors.purple,
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.showBottomSheet('produto', 'Novo Produto');
                      },
                      highlightColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_circle_outline_sharp,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Add Produto',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.zero,
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Colors.deepPurpleAccent,
                          Colors.purple,
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.viewLists);
                      },
                      highlightColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.list_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Listas',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
