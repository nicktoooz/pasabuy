class Post {
  late String postId;
  late String userId;
  late String content;
  late String address;
  late int createdAt;
  late List<String> imageUrls;

  Post(this.postId, this.userId, this.content, this.address, this.imageUrls, this.createdAt);
}
