import 'package:flutter/cupertino.dart';
import 'package:xbox_launcher/shared/widgets/commands/models/shared_command.dart';

class PopContextCommand implements SharedCommand {
  BuildContext _context;

  PopContextCommand(this._context);

  @override
  void execute() => Navigator.pop(_context);
}
