abstract class SidebarRepository {
  Stream<int> streamUnreadFeedCount();
  Stream<int> streamStarredFeedCount();
  Stream<int> streamFeedCount();
}
