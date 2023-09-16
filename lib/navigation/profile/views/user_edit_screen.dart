import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/navigation/profile/view_models/profile_user_vm.dart';
import 'package:review_tiktok/navigation/profile/widgets/user_avatar_widget.dart';

class UserEditScreen extends ConsumerStatefulWidget {
  const UserEditScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends ConsumerState<UserEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formdata = {};
  bool isChange = false;

  Future<void> _onSaveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (isChange) {
        await ref.read(profileUserProvider.notifier).updateProfile(_formdata);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.read(profileUserProvider).when(
          error: (error, stackTrace) {
            return Center(
              child: Text('Error Occuerd : $error'),
            );
          },
          loading: () => const CircularProgressIndicator(),
          data: (data) => GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('프로필 수정'),
                actions: [
                  IconButton(
                    onPressed: _onSaveProfile,
                    icon: const FaIcon(
                      FontAwesomeIcons.check,
                      color: Colors.green,
                      size: Sizes.size18,
                    ),
                  ),
                ],
              ),
              body: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size16,
                    vertical: Sizes.size10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserAvatarWidget(
                              name: data.name,
                              uid: data.uid,
                              hasAvatar: data.hasAvatar),
                        ],
                      ),
                      Gaps.v20,
                      const Text('이름'),
                      TextFormField(
                        initialValue: data.name,
                        validator: (value) {
                          if (value == '' || value == null) {
                            return '이름을 입력하세요';
                          } else {
                            if (value.length < 3) {
                              return '이름은 3글자 이상 작성해주세요';
                            } else {
                              if (data.name != value) {
                                isChange = true;
                              }
                            }
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _formdata['name'] = newValue;
                        },
                      ),
                      Gaps.v20,
                      const Text('소개'),
                      TextFormField(
                        initialValue: data.bio,
                        maxLines: null,
                        validator: (value) {
                          if (data.bio != value) {
                            isChange = true;
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _formdata['bio'] = newValue;
                        },
                      ),
                      Gaps.v20,
                      const Text('링크'),
                      TextFormField(
                        initialValue: data.link,
                        validator: (value) {
                          if (data.link != value) {
                            isChange = true;
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _formdata['link'] = newValue;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
