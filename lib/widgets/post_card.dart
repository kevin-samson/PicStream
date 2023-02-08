import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  final Map<String, dynamic> post;
  const PostCard({super.key, required this.post});

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
            backgroundImage: NetworkImage(widget.post['profileImg']),
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
      child: Image.network(
        widget.post['imageUrl'],
        fit: BoxFit.cover,
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
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      '${widget.post['likes'].length} likes',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w800),
                    )
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
          InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: const Text(
                'View all 2323 comments',
                style: TextStyle(color: secondaryColor, fontSize: 14),
              ),
            ),
          ),
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
