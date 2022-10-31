import 'package:xbox_launcher/shared/widgets/utils/commands/models/shared_command.dart';

class CommandInvoker {
  final SharedCommand _command;
  final SharedCommand? onFinish;

  CommandInvoker(this._command, {this.onFinish});

  void execute() {
    _command.execute();
    onFinish?.execute();
  }
}
