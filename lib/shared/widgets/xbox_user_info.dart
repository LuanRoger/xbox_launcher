import 'package:fluent_ui/fluent_ui.dart';

import '../../../shared/app_colors.dart';

class XboxUserInfo extends StatelessWidget {
  const XboxUserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundColor: AppColors.GREEN,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("ROG"), Text("ULTIMATE")],
        ),
      ],
    );
  }
}
