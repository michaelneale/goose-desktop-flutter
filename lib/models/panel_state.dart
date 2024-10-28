enum PanelType {
  none,
  editingCode,
  confirmation,
  thinking,
}

class PanelState {
  final PanelType type;
  final String message;
  final String? details;

  const PanelState({
    this.type = PanelType.none,
    this.message = '',
    this.details,
  });

  PanelState copyWith({
    PanelType? type,
    String? message,
    String? details,
  }) {
    return PanelState(
      type: type ?? this.type,
      message: message ?? this.message,
      details: details ?? this.details,
    );
  }
}