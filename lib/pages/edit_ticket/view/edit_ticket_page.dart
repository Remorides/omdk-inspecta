import 'dart:html' as web;

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:omdk_inspecta/common/enums/enums.dart';
import 'package:omdk_inspecta/elements/alerts/alerts.dart';
import 'package:omdk_inspecta/elements/elements.dart';
import 'package:omdk_inspecta/pages/edit_ticket/bloc/edit_ticket_bloc.dart';
import 'package:omdk_opera_api/omdk_opera_api.dart';
import 'package:omdk_opera_repo/omdk_opera_repo.dart';
import 'package:omdk_repo/omdk_repo.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

part 'edit_ticket_view.dart';

/// Login page builder
class EditTicketPage extends StatelessWidget {
  /// Create [EditTicketPage] instance
  EditTicketPage({super.key});

  /// Global route of login page
  static Route<void> route() {
    return CupertinoPageRoute<void>(builder: (_) => EditTicketPage());
  }

  //Get params from url
  final _paramGUID = Uri.base.queryParameters['guid'];
  final _paramClose = Uri.base.queryParameters['close'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditTicketBloc(
        scheduledRepo: context.read<EntityRepo<ScheduledActivity>>(),
        mappingRepo: context.read<EntityRepo<MappingVersion>>(),
        operaUtils: context.read<OperaUtils>(),
      )..add(CheckStateTicket(guid: _paramGUID)),
      child: _EditTicketView(
        closePage: _paramClose != null,
      ),
    );
  }
}
