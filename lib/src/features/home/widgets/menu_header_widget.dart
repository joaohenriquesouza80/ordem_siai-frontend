import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ordem_siai/src/features/home/controllers/home_page_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_images.dart';
import '../../../shared/widget/image_box/image_box_cached_widget.dart';
import '../../user_profile/providers/user_profile_provider.dart';

class MenuHeaderWidget extends StatefulWidget {
  final HomePageController controller;

  const MenuHeaderWidget({
    super.key,
    required this.controller,
  });

  @override
  State<MenuHeaderWidget> createState() => _MenuHeaderWidgetState();
}

class _MenuHeaderWidgetState extends State<MenuHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 110,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(5),
            ),
          ),
          child: Consumer<UserProfileProvider>(builder: (ctx, provider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: AppColors.myWhite,
                      child: ImageBoxCachedWidget(
                        imageUrl: provider.profile.avatar_url ?? "",
                        imageAssetDefault: AppImages.defaultUserAvatar,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: AutoSizeText(
                    provider.profile.name != null
                        ? "Olá\n${widget.controller.getUserName()}"
                        : "",
                    maxLines: 2,
                    style: GoogleFonts.robotoSlab(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: AppColors.myWhite),
                  ),
                ),
              ],
            );
          }),
        ),
        const Divider(
          indent: 8.0,
          endIndent: 8.0,
        ),
      ],
    );
  }
}
