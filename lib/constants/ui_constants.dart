import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:x/constants/constants.dart';
import 'package:x/features/explore/view/explore_view.dart';
import 'package:x/features/notifications/view/notification_view.dart';
import 'package:x/features/tweet/widgets/tweet_list.dart';
import 'package:x/theme/pallete.dart';


class UIConstants{
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(AssetsConstants.twitterLogo,
      color: Pallete.blueColor,
      height: 30,
      ),
      centerTitle: true,
    );
  }

  static const List<Widget> bottomTabBarPages = [
    TweetList(),
    ExploreView(),
    NotificationView(),
  ];
}