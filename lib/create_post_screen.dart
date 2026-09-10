import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> with WidgetsBindingObserver {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  int _selectedCameraIndex = 0;
  bool _isCameraInitialized = false;

  File? _selectedFile;
  bool _isVideo = false;
  bool _isRecording = false;

  // Controls State
  bool _isFlashOn = false;
  bool _isGridOn = false;
  int _timerSeconds = 0;
  bool _isFilterOn = false;
  String _selectedMode = 'PHOTO'; // '3m', '60s', '15s', 'PHOTO', 'TEXT'
  String _selectedBottomTab = 'CAMERA'; // 'CAMERA', 'CREATE', 'LIVE'

  final ImagePicker _picker = ImagePicker();

@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addObserver(this);
  _initCamera();
}


  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        _selectedCameraIndex = 0;
        await _setupCamera(_cameras![_selectedCameraIndex]);
      }
    } catch (e) {
      debugPrint('Camera Init Error: $e');
    }
  }

  Future<void> _setupCamera(CameraDescription camera) async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
    }
    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: true,
    );

    try {
      await _cameraController!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Camera Controller Error: $e');
    }
  }

  void _toggleCamera() {
    if (_cameras == null || _cameras!.length < 2) return;
    _selectedCameraIndex = (_selectedCameraIndex == 0) ? 1 : 0;
    _setupCamera(_cameras![_selectedCameraIndex]);
  }

  void _toggleFlash() {
    if (_cameraController == null) return;
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
    _cameraController!.setFlashMode(
      _isFlashOn ? FlashMode.torch : FlashMode.off,
    );
  }

Future<void> _pickMedia([bool isVideo = false]) async {
  final XFile? file = isVideo
      ? await _picker.pickVideo(source: ImageSource.gallery)
      : await _picker.pickImage(source: ImageSource.gallery);

  if (file != null) {
    setState(() {
      _selectedFile = File(file.path);
      _isVideo = isVideo;
    });
  }
}


  Future<void> _handleShutterPress() async {
    if (_selectedFile != null) {
      setState(() => _selectedFile = null);
      return;
    }

    if (_selectedMode == 'PHOTO') {
      if (_cameraController != null && _cameraController!.value.isInitialized) {
        final image = await _cameraController!.takePicture();
        setState(() {
          _selectedFile = File(image.path);
          _isVideo = false;
        });
      }
    } else if (['3m', '60s', '15s'].contains(_selectedMode)) {
      if (_cameraController == null || !_cameraController!.value.isInitialized) return;

      if (_isRecording) {
        final video = await _cameraController!.stopVideoRecording();
        setState(() {
          _isRecording = false;
          _selectedFile = File(video.path);
          _isVideo = true;
        });
      } else {
        await _cameraController!.startVideoRecording();
        setState(() {
          _isRecording = true;
        });
      }
    }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  Widget _applyFilter(Widget child) {
    if (!_isFilterOn) return child;
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        0.2126, 0.7152, 0.0722, 0, 0,
        0.2126, 0.7152, 0.0722, 0, 0,
        0.2126, 0.7152, 0.0722, 0, 0,
        0,      0,      0,      1, 0,
      ]),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // --- 1. CAMERA PREVIEW / MEDIA PREVIEW ---
            Positioned.fill(
              child: _applyFilter(
                _selectedFile != null
                    ? Image.file(_selectedFile!, fit: BoxFit.cover)
                    : (_isCameraInitialized && _cameraController != null)
                        ? CameraPreview(_cameraController!)
                        : const Center(
                            child: CircularProgressIndicator(color: Colors.white),
                          ),
              ),
            ),

            // Grid Overlay
            if (_isGridOn && _selectedFile == null)
              Positioned.fill(
                child: Column(
                  children: [
                    Expanded(child: Row(children: [Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.white24)))), Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.white24)))), Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.white24))))])),
                    Expanded(child: Row(children: [Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.white24)))), Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.white24)))), Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.white24))))])),
                    Expanded(child: Row(children: [Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.white24)))), Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.white24)))), Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.white24))))])),
                  ],
                ),
              ),

            // --- 2. TOP CONTROL BAR ---
            Positioned(
              top: 12,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sound Picker Opened')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.music_note, color: Colors.white, size: 18),
                          SizedBox(width: 6),
                          Text('Add sound', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 28),
                ],
              ),
            ),

            // --- 3. RIGHT SIDE TOOLBAR ---
            Positioned(
              top: 12,
              right: 12,
              child: Column(
                children: [
                  _buildSideIcon(Icons.flip_camera_ios_outlined, 'Flip', _toggleCamera, false),
                  _buildSideIcon(_isFlashOn ? Icons.flash_on : Icons.flash_off, 'Flash', _toggleFlash, _isFlashOn),
                  _buildSideIcon(Icons.timer_outlined, _timerSeconds > 0 ? '${_timerSeconds}s' : 'Timer', () {
                    setState(() {
                      _timerSeconds = _timerSeconds == 0 ? 3 : (_timerSeconds == 3 ? 10 : 0);
                    });
                  }, _timerSeconds > 0),
                  _buildSideIcon(Icons.grid_on, 'Grid', () => setState(() => _isGridOn = !_isGridOn), _isGridOn),
                  _buildSideIcon(Icons.auto_awesome, 'Filter', () => setState(() => _isFilterOn = !_isFilterOn), _isFilterOn),
                ],
              ),
            ),

            // --- 4. BOTTOM SHUTTER & NAVIGATION BAR ---
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(bottom: 12, top: 12),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black87, Colors.transparent],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Camera Modes Line ('3m', '60s', '15s', 'PHOTO', 'TEXT')
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: ['3m', '60s', '15s', 'PHOTO', 'TEXT'].map((mode) {
                          bool isSelected = _selectedMode == mode;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedMode = mode),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: isSelected
                                  ? BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16))
                                  : null,
                              child: Text(
                                mode,
                                style: TextStyle(
                                  color: isSelected ? Colors.black : Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Shutter Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
        // Gallery Button
        GestureDetector(
          onTap: () => _pickMedia(false),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white, width: 2),
              color: Colors.grey[850],
            ),
            child: const Icon(Icons.photo_library, color: Colors.white, size: 24),
          ),
        ),

                        // Shutter Button (Click to Snap or Record)
                        GestureDetector(
                          onTap: _handleShutterPress,
                          child: Container(
                            width: 80,
                            height: 80,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _isRecording ? Colors.red : Colors.white,
                              ),
                              child: _selectedFile != null
                                  ? const Icon(Icons.refresh, color: Colors.black)
                                  : null,
                            ),
                          ),
                        ),

                        // Effects Button
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.grey[800],
                          child: const Icon(Icons.star, color: Colors.amber, size: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Navigation Modes ('CAMERA', 'CREATE', 'LIVE')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: ['CAMERA', 'CREATE', 'LIVE'].map((tab) {
                        bool isSelected = _selectedBottomTab == tab;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedBottomTab = tab),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              tab,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.white54,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSideIcon(
    IconData icon,
    String label,
    VoidCallback onTap, [
    bool isActive = false,
  ]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.amber : Colors.white,
              size: 28,
            ),
            if (label.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.amber : Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
  
