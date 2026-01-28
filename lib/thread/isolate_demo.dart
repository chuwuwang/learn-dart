import 'dart:convert';
import 'dart:isolate';

class IsolateDemo {

  void main() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(runTask, receivePort.sendPort);

    onData(message) {
      print("Message from isolate: $message");
    }
    receivePort.listen(onData);
  }

  void runTask(SendPort sendPort) {
    sendPort.send("Heavy task done ✅");
  }

  void main2() async {
    computation() {
      // Heavy computation here
      return "Task finished in another isolate ✅";
    }
    final result = await Isolate.run(computation);
    print(result);
  }

}
