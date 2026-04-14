import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:my_app_flutter/core/constants/colors.dart';
import 'package:my_app_flutter/shared/widgets/glass_card.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  // In a real app, initialize CameraController here
  bool _isDetecting = false;
  String _detectedText = "Waiting for gesture...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Mock Camera Preview
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Center(
              child: Icon(LucideIcons.camera, color: AppColors.textMuted.withOpacity(0.3), size: 100),
            ),
          ),

          // Positioning Guide Overlay
          Center(
            child: Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(width: 20, height: 20, decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white, width: 2), left: BorderSide(color: Colors.white, width: 2)))),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(width: 20, height: 20, decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white, width: 2), right: BorderSide(color: Colors.white, width: 2)))),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(width: 20, height: 20, decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white, width: 2), left: BorderSide(color: Colors.white, width: 2)))),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(width: 20, height: 20, decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white, width: 2), right: BorderSide(color: Colors.white, width: 2)))),
                  ),
                ],
              ),
            ),
          ),

          // Top Controls
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(LucideIcons.x, color: Colors.white),
                  style: IconButton.styleFrom(backgroundColor: Colors.black45),
                ),
                GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  borderRadius: 20,
                  child: const Row(
                    children: [
                      Icon(LucideIcons.zap, color: AppColors.accent, size: 16),
                      SizedBox(width: 8),
                      Text('High Accuracy', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Translation Preview
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                GlassCard(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'DETECTED TEXT',
                        style: TextStyle(color: AppColors.textMuted, fontSize: 10, letterSpacing: 1.2),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isDetecting ? 'Hello, world!' : _detectedText,
                        style: const TextStyle(color: AppColors.text, fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCircleOp(LucideIcons.history, () {}),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDetecting = !_isDetecting;
                        });
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: _isDetecting ? Colors.red : Colors.white,
                              shape: _isDetecting ? BoxShape.rectangle : BoxShape.circle,
                              borderRadius: _isDetecting ? BorderRadius.circular(8) : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _buildCircleOp(LucideIcons.refreshCw, () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleOp(IconData icon, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white, size: 24),
      style: IconButton.styleFrom(
        backgroundColor: Colors.black45,
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}
