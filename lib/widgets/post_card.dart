import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/storage_methods.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';

class PostCard extends StatefulWidget {
  final Map<String, dynamic> post;
  final String id;
  const PostCard({super.key, required this.post, required this.id});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    final topSection = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
          .copyWith(right: 0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage:
                CachedNetworkImageProvider(widget.post['profileImg']),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(widget.post['username'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16)),
            ),
          ),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                            child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.flag),
                              title: const Text('Report'),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: const Icon(Icons.block),
                              title: const Text('Block'),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: const Icon(Icons.cancel),
                              title: const Text('Cancel'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        )));
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
    );

    final imageSection = SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: widget.post['imageUrl'],
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );

    final bottomSection = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    LikeButton(
                      onTap: (isLiked) async {
                        await StorageMethods().likePost(widget.id,
                            widget.post['uid'], widget.post['likes']);
                        return !isLiked;
                      },
                      likeCount: 0,
                      likeBuilder: (isLiked) {
                        return Icon(
                          Icons.favorite,
                          color:
                              widget.post['likes'].contains(widget.post['uid'])
                                  ? Colors.red
                                  : Colors.white,
                          size: 29,
                        );
                      },
                      countBuilder: (int? count, bool isLiked, String text) {
                        return Text(
                          '${widget.post['likes'].length} likes',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w800),
                        );
                      },
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.comment_outlined,
                  )),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RichText(
              text: TextSpan(
                  style: const TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                        text: widget.post['username'],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: ' '),
                    TextSpan(
                        text: widget.post['caption'],
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        )),
                  ]),
            ),
          ),
          // InkWell(
          //   onTap: () {},
          //   child: Container(
          //     width: double.infinity,
          //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          //     child: const Text(
          //       'View all 2323 comments',
          //       style: TextStyle(color: secondaryColor, fontSize: 14),
          //     ),
          //   ),
          // ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Text(
              DateFormat.yMMMd().format(widget.post['date'].toDate()),
              style: const TextStyle(color: secondaryColor, fontSize: 14),
            ),
          ),
        ],
      ),
    );

    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        children: [topSection, imageSection, bottomSection],
      ),
    );
  }
}
