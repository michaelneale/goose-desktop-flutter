enum PanelType {
  none,
  editingCode,
  confirmation,
  thinking,
  looking,
  browsing,
  pullRequest,
  installation,
}

class PanelItem {
  final PanelType type;
  final String message;
  final String? details;

  const PanelItem({
    required this.type,
    required this.message,
    this.details,
  });
}

class PanelState {
  final List<PanelItem> panels;

  const PanelState({
    List<PanelItem>? panels,
  }) : panels = panels ?? const [
    // Default panels if none provided
    PanelItem(
      type: PanelType.looking,
      message: 'Looking at screen',
      details: 'Analyzing current application state and UI components',
    ),
    PanelItem(
      type: PanelType.browsing,
      message: 'Browsing company knowledge base',
      details: 'Searching for relevant documentation and best practices',
    ),
    PanelItem(
      type: PanelType.editingCode,
      message: 'Preparing to update authentication module',
      details: 'Found relevant files: auth_service.dart, user_model.dart',
    ),
    PanelItem(
      type: PanelType.pullRequest,
      message: 'Ready to open pull request',
      details: 'Changes prepared for review. Would you like to create the PR?',
    ),
    PanelItem(
      type: PanelType.installation,
      message: 'Package installation required',
      details: 'New dependencies needed. Would you like to proceed with installation?',
    ),
  ];

  PanelState copyWith({
    List<PanelItem>? panels,
  }) {
    return PanelState(
      panels: panels ?? this.panels,
    );
  }

  PanelState addPanel({
    required PanelType type,
    required String message,
    String? details,
  }) {
    return PanelState(
      panels: [
        ...panels,
        PanelItem(
          type: type,
          message: message,
          details: details,
        ),
      ],
    );
  }

  PanelState removePanel(int index) {
    if (index < 0 || index >= panels.length) return this;
    return PanelState(
      panels: [
        ...panels.sublist(0, index),
        ...panels.sublist(index + 1),
      ],
    );
  }
}