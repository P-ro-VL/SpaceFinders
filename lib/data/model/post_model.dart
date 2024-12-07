import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spacefinder/domain/entity/post_entity.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class PostModel with _$PostModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory PostModel({
    num? postId,
    num? uploadedBy,
    String? authorName,
    String? authorAvatar,
    String? title,
    String? slug,
    String? content,
    String? thumbnail,
    String? category,
    dynamic tags,
    String? status,
    dynamic publishedAt,
    dynamic createdAt,
    dynamic updatedAt,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

extension PostModelExts on PostModel {
  PostEntity get toEntity => PostEntity(
      postId: postId,
      uploadedBy: uploadedBy,
      authorName: authorName,
      authorAvatar: authorAvatar,
      title: title,
      slug: slug,
      content: content,
      thumbnail: thumbnail,
      category: category,
      tags: tags,
      status: status,
      publishedAt: publishedAt,
      createdAt: createdAt,
      updatedAt: updatedAt);
}
