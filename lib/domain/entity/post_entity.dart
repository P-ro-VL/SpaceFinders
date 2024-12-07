class PostEntity {
  final num? postId;
  final num? uploadedBy;
  final String? authorName;
  final String? authorAvatar;
  final String? title;
  final String? slug;
  final String? content;
  final String? thumbnail;
  final String? category;
  final dynamic tags;
  final String? status;
  final dynamic publishedAt;
  final dynamic createdAt;
  final dynamic updatedAt;

  PostEntity(
      {this.postId,
      this.uploadedBy,
      this.authorName,
      this.authorAvatar,
      this.title,
      this.slug,
      this.content,
      this.thumbnail,
      this.category,
      this.tags,
      this.status,
      this.publishedAt,
      this.createdAt,
      this.updatedAt});
}
