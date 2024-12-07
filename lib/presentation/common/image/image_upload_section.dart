import 'dart:typed_data';

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:spacefinder/l10n/app_l18.dart';
import 'package:spacefinder/presentation/common/image/selected_image_w.dart';

class ImageUploadSection extends StatefulWidget {
  ImageUploadSection({
    super.key,
    required this.onSelectImage,
    this.supportedFiles = const ["PNG", "JPG"],
    this.minImages,
    this.maxImages,
    this.maxSize,
    this.otherNote,
  });

  final Function(Uint8List path) onSelectImage;
  final List<String> supportedFiles;
  final int? minImages;
  final int? maxImages;
  final int? maxSize;
  final String? otherNote;

  @override
  State<StatefulWidget> createState() => _ImageUploadSectionState();
}

class _ImageUploadSectionState extends State<ImageUploadSection> {
  final selectedImages = RxList<Uint8List>();
  final selectedFileNames = RxList<String>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black.withOpacity(0.15)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cloud_upload_outlined,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(Ln.i?.postIdropAndDragImage ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                    )),
                const SizedBox(height: 8),
                const Text('hoặc',
                    style: TextStyle(fontSize: 14, color: Color(0xff93939B))),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      final isPdf = widget.supportedFiles.length == 1 &&
                          widget.supportedFiles.contains('PDF');
                      final hasPdf = widget.supportedFiles.contains('PDF');

                      FilePickerResult? result = await FilePickerWeb.platform
                          .pickFiles(
                              type: !isPdf && hasPdf
                                  ? FileType.any
                                  : FileType.custom,
                              allowedExtensions: isPdf
                                  ? ['pdf']
                                  : (!hasPdf ? ['png', 'jpeg', 'jpg'] : ['']));
                      final path = result?.files.single.bytes;
                      widget.onSelectImage.call(path!);

                      selectedImages.add(path);
                      selectedFileNames.add(result?.files.single.name ?? '--');
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff287098),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      Ln.i?.postIuploadFromDevice ?? '',
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ).paddingSymmetric(horizontal: 24, vertical: 8),
                  ),
                )
              ],
            ).paddingSymmetric(vertical: 24),
          ),
          const SizedBox(height: 8),
          Text(
              (Ln.i?.postIimageUploadDesc ?? '')
                  .replaceAll("%s", widget.supportedFiles.join(", ")),
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff93939B),
              )),
          if (widget.minImages != null)
            Text('Đăng tối thiểu ${widget.minImages} tệp',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff93939B),
                )),
          if (widget.maxImages != null)
            Text('Đăng tối đa ${widget.minImages} tệp',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff93939B),
                )),
          if (widget.otherNote != null)
            Text(widget.otherNote ?? '',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff93939B),
                )),
          const SizedBox(height: 8),
          if (selectedImages.isNotEmpty)
            ...selectedImages.mapIndexed((index, e) => SelectedImageWidget(
                  path: e,
                  name: selectedFileNames[index],
                  onDelete: () {
                    selectedImages.remove(e);
                  },
                ).paddingOnly(bottom: 8))
        ],
      ),
    );
  }
}
