import 'package:flutter/material.dart';
import '../models/panel_state.dart';

class StatusPanel extends StatelessWidget {
  final PanelState state;

  const StatusPanel({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (state.type == PanelType.none) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _getPanelColor(state.type, colorScheme),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getPanelBorderColor(state.type, colorScheme),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _getPanelIcon(state.type, colorScheme),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.message,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
                if (state.details != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    state.details!,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (state.type == PanelType.confirmation) ...[
            const SizedBox(width: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // TODO: Handle confirmation
                  },
                  child: const Text('Confirm'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    // TODO: Handle cancel
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Color _getPanelColor(PanelType type, ColorScheme colorScheme) {
    switch (type) {
      case PanelType.editingCode:
        return colorScheme.primaryContainer.withOpacity(0.2);
      case PanelType.confirmation:
        return colorScheme.secondaryContainer.withOpacity(0.2);
      case PanelType.thinking:
        return colorScheme.surfaceVariant.withOpacity(0.2);
      default:
        return colorScheme.surface;
    }
  }

  Color _getPanelBorderColor(PanelType type, ColorScheme colorScheme) {
    switch (type) {
      case PanelType.editingCode:
        return colorScheme.primary.withOpacity(0.5);
      case PanelType.confirmation:
        return colorScheme.secondary.withOpacity(0.5);
      case PanelType.thinking:
        return colorScheme.outline;
      default:
        return colorScheme.outline;
    }
  }

  Widget _getPanelIcon(PanelType type, ColorScheme colorScheme) {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case PanelType.editingCode:
        iconData = Icons.code;
        iconColor = colorScheme.primary;
        break;
      case PanelType.confirmation:
        iconData = Icons.warning_rounded;
        iconColor = colorScheme.secondary;
        break;
      case PanelType.thinking:
        iconData = Icons.psychology;
        iconColor = colorScheme.primary;
        break;
      default:
        iconData = Icons.info;
        iconColor = colorScheme.primary;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 24,
      ),
    );
  }
}