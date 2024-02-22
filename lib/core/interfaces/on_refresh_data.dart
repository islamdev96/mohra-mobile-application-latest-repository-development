import 'dart:async';
mixin OnRefreshDataMixin on Object {
  Completer refreshSubCompleter = Completer();
  Future<void> onRefresh();
}