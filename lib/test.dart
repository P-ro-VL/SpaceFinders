import 'dart:io';
import 'dart:math';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/v4.dart';

class ImageUploader {
  static Future<void> action() async {
    final path = '/Users/admin/Downloads/test/';

    final uploader = ImageUploader();
    print('Chung cư');
    await uploader.processImages('Chung cư', '{$path}Chung cư');
    print('Cửa hàng');
    await uploader.processImages('Cửa hàng', '{$path}Cửa hàng');
    print('Đất nền');
    await uploader.processImages('Đất nền', '{$path}Đất nền');
    print('Nhà trọ');
    await uploader.processImages('Nhà trọ', '{$path}Nhà trọ');
    print('Văn phòng');
    await uploader.processImages('Văn phòng', '{$path}Văn phòng');
  }

  // Hàm chính
  Future<void> processImages(String propertyType, String directory) async {
    final random = Random();

    // 1. Lấy danh sách bản ghi từ bảng lead_listings
    final response = await Supabase.instance.client
        .from('lead_listings')
        .select('lead_id')
        .eq('property_type', propertyType);

    if (response.isEmpty) {
      print(
          'Không có bản ghi nào trong lead_listings phù hợp với propertyType.');
      return;
    }

    List<int> leadIds =
        response.map<int>((record) => record['lead_id'] as int).toList();

    // 2. Lấy tất cả file ảnh từ directory
    final directoryFolder = Directory(directory);
    final allFiles = directoryFolder
        .listSync()
        .whereType<File>()
        .where(
            (file) => file.path.endsWith('.jpg') || file.path.endsWith('.png'))
        .toList();

    if (allFiles.isEmpty) {
      print('Thư mục không chứa ảnh nào.');
      return;
    }

    // 3. Lặp qua từng lead_id
    for (var leadId in leadIds) {
      // Kiểm tra và lấy 3 ảnh ngẫu nhiên
      while (allFiles.length >= 3) {
        List<File> selectedImages = [];

        // Lấy ngẫu nhiên 3 ảnh
        for (int i = 0; i < 3; i++) {
          final index = random.nextInt(allFiles.length);
          selectedImages.add(allFiles.removeAt(index));
        }

        // 4. Upload 3 ảnh lên Supabase và thêm vào bảng lead_images
        for (var imageFile in selectedImages) {
          try {
            final imageUrl = await _uploadImage(imageFile, directory);

            // Thêm bản ghi vào bảng lead_images
            await _insertImageRecord(leadId, imageUrl);
            print('Đã upload và chèn ảnh cho lead_id: $leadId');
          } catch (e) {
            print('Lỗi khi upload ảnh: ${imageFile.path}, $e');
          }
        }

        // 5. Xoá 3 ảnh đã xử lý khỏi directory
        for (var imageFile in selectedImages) {
          await imageFile.delete();
          print('Đã xoá ảnh: ${imageFile.path}');
        }
      }

      print('Lead_id: $leadId đã đủ ảnh.');
    }
  }

  // Hàm upload ảnh lên Supabase Storage
  Future<String> _uploadImage(File imageFile, String directory) async {
    final fileName = '${UuidV4().generate()}.png';
    final storage = Supabase.instance.client.storage.from('spacefinder-cdn');

    // Upload ảnh
    final result = await storage.upload(fileName, imageFile);

    return result;
  }

  // Hàm chèn bản ghi vào bảng lead_images
  Future<void> _insertImageRecord(int leadId, String imageUrl) async {
    final random = Random();
    final currentMillis = DateTime.now().millisecondsSinceEpoch;

    final imageRecord = {
      'image_id':
          random.nextInt(899999) + 100000, // Random số từ 100000 - 999999
      'lead_id': leadId,
      'image_url': imageUrl,
      'created_at': currentMillis,
      'updated_at': currentMillis,
    };

    await Supabase.instance.client.from('lead_images').insert(imageRecord);
  }
}
