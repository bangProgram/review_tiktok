import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/navigation/profile/view_models/profile_avatar_vm.dart';
import 'package:review_tiktok/navigation/profile/view_models/profile_user_vm.dart';

class UserAvatarWidget extends ConsumerWidget {
  final String name;
  final String uid;
  final bool hasAvatar;

  const UserAvatarWidget({
    super.key,
    required this.name,
    required this.uid,
    required this.hasAvatar,
  });

  void _uploadAvatar(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
        maxHeight: 150,
        maxWidth: 150);

    if (xfile != null) {
      final file = File(xfile.path);
      await ref.read(profileAvatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(profileUserProvider).isLoading
        ? Container(
            width: Sizes.size72,
            height: Sizes.size72,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : GestureDetector(
            onTap: () => _uploadAvatar(ref),
            child: CircleAvatar(
              radius: Sizes.size40,
              foregroundImage: hasAvatar
                  ? NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/jb-tiktok-clone.appspot.com/o/users%2F$uid?alt=media&token=5a7386a5-131c-478a-a22b-4a56c62bd7f5')
                  : null,
              child: Text(name),
            ),
          );
  }
}
