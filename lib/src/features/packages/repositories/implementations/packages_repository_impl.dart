import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:ordem_siai/src/features/packages/models/insert_package_dto.dart';
import 'package:ordem_siai/src/features/packages/models/package_users_model.dart';
import 'package:ordem_siai/src/features/packages/models/update_package_status_dto.dart';
import 'package:ordem_siai/src/features/packages/models/update_package_user_presence_status_dto.dart';

import '../../../../shared/exceptions/http_response_exceptions.dart';
import '../../../../shared/providers/client_http/client_http_provider.dart';
import '../../../../shared/providers/client_http/models/client_http_response_model.dart';
import '../../models/package_model.dart';
import '../packages_repository.dart';

class PackagesRepositoryImpl implements PackagesRepository {
  final ClientHttpProvider clientHttpProvider;

  PackagesRepositoryImpl(this.clientHttpProvider);

  @override
  Future<List<PackageModel>> getAllPackages() async {
    const method = "/packages";

    final ClientHttpResponseModel responseHttp = await clientHttpProvider.get(
      method: method,
      withToken: true,
    );

    if (responseHttp.statusCode == 200) {
      final list =
          jsonDecode(responseHttp.responseData).cast<Map<String, dynamic>>();
      return list
          .map<PackageModel>((item) => PackageModel.fromMap(item))
          .toList();
    }

    HttpResponseExceptions(responseHttp).toString();
    return Future.value([]);
  }

  @override
  Future<PackageModel> insertPackage(PackageModel package) async {
    const method = "/packages";

    final f = DateFormat('yyyy-MM-dd hh:mm:ss');

    InsertPackageModel insertPackageModel = InsertPackageModel(
      package_type_id: package.tipo_pacote!.tip_pac_uuid!,
      event_date_time: f.format(package.pac_dt_evento!),
      assemblage_id: package.assembleia!.ass_uuid!,
      package_users: package.rel_pacote_usuario!.map(
        (e) {
          return e
              .usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario!.usu_uuid!;
        },
      ).toList(),
    );

    final ClientHttpResponseModel responseHttp = await clientHttpProvider.post(
      method: method,
      withToken: true,
      jsonData: insertPackageModel.toJson(),
    );

    if (responseHttp.statusCode == 201) {
      return PackageModel.fromJson(responseHttp.responseData);
    }

    HttpResponseExceptions(responseHttp).toString();
    return Future.value(null);
  }

  @override
  Future<void> updatePackageStatus(PackageModel package) async {
    var method = "/packages/${package.pac_uuid}/status";

    final f = DateFormat('yyyy-MM-dd hh:mm:ss');

    UpdatePackageStatusDTO updatePackageStatusDTO = UpdatePackageStatusDTO(
      status: package.pac_status!,
      approve_user_id:
          package.usuario_pacote_usu_id_aprovacao_fkTousuario!.usu_uuid!,
      approve_date: f.format(package.pac_dt_aprovacao!),
    );

    final ClientHttpResponseModel responseHttp = await clientHttpProvider.patch(
      method: method,
      withToken: true,
      jsonData: updatePackageStatusDTO.toJson(),
    );

    if (responseHttp.statusCode == 204) {
      return;
    }

    HttpResponseExceptions(responseHttp).toString();
    return Future.value(null);
  }

  @override
  Future<void> updatePackageUserPresenceStatus(
      PackageUsersModel packageUser) async {
    var method = "/packages/${packageUser.rel_pac_usu_uuid}/presence_status";

    final f = DateFormat('yyyy-MM-dd hh:mm:ss');

    UpdatePackageUserPresenceStatusDTO updatePackageUserPresenceStatusDTO =
        UpdatePackageUserPresenceStatusDTO(
      is_presence: packageUser.rel_pac_usu_presenca!,
      presence_user_id: packageUser
          .usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario!.usu_uuid!,
      presence_date: f.format(packageUser.rel_pac_usu_dt_presenca!),
    );

    final ClientHttpResponseModel responseHttp = await clientHttpProvider.patch(
      method: method,
      withToken: true,
      jsonData: updatePackageUserPresenceStatusDTO.toJson(),
    );

    if (responseHttp.statusCode == 204) {
      return;
    }

    HttpResponseExceptions(responseHttp).toString();
    return Future.value(null);
  }
}
