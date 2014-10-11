library ml_pla.arg;

import "dart:io";
import "package:args/args.dart" show ArgParser;

class ArgsPLA {
  final String path;

  ArgsPLA(String this.path);
}

class ArgsPocket {
  final String trainDataPath;
  final String testDataPath;

  ArgsPocket(String this.trainDataPath, String this.testDataPath);
}

ArgsPLA parseArgsPLA(List<String> arguments)
  =>_parseArgsPLA(arguments);

ArgsPocket parseArgsPocket(List<String> arguments)
  =>_parseArgsPocket(arguments);

ArgsPLA _parseArgsPLA(List<String> arguments) {
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
    print("Usage: dart ${Platform.script.toFilePath()} [<Path>] trianData");
    print(parser.getUsage());
    return null;
  }

  if (args.rest.length != 1) {
    print("the path of train data required. Use -h for help.");
    return null;
  }
  
  final String path = args.rest.first;

  return new ArgsPLA(path);
}

ArgsPocket _parseArgsPocket(List<String> arguments) {  
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
    print("Usage: dart ${Platform.script.toFilePath()} [<Path>]trianData [<Path>]testData");
    print(parser.getUsage());
    return null;
  }
  
  if (args.rest.length != 2) {
    print("the pathes of train data and test data required. Use -h for help.");
    return null;
  }
  
  final String trainPath = args.rest[0];
  final String testPath = args.rest[1];
  
  
  return new ArgsPocket(trainPath, testPath);
}