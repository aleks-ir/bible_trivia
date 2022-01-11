class LoadedAppAction {}

class UpdateLoadingAppDataFromApiAction {
  final bool loadingDataFromApi;
  UpdateLoadingAppDataFromApiAction(this.loadingDataFromApi);
}

class UpdateLoadingAppDataFromFirebaseAction {
  final bool loadingDataFromFirebase;
  UpdateLoadingAppDataFromFirebaseAction(this.loadingDataFromFirebase);
}

class UpdateSearchingAction {
  final bool searching;
  UpdateSearchingAction(this.searching);
}