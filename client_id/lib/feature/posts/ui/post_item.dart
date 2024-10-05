import 'package:client_id/feature/posts/domain/entity/post/post_entity.dart';
import 'package:client_id/feature/posts/ui/detail_post_screen.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.postEntity});

  final PostEntity postEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                DetailPostScreen(id: postEntity.id.toString())));
      },
      child: Card(
        //color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(postEntity.name),
            const SizedBox(height: 16),
            Text(postEntity.preContent ?? ''),
            //Text("Author: ${postEntity.author?.id ?? ''}"),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
