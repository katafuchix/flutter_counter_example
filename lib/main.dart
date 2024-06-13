import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'counter_notifier.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    ),
  );
}

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // プロバイダからカウンターの状態を取得
    final provider = ref.watch(counterStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Example with Freezed Riverpod'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Text('${provider.value!.count}', style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => ref.read(counterStateNotifierProvider.notifier).increment(),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => ref.read(counterStateNotifierProvider.notifier).decrement(),
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}