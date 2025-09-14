part of 'navigation_todo_cubit.dart';

class NavigationToDoCubitState extends Equatable {
  final CollectionId? selectedCollectionId;
  final bool? isSecondBodyDisplayed;

  const NavigationToDoCubitState({
     this.selectedCollectionId,
     this.isSecondBodyDisplayed,
  });

  @override
  List<Object?> get props => [
        selectedCollectionId,
        isSecondBodyDisplayed,
      ];
}
