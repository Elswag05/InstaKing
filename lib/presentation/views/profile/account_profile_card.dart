import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';

class ProfileCard extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onProfileIconTap;

  const ProfileCard({
    super.key,
    this.onTap,
    this.onProfileIconTap,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ref, child) {
        final profileController = ref.watch(instaProfileController.notifier);
        final apiData = ref.watch(instaProfileController.notifier).model;
        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            padding: EdgeInsets.all(13.sp),
            color: Theme.of(context).cardColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.noHeader,
                          animType: AnimType.scale,
                          headerAnimationLoop: true,
                          title: 'Choose Profile Image',
                          desc: 'Choose image from...',
                          btnOkOnPress: () {
                            profileController.pickImageGallery().then(
                                  (value) => profileController.toSaveImage(),
                                );
                          },
                          btnCancelOnPress: () {
                            profileController.pickImageCamera().then(
                                  (value) => profileController.toSaveImage(),
                                );
                          },
                          btnOkIcon: Icons.photo_size_select_actual_outlined,
                          btnCancelIcon: Icons.camera_alt_outlined,
                          btnOkColor: InstaColors.primaryColor,
                          btnCancelColor:
                              Theme.of(context).unselectedWidgetColor,
                          btnOkText: 'Gallery',
                          btnCancelText: 'Camera',
                        ).show();
                      },
                      child: CircleAvatar(
                        radius: 20.r,
                        //foregroundImage: FileImage(widget.imageFile),
                        backgroundColor: InstaColors.primaryColor,
                        backgroundImage: AssetImage(
                          EnvAssets.getImagePath('user-image'),
                        ),
                        // foregroundImage: NetworkImage(),
                      ),
                    ).afmPadding(EdgeInsets.only(right: 10.w)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: AutoSizeText(
                                '${apiData.user!.fname} ${apiData.user!.lname}',
                                minFontSize: 10.sp,
                                stepGranularity: 2.sp,
                                style: TextStyle(
                                  fontFamily: 'Montesserat',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Image.asset(
                              EnvAssets.getIconPath('verified'),
                              width: 16.w,
                              height: 16.h,
                            ),
                          ],
                        ),
                        Text(
                          'Edit Personal Detail',
                          style: TextStyle(
                            fontFamily: 'Montesserat',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20.sp,
                ).afmPadding(EdgeInsets.only(right: 16.h)),
              ],
            ),
          )
              .afmBorderRadius(BorderRadius.circular(10.r))
              .afmPadding(EdgeInsets.only(bottom: 20.sp)),
        );
      }),
    );
  }
}
