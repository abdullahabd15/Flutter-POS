import 'dart:io';

void main() async {
  //change this to your flutter path
  final flutterPath = r'C:\Users\skyla\dev\flutter\bin\flutter.bat';

  final dirs = Directory.current
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('pubspec.yaml'))
      .map((f) => f.parent)
      .toSet();

  for (final dir in dirs) {
    print('Cleaning ${dir.path}');
    final result = await Process.run(flutterPath, [
      'clean',
    ], workingDirectory: dir.path);
    stdout.write(result.stdout);
    stderr.write(result.stderr);
  }
}
