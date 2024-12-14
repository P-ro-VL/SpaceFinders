import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'image/image_upload_section.dart';

mixin FormMixin {
  Widget buildDatePicker(
      {required String? text,
      required String? value,
      required Function(dynamic) onSelect}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              text ?? '',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff64646C)),
            ),
            const Text(' *',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red)),
          ],
        ),
        const SizedBox(height: 4),
        TextFormField(
          onTap: () async {
            final result = await showDatePicker(
              context: Get.context!,
              firstDate: DateTime.now().subtract(const Duration(days: 1000)),
              lastDate: DateTime.now().add(const Duration(days: 100000)),
            );
            onSelect.call(result);
          },
          controller: TextEditingController(text: value),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  buildUploadSection({
    required String? text,
    List<String>? supportedFiles,
    bool? isRequired = true,
    int? maxImage,
    int? minImage,
    String? otherNote,
    dynamic Function(Uint8List)? onSelectImage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              text ?? '',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff64646C)),
            ),
            if (isRequired ?? true)
              const Text(' *',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.red)),
          ],
        ),
        const SizedBox(height: 4),
        ImageUploadSection(
            minImages: minImage,
            maxImages: maxImage,
            otherNote: otherNote,
            supportedFiles: supportedFiles ?? [],
            onSelectImage: onSelectImage ?? (_) {}),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget buildTextArea({
    required String? text,
    required Function(dynamic) onChanged,
    bool isDisabled = false,
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              text ?? '',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff64646C)),
            ),
            const Text(' *',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red)),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 150,
          child: TextFormField(
            maxLines: null,
            expands: true,
            decoration: InputDecoration(
              enabled: !isDisabled,
              border: OutlineInputBorder(),
            ),
            onChanged: onChanged,
            validator: (s) {
              if (!isRequired) return null;
              if (s == null || s.isEmpty) {
                return 'Đây là thông tin bắt buộc, vui lòng bổ sung';
              }
            },
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget buildInput({
    required String? text,
    required Function(dynamic) onChanged,
    bool isDisabled = false,
    bool isRequired = true,
    TextInputFormatter? formatter,
    String? note,
    String? defaultValue,
    bool? obsecure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              text ?? '',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff64646C)),
            ),
            if (isRequired)
              const Text(' *',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.red)),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          obscureText: obsecure ?? false,
          decoration: InputDecoration(
            enabled: !isDisabled,
            border: OutlineInputBorder(),
          ),
          inputFormatters: [if (formatter != null) formatter],
          onChanged: onChanged,
          controller: TextEditingController(text: defaultValue ?? ''),
          validator: (s) {
            if (!isRequired) return null;
            if (s == null || s.isEmpty) {
              return 'Đây là thông tin bắt buộc, vui lòng bổ sung';
            }
          },
        ),
        if (note != null) ...{
          const SizedBox(
            height: 4,
          ),
          Text(note,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff93939B),
              )),
        },
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget buildClickableInput({
    required String? text,
    required Function() onClick,
    bool isDisabled = false,
    bool isRequired = true,
    bool isUrl = true,
    String? note,
    String? defaultValue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              text ?? '',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff64646C)),
            ),
            const Text(' *',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red)),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: onClick,
          child: TextFormField(
              decoration: InputDecoration(
                enabled: !isDisabled,
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: defaultValue ?? ''),
              validator: (s) {
                if (!isRequired) return null;
                if (s == null || s.isEmpty) {
                  return 'Đây là thông tin bắt buộc, vui lòng bổ sung';
                }
              },
              style: isUrl
                  ? const TextStyle(
                      color: Color(0xff1253F6),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xff1253F6))
                  : null),
        ),
        if (note != null) ...{
          const SizedBox(
            height: 4,
          ),
          Text(note,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff93939B),
              )),
        },
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget buildDropdown({
    required String? text,
    required String? value,
    required List<String> values,
    required Function(dynamic) onSelect,
    bool isRequired = true,
    bool isDisabled = false,
    String? defaultValue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              text ?? '',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff64646C)),
            ),
            if (isRequired)
              const Text(' *',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.red)),
          ],
        ),
        const SizedBox(height: 4),
        IgnorePointer(
          ignoring: isDisabled,
          child: DropdownButtonFormField(
            value: defaultValue ?? value,
            isExpanded: true,
            items: values
                .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(color: isDisabled ? Colors.black26 : null),
                    )))
                .toList(),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: onSelect,
            validator: (s) {
              if (!isRequired) return null;
              if (s == null || s.isEmpty) {
                return 'Đây là thông tin bắt buộc, vui lòng bổ sung';
              }
            },
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
