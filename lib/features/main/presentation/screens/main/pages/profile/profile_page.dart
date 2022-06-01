import 'package:flutter/material.dart';

import '../../../../../../../shared/config/size_config.dart';
import '../../../../../../../shared/widgets/widget_with_default_horizontal_padding.dart';
import 'widgets/logout_button.dart';
import 'widgets/profile_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: WidgetWithDefaultHorizontalPadding(
        child: SizedBox(
          width: SizeConfig.screenWidth,
          child: Column(
            children: [
              ProfileData(),
              const SizedBox(
                height: 20,
              ),
              LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
