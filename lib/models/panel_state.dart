enum PanelType {
  none,
  editingCode,
  confirmation,
  thinking,
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
  }) : panels = panels ?? const [];

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