import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/main_background_image_provider.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainBackgroundImageProvider>(
      builder: (context, value, child) {
        return value.preferenceByImage
            ? Image(
                image: value.imageBackground!,
                fit: BoxFit.fill,
              )
            : Container(
                color: value.solidColorBackground,
              );
      },
    );
  }
}
