import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/providers/main_background_image_provider.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/button_tile.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page.dart';
import 'package:xbox_launcher/shared/widgets/vignette.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class BackgroundSelectPage extends XboxPageStateless {
  List<Color>? availableColors;
  List<ImageProvider>? availableImages;
  //TODO: Made only for colors
  bool get _isColor =>
      availableColors != null ? availableColors!.isNotEmpty : false;

  BackgroundSelectPage({Key? key, this.availableColors, this.availableImages})
      : super(
          key: key,
          keyAction: {
            ControllerKeyboardPair(
                    LogicalKeyboardKey.escape, ControllerButton.BACK):
                ((context) => Navigator.pop(context))
          },
        );

  @override
  Widget virtualBuild(BuildContext context) {
    return Stack(
      children: [
        _BackgroundView(isColorPreview: availableColors != null),
        Align(
            alignment: Alignment.bottomCenter,
            child: Vignette(
              height: 200,
            )),
        Padding(
          padding: const EdgeInsets.all(50),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 130,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 30,
                    childAspectRatio: 0.6),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ButtonTile(
                    "",
                    false,
                    color: availableColors?[index],
                    image: availableImages?[index],
                    tileSize: TileSize.MEDIUM,
                    onPressed: (context) {
                      var state = context.read<MainBackgroundImageProvider>();
                      if (_isColor) {
                        state.colorIndex = index;
                        state.preferenceByImage = false;
                      }
                    },
                  );
                },
                itemCount: availableColors != null
                    ? availableColors!.length
                    : availableImages!.length,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _BackgroundView extends StatelessWidget {
  bool isColorPreview;

  _BackgroundView({Key? key, required this.isColorPreview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainBackgroundImageProvider>(
      builder: (context, value, child) {
        return AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Container(color: value.solidColorBackground));
      },
    );
  }
}
