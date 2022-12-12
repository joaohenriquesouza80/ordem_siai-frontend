import 'package:ordem_siai/src/features/auth/providers/auth_provider.dart';

import '../../../shared/providers/client_http/client_http_provider.dart';
import '../models/assemblage_mode.dart';
import 'implementations/assemblages_repository_fake.dart';
//import 'implementations/assemblages_repository_impl.dart';

abstract class AssemblagesRepository {
  Future<List<AssemblageModel>> getAllAssemblages();

  factory AssemblagesRepository(
      ClientHttpProvider clientHttpProvider, AuthProvider authProvider) {
    //return AssemblagesRepositoryImpl(clientHttpProvider);
    return AssemblagesRepositoryFake(authProvider);
  }
}
