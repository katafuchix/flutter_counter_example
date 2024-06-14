# flutter_counter_example

A new Flutter project.

## Getting Started

```
%  dart run build_runner build
```

### sample code

- counter_state.dart

```
import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_state.freezed.dart';

@freezed
class CounterState with _$CounterState {
  const factory CounterState({
    @Default(0) int count,
  }) = _CounterState;
}
```

- counter_notifier.dart

```
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'counter_state.dart';

part 'counter_notifier.g.dart';

@riverpod
class CounterStateNotifier extends _$CounterStateNotifier {

  @override
  Future<CounterState> build() async {
    return const CounterState();
  }

  Future<void> increment() async {
    state = const AsyncLoading<CounterState>().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      return state.value!.copyWith(count: state.value!.count + 1);
    });
  }

  Future<void> decrement() async {
    state = const AsyncLoading<CounterState>().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      return state.value!.copyWith(count: state.value!.count - 1);
    });
  }
}
```

- main.dart

```
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
    final counterState = ref.watch(counterStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Example with Freezed Riverpod'),
      ),
      body: Center(
        child: counterState.when(
          data: (state) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pushed the button this many times:'),
              Text( '${state.count}', style: Theme.of(context).textTheme.headline4),
            ],
          ),
          loading: () => CircularProgressIndicator(),
          error: (error, stack) => Text('Something went wrong: $error'),
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
```
  
