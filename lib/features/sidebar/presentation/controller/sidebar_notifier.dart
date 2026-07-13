import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rssify/features/sidebar/data/sidebar_repository_implementation.dart';
import 'package:rssify/features/sidebar/presentation/controller/sidebar_notifier_state.dart';

final feedCountProvider = StreamProvider<int>((ref) {
  return ref.watch(sidebarRepositoryProvider).streamFeedCount();
});

final starredCountProvider = StreamProvider<int>((ref) {
  return ref.watch(sidebarRepositoryProvider).streamStarredFeedCount();
});

final unreadCountProvider = StreamProvider<int>((ref) {
  return ref.watch(sidebarRepositoryProvider).streamUnreadFeedCount();
});

class SidebarNotifier extends Notifier<SidebarNotifierState> {
  @override
  SidebarNotifierState build() {
    final feedCount = ref.watch(feedCountProvider).value ?? 0;
    final starredCount = ref.watch(starredCountProvider).value ?? 0;
    final unreadCount = ref.watch(unreadCountProvider).value ?? 0;

    return SidebarNotifierState(
      feedItemCount: feedCount,
      feedItemStarredCount: starredCount,
      feedItemUnreadCount: unreadCount,
    );
  }
}

final sideBarNotifierProvider =
    NotifierProvider<SidebarNotifier, SidebarNotifierState>(
      () => SidebarNotifier(),
    );
