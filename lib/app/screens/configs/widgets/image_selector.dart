import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/config_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatelessWidget {
  const ImageSelector({
    super.key,
    required this.controller
  });

  final ConfigController controller;

  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Imagem',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white
              ),
              onPressed: () {
                // Exibe um action sheet para escolher entre câmera e galeria
                Get.bottomSheet(
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text('Galeria'),
                          onTap: () {
                            Get.back(); // fecha o action sheet
                            controller.pickImage(ImageSource.gallery);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text('Câmera'),
                          onTap: () {
                            Get.back();
                            controller.pickImage(ImageSource.camera);
                          },
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                );
              },
              icon: const Icon(
                Icons.image,
                color: Colors.deepPurpleAccent,
              ),
              label: const Text(
                'Selecionar Imagem',
                style: TextStyle(
                  color: Colors.deepPurpleAccent
                ), 
              ),
              iconAlignment: IconAlignment.end,
            ),
            const SizedBox(width: 12),
            // Exibe uma prévia da imagem se ela estiver selecionada
            Obx(() {
              if (controller.imageFile.value != null) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    controller.imageFile.value!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                );
              } else {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.image, color: Colors.grey),
                );
              }
            }),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
  
}