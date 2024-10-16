import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omdk_inspecta/elements/elements.dart';
import 'package:omdk_inspecta/elements/radio_buttons/multi_radio_buttons/multi_radio_button.dart';
import 'package:omdk_repo/omdk_repo.dart';

class MultiRadioButtons extends StatelessWidget {
  const MultiRadioButtons({
    required this.labelText,
    this.focusNode,
    super.key,
    this.cubit,
    this.nextFocusNode,
    this.isEnabled = true,
    this.onSelectedPriority,
    this.indexSelectedRadio,
  });

  final String labelText;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool isEnabled;
  final MrbCubit? cubit;
  final int? indexSelectedRadio;
  final void Function(int?)? onSelectedPriority;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          cubit ??
          MrbCubit(
            isEnabled: isEnabled,
            selected: indexSelectedRadio,
          ),
      child: _MultiRadioButtons(
        labelText: labelText,
        onSelectedPriority: onSelectedPriority,
        focusNode: focusNode,
        nextFocusNode: nextFocusNode,
      ),
    );
  }
}

class _MultiRadioButtons extends StatelessWidget {
  const _MultiRadioButtons({
    required this.labelText,
    required this.focusNode,
    this.onSelectedPriority,
    this.nextFocusNode,
  });

  final String labelText;
  final void Function(int?)? onSelectedPriority;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  @override
  Widget build(BuildContext context) {
    final state = context.select((MrbCubit cubit) => cubit.state);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  labelText.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme?.textTheme.labelLarge?.copyWith(
                    color: context.theme?.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          Opacity(
            opacity: (!state.isEnabled) ? 0.5 : 1,
            child: AbsorbPointer(
              absorbing: !state.isEnabled,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: (MediaQuery.of(context).size.width / 3) < 480
                    ? Column(
                  children: [
                    highButton(context, state),
                    mediumButton(context, state),
                    lowButton(context, state),
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    highButton(context, state),
                    mediumButton(context, state),
                    lowButton(context, state),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget highButton(BuildContext context, MrbState state) => SizedBox(
        width: 150,
        child: RadioListTile<String>(
          title: const Text(
            'HIGH',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
          activeColor: context.theme?.primaryColor,
          value: '3',
          shape: const RoundedRectangleBorder(),
          controlAffinity: ListTileControlAffinity.trailing,
          groupValue: state.selectedRadio.toString(),
          onChanged: (value) {
            context.read<MrbCubit>().switchRadio(int.parse(value!));
            onSelectedPriority?.call(3);
          },
        ),
      );

  Widget mediumButton(BuildContext context, MrbState state) => SizedBox(
        width: 150,
        child: RadioListTile<String>(
          title: const Text(
            'MEDIUM',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.w600,
            ),
          ),
          activeColor: context.theme?.primaryColor,
          value: '2',
          shape: const RoundedRectangleBorder(),
          controlAffinity: ListTileControlAffinity.trailing,
          groupValue: state.selectedRadio.toString(),
          onChanged: (value) {
            context.read<MrbCubit>().switchRadio(int.parse(value!));
            onSelectedPriority?.call(2);
          },
        ),
      );

  Widget lowButton(BuildContext context, MrbState state) => SizedBox(
        width: 150,
        child: RadioListTile<String>(
          title: const Text(
            'LOW',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
          activeColor: context.theme?.primaryColor,
          value: '1',
          shape: const RoundedRectangleBorder(),
          controlAffinity: ListTileControlAffinity.trailing,
          groupValue: state.selectedRadio.toString(),
          onChanged: (value) {
            context.read<MrbCubit>().switchRadio(int.parse(value!));
            onSelectedPriority?.call(1);
          },
        ),
      );
}
