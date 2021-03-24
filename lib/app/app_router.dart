@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: SignInView,initial: true),
  AutoRoute(page: HomeView,),
  AutoRoute(page: AtSignView),
  AutoRoute(page: NewNoteView),
  AutoRoute(page: AttachView),
  AutoRoute(page: ProfileView),
  AutoRoute(page: ScanQrScreen),
  AutoRoute(page: AddNoteLinkView),
  AutoRoute(page: AttachedProfileView),
  AutoRoute(page: NoteDetailsView),
  AutoRoute(page: NoteCollectionView)
])
class $AppRouter {}