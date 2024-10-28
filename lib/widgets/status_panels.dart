import 'package:flutter/material.dart';
import '../models/panel_state.dart';

class StatusPanel extends StatelessWidget {
  final PanelState state;
  final Function(int)? onPanelDismiss;

  const StatusPanel({
    super.key, 
    required this.state,
    this.onPanelDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        itemCount: state.panels.isEmpty ? 1 : state.panels.length,
        itemBuilder: (context, index) {
          if (state.panels.isEmpty) {
            return _buildEmptyState(context);
          }
          return _buildPanel(context, state.panels[index], index);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(24.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline_rounded,
              size: 48,
              color: colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No active panels',
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanel(BuildContext context, PanelItem panel, int index) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey('panel_$index'),
      onDismissed: (_) => onPanelDismiss?.call(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: _getPanelColor(panel.type, colorScheme),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _getPanelBorderColor(panel.type, colorScheme),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            _getPanelIcon(panel.type, colorScheme),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    panel.message,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  if (panel.details != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      panel.details!,
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (panel.type == PanelType.confirmation) ...[
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
                      onPanelDismiss?.call(index);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ],
        ),
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