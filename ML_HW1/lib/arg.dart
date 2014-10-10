library ml_hw1.arg;

import "dart:io";
import "package:args/args.dart" show ArgParser;

class Args {
  final String path;

  Args(String this.path);
}

Args parseArgs(List<String> arguments)
  =>_parseArgs(arguments);

Args _parseArgs(List<String> arguments) {
  final ArgParser parser = new ArgParser()
    ..addFlag("help", abbr: 'h', negatable: false, help: "Display this message");

  var args;
  try {
    args = parser.parse(arguments);
  } on FormatException catch (e) {
    print(e.message);
    return null;
  }

  if (args['help']) {
    print("Usage: dart ${Platform.script.toFilePath()} [<String>] path");
    print(parser.getUsage());
    return null;
  }

  if (args.rest.length != 1) {
    print("the path of train data required. Use -h for help.");
    return null;
  }
  
  final String path = args.rest.first;

  return new Args(path);
}