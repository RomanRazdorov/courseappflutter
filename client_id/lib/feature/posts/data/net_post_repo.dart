import 'package:client_id/app/domain/app_api.dart';
import 'package:client_id/app/domain/error_entity.dart/error_entity.dart';
import 'package:client_id/feature/posts/domain/entity/post/post_entity.dart';
import 'package:client_id/feature/posts/domain/post_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PostRepo)
class NetPostRepo implements PostRepo {
  final AppApi api;

  NetPostRepo(this.api);

  @override
  Future<Iterable> fetchPosts() async {
    try {
      final response = await api.fetchPosts();
      // if (response.data["data"] == null && response.statusCode == 200) {
      //   return const Iterable.empty();
      // }
      return response.data;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> createPost(Map args) async {
    try {
      final response = await api.createPost(args);
      return response.data["message"];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<PostEntity> fetchPost(String id) async {
    try {
      final response = await api.fetchPost(id);
      return PostEntity.fromJson(response.data["data"]);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future deletePost(String id) async {
    try {
      await api.deletePost(id);
    } catch (_) {
      rethrow;
    }
  }
}
