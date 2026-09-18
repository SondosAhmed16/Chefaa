import 'dart:io';
import 'package:chefaa/core/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart' as fp;

class CustomFilePicker extends StatelessWidget {
  final File? selectedFile;
  final String label;
  final Function(File file) onFileSelected;
  final VoidCallback? onFileRemoved;

  const CustomFilePicker({
    super.key,
    required this.selectedFile,
    required this.label,
    required this.onFileSelected,
    this.onFileRemoved,
  });

  Future<void> _pickFile() async {
    final result = await fp.FilePicker.platform.pickFiles(
      type: fp.FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );

    if (result != null && result.files.single.path != null) {
      onFileSelected(File(result.files.single.path!));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedFile != null) {
      final fileName = selectedFile!.path.split('/').last;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.primary),
          borderRadius: BorderRadius.circular(12),
          color: ColorManager.primary.withOpacity(0.05),
        ),
        child: Row(
          children: [
            Image.asset("assets/images/pdf.png", width: 32, height: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                fileName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: onFileRemoved,
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: _pickFile,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/backup.png", width: 32, height: 32),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
