import 'package:flutter/material.dart';

import '../../../../core/config/size_config.dart';
import '../../../../core/utils/screen_navigator.dart';
import '../../../widgets/show_image/show_image_network.dart';

class DetailDonationSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight, expandedHeight;
  final String imageUrl, title;

  DetailDonationSliverHeaderDelegate({
    required this.collapsedHeight,
    required this.imageUrl,
    required this.expandedHeight,
    required this.title,
  });

  @override
  double get minExtent => this.collapsedHeight;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();

    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
          .clamp(0, 255)
          .toInt();

      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(
      height: this.maxExtent,
      width: SizeConfig.screenWidth,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ShowImageNetwork(
            imageUrl: imageUrl,
            boxFit: BoxFit.cover,
            borderRadius: BorderRadius.zero,
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultMargin,
              ),
              child: SizedBox(
                height: this.collapsedHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: this.makeStickyHeaderTextColor(
                          shrinkOffset,
                          true,
                        ),
                      ),
                      onTap: () => _onBackButton(context),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Text(
                          this.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: this.makeStickyHeaderTextColor(
                              shrinkOffset,
                              false,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.favorite_border,
                        color: this.makeStickyHeaderTextColor(
                          shrinkOffset,
                          true,
                        ),
                      ),
                      onTap: () => _onFavoriteButton(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onBackButton(BuildContext context) {
    ScreenNavigator.closeScreen(context);
  }

  void _onFavoriteButton() {
    // TODO => OnTap Favorite button
  }
}
