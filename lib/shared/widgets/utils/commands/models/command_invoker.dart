import 'package:xbox_launcher/shared/widgets/utils/commands/models/command.dart';

class CommandInvoker {
  final Command _command;
  final Command? onFinish;

  CommandInvoker(this._command, {this.onFinish});

  void execute() {
    _command.execute();
    onFinish?.execute();
  }
}
