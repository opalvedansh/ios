import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../shared/widgets/platform_scaffold.dart';
import '../../../../shared/widgets/platform_text_field.dart';
import '../../../../shared/widgets/platform_button.dart';
import '../../../../shared/widgets/gradient_scaffold.dart';
import '../../../../core/theme/app_theme.dart';
import '../../providers/complaint_provider.dart';

/// Create complaint screen
class CreateComplaintScreen extends ConsumerStatefulWidget {
  const CreateComplaintScreen({super.key});

  @override
  ConsumerState<CreateComplaintScreen> createState() =>
      _CreateComplaintScreenState();
}

class _CreateComplaintScreenState
    extends ConsumerState<CreateComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  String _category = 'missed_cleaning';
  final _descriptionController = TextEditingController();
  Uint8List? _selectedImageBytes;
  bool _isLoading = false;

  final List<Map<String, String>> _categories = [
    {'value': 'missed_cleaning', 'label': 'Missed Cleaning'},
    {'value': 'quality', 'label': 'Quality Issue'},
    {'value': 'behaviour', 'label': 'Staff Behaviour'},
    {'value': 'other', 'label': 'Other'},
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    // ImageSource.gallery uses the browser's file picker on web.
    // ImageSource.camera is not supported on web.
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: kIsWeb ? null : 70, // imageQuality is ignored on web
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      if (mounted) {
        setState(() {
          _selectedImageBytes = bytes;
        });
      }
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImageBytes = null;
    });
  }

  Future<void> _submitComplaint() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(complaintControllerProvider).createComplaint(
            category: _category,
            description: _descriptionController.text,
            imageBytes: _selectedImageBytes,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Complaint submitted successfully')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PlatformScaffold(
      title: 'Create Complaint',
      body: GradientScaffold(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Report an Issue',
                style: AppTheme.resolvedHeading2(context),
              ),
              const SizedBox(height: 8),
              Text(
                'We\'ll resolve your issue as soon as possible.',
                style: AppTheme.resolvedBodyMedium(context),
              ),
              const SizedBox(height: 24),
              Text(
                'Category',
                style: AppTheme.resolvedBodyLarge(context),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                items: _categories.map((cat) {
                  return DropdownMenuItem(
                    value: cat['value'],
                    child: Text(cat['label']!),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _category = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              PlatformTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Detailed description of the issue',
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Attach Photo (Optional)',
                style: AppTheme.resolvedBodyLarge(context),
              ),
              const SizedBox(height: 8),
              if (_selectedImageBytes != null)
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        _selectedImageBytes!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon:
                              const Icon(Icons.close, color: Colors.white),
                          onPressed: _removeImage,
                        ),
                      ),
                    ),
                  ],
                )
              else
                InkWell(
                  onTap: _pickImage,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark
                            ? AppTheme.darkShadowLight.withOpacity(0.5)
                            : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isDark
                          ? AppTheme.darkSurfaceElevated
                          : Colors.grey.shade50,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          kIsWeb ? Icons.upload_file_outlined : Icons.add_a_photo_outlined,
                          size: 32,
                          color: isDark
                              ? AppTheme.darkTextSecondary
                              : AppTheme.textSecondary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          kIsWeb ? 'Upload Photo' : 'Add Photo',
                          style: AppTheme.resolvedBodyMedium(context),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 32),
              PlatformButton(
                text: 'Submit Complaint',
                onPressed: _submitComplaint,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
