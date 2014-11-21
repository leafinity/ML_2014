library ml_mc.arg;

import "dart:io";
import "package:args/args.dart" show ArgParser;

class ArgsTrain {
  final String path;

  ArgsTrain(String this.path);
}

class ArgsBoth {
  final String trainDataPath;
  final String testDataPath;

  ArgsBoth(String this.trainDataPath, String this.testDataPath);
}

ArgsTrain parseArgsTrainData(List<String> arguments)
  => _parseTrainData(arguments);

ArgsBoth parseArgsBothData(List<String> arguments)
  => _parseArgsBothData(arguments);

ArgsTrain _parseTrainData(List<String> arguments) {
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

  return new ArgsTrain(path);
}

ArgsBoth _parseArgsBothData(List<String> arguments) {  
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
  
  
  return new ArgsBoth(trainPath, testPath);
}