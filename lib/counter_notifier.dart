//import 'package:flutter_riverpod/flutter_riverpod.dart';
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