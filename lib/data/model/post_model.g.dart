// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostModelImpl _$$PostModelImplFromJson(Map<String, dynamic> json) =>
    _$PostModelImpl(
      postId: json['post_id'] as num?,
      uploadedBy: json['uploaded_by'] as num?,
      authorName: json['author_name'] as String?,
      authorAvatar: json['author_avatar'] as String?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      content: json['content'] as String?,
      thumbnail: json['thumbnail'] as String?,
      category: json['category'] as String?,
      tags: json['tags'],
      status: json['status'] as String?,
      publishedAt: json['published_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );

Map<String, dynamic> _$$PostModelImplToJson(_$PostModelImpl instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'uploaded_by': instance.uploadedBy,
      'author_name': instance.authorName,
      'author_avatar': instance.authorAvatar,
      'title': instance.title,
      'slug': instance.slug,
      'content': instance.content,
      'thumbnail': instance.thumbnail,
      'category': instance.category,
      'tags': instance.tags,
      'status': instance.status,
      'published_at': instance.publishedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
