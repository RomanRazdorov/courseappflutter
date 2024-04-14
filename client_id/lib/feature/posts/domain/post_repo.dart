abstract class PostRepo {
  Future fetchPosts();
  Future fetchPost(String id);
  Future createPost(Map args);
  Future deletePost(String id);
}
