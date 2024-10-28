import 'package:flutter/material.dart';
import 'models/panel_state.dart';
import 'widgets/status_panels.dart';

void main() {
  runApp(const GooseDesktopApp());
}

class GooseDesktopApp extends StatelessWidget {
  const GooseDesktopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goose Desktop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4), // Purple primary color
          brightness: Brightness.dark,
          secondary: const Color(0xFF03DAC6), // Teal accent
          surface: const Color(0xFF1C1B1F),
          background: const Color(0xFF121212),
        ),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2C2C2C),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF3C3C3C)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF3C3C3C)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF6750A4), width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  PanelState _panelState = PanelState();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSendMessage() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _panelState = _panelState.addPanel(
          type: PanelType.thinking,
          message: _textController.text,
        );
      });
      _textController.clear();
    }
  }

  void _handlePanelDismiss(int index) {
    setState(() {
      _panelState = _panelState.removePanel(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      body: Column(
        children: [
          // Input area at the top
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                    style: const TextStyle(fontSize: 16),
                    maxLines: 3,
                    minLines: 1,
                    onSubmitted: (_) => _handleSendMessage(),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _handleSendMessage,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Send'),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.send_rounded,
                        size: 18,
                        color: colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Panel display area (replaces chat history)
          StatusPanel(
            state: _panelState,
            onPanelDismiss: _handlePanelDismiss,
          ),
        ],
      ),
    );
  }
}