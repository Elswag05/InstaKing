import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_assets.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ref, child) {
        final profileController = ref.watch(instaProfileController.notifier);
        final apiData = ref.watch(instaProfileController.notifier).model;
        return SizedBox(
          height: MediaQuery.of(context).size.height / 3.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
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
                        btnCancelColor: Theme.of(context).unselectedWidgetColor,
                        btnOkText: 'Gallery',
                        btnCancelText: 'Camera',
                      ).show();
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              65.r,
                            ), // Adjust the radius as needed
                            border: Border.all(
                              width: 2.sp,
                              color: InstaColors.lightColor,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 60.r,
                            backgroundColor: InstaColors.lightColor,
                            backgroundImage: AssetImage(
                              EnvAssets.getImagePath('user-image'),
                            ),
                            foregroundImage: NetworkImage(
                              ref
                                      .read(instaProfileController.notifier)
                                      .model
                                      .user
                                      ?.profilePicture ??
                                  '',
                            ),
                            onForegroundImageError:
                                ((exception, stackTrace) {}),
                            onBackgroundImageError:
                                ((exception, stackTrace) {}),
                          ),
                        ),
                        // Position the badge appropriately using Offset or EdgeInsets
                        Positioned(
                          bottom: 5.r,
                          right: 5.r,
                          child: Container(
                            width: 25.sp, // Adjust width and height as needed
                            height: 25.sp, // Adjust width and height as needed
                            decoration: const BoxDecoration(
                              color: InstaColors
                                  .lightColor, // Customize badge color
                              shape: BoxShape.circle, // Change shape if needed
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: InstaColors.darkColor,
                                weight: 20.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).afmPadding(
                    EdgeInsets.only(right: 10.w),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: AutoSizeText(
                      '${apiData.user?.fname ?? 'loading...'} ${apiData.user?.lname ?? "loading..."}',
                      minFontSize: 10.sp,
                      stepGranularity: 2.sp,
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: InstaColors.lightColor,
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
              AutoSizeText(
                apiData.user?.email ?? 'loading...',
                minFontSize: 10.sp,
                stepGranularity: 2.sp,
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: InstaColors.lightColor,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        );
      }),
    );
  }
}
