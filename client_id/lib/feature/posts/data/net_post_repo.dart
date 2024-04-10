import 'package:client_id/app/domain/app_api.dart';
import 'package:client_id/feature/posts/domain/post_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PostRepo)
class NetPostRepo implements PostRepo {
  final AppApi api;

  NetPostRepo(this.api);

  @override
  Future<Iterable> fetchPosts() async {
    try {
      final response = await api.fetchPosts();
      return response.data;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Iterable> createPost(Map args) async {
    try {
      final response = await api.createPost(args);
      return response.data["message"];
    } catch (_) {
      rethrow;
    }
  }
}
