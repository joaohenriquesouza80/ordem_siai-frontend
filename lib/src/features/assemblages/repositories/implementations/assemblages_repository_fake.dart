import 'package:ordem_siai/src/features/auth/providers/auth_provider.dart';

import '../../../../shared/mocks/repositories_mock.dart';
import '../../../users/models/users_models.dart';
import '../../models/assemblage_mode.dart';
import '../assemblages_repository.dart';

class AssemblagesRepositoryFake implements AssemblagesRepository {
  final AuthProvider authProvider;

  AssemblagesRepositoryFake(this.authProvider);

  @override
  Future<List<AssemblageModel>> getAllAssemblages() async {
    List<AssemblageModel> assemblages = RepositoriesMocks.getMockAssemblages(5);

    assemblages.sort(
      (a, b) => a.name!.toUpperCase().compareTo(b.name!.toUpperCase()),
    );

    List<UsersModel> usersModel = RepositoriesMocks.getMockFullUsers();

    String userId = authProvider.authUser!.user.id!;

    final index = usersModel.indexWhere(
      (u) => u.id == userId,
    );

    if (index < 0) {
      return [];
    }

    UsersModel user = usersModel[index];

    if (user.UserProfile?.assemblage == null) {
      return assemblages;
    }
    return assemblages
        .where((e) => e.id == user.UserProfile?.assemblage?.id)
        .toList();
  }
}
