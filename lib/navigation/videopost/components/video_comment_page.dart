import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/navigation/videopost/widgets/comment_text_widget.dart';

class VideoCommentPage extends StatefulWidget {
  const VideoCommentPage({super.key});

  @override
  State<VideoCommentPage> createState() => _VideoCommentPageState();
}

class _VideoCommentPageState extends State<VideoCommentPage> {
  final TextEditingController _editingController = TextEditingController();

  String _isWriting = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  void _commentPop() {
    Navigator.of(context).pop();
  }

  void _inputText(String text) {
    setState(() {
      _isWriting = text;
    });
  }

  void _focusOut() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.75,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Sizes.size10),
            topRight: Radius.circular(Sizes.size10),
          )),
      child: GestureDetector(
        onTap: _focusOut,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              '22796 comments',
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            actions: [
              IconButton(
                onPressed: _commentPop,
                icon: const FaIcon(
                  FontAwesomeIcons.xmark,
                  size: Sizes.size18,
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: Sizes.size64),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size8,
                  ),
                  itemCount: 10,
                  separatorBuilder: (context, index) => Gaps.v10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: Sizes.size18,
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              child: Text(
                                '전뱅$index',
                                style: const TextStyle(
                                  fontSize: Sizes.size14,
                                ),
                              ),
                            ),
                            Gaps.h5,
                            const Expanded(
                              child: CommentTextWidget(),
                            ),
                            Gaps.h5,
                            Column(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.heart,
                                  color: Colors.grey.shade500,
                                  size: Sizes.size20,
                                ),
                                Text(
                                  '52.2K',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: Sizes.size14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                width: screenWidth,
                child: BottomAppBar(
                  child: Container(
                    padding: const EdgeInsets.all(
                      Sizes.size10,
                    ),
                    color: Colors.white,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: Sizes.size18,
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          child: Text(
                            '전뱅',
                            style: TextStyle(
                              fontSize: Sizes.size14,
                            ),
                          ),
                        ),
                        Gaps.h5,
                        Expanded(
                          child: SizedBox(
                            height: Sizes.size40,
                            child: TextField(
                              onChanged: _inputText,
                              controller: _editingController,
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Add comment...',
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: Sizes.size5,
                                  horizontal: Sizes.size10,
                                ),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.hashtag,
                                      color: Colors.black54,
                                    ),
                                    Gaps.h14,
                                    const FaIcon(
                                      FontAwesomeIcons.gift,
                                      color: Colors.black54,
                                    ),
                                    Gaps.h14,
                                    const FaIcon(
                                      FontAwesomeIcons.faceSmile,
                                      color: Colors.black54,
                                    ),
                                    Gaps.h14,
                                    if (_isWriting != "") ...{
                                      FaIcon(
                                        FontAwesomeIcons.solidPaperPlane,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Gaps.h14,
                                    }
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
