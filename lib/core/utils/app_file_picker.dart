import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:kailasha/core/utils/common_enums.dart';

class PickedFile {
  final String name;
  final String? path;
  final String? extension;
  final Uint8List bytes;
  final int size;
  final String? mimeType;

  PickedFile({
    required this.name,
    required this.bytes,
    required this.size,
    this.path,
    this.extension,
    this.mimeType,
  });
}

class FilePickResult {
  final FilePickStatus status;
  final List<PickedFile> files;
  final String? message;

  const FilePickResult({
    required this.status,
    this.files = const [],
    this.message,
  });

  bool get isSuccess => status == FilePickStatus.success;
  bool get isCancelled => status == FilePickStatus.cancelled;
}

// =======================================================
// ===================  UTILITY CLASS  ===================
// =======================================================

class AppFilePicker {
  AppFilePicker._();

  // basic extension → mime lookup table
  static const Map<String, String> _mimeMap = {
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'gif': 'image/gif',
    'webp': 'image/webp',
    'heic': 'image/heic',
    'pdf': 'application/pdf',
    'txt': 'text/plain',
    'csv': 'text/csv',
    'json': 'application/json',
    'mp4': 'video/mp4',
    'mp3': 'audio/mpeg',
  };

  static String? _inferMimeFromExtension(String? ext) {
    if (ext == null) return null;
    final lower = ext.toLowerCase();
    return _mimeMap[lower];
  }

  static Future<FilePickResult> pick({
    FileType type = FileType.any,
    bool allowMultiple = false,
    List<String>? allowedExtensions,
    bool withData = true,
    bool forceLoadData = true,

    // Validation
    int? maxFileSizeInBytes,
    int? minFileSizeInBytes,
    List<String>? allowedMimeTypes,

    // Optional transform pipeline
    Future<Uint8List> Function(Uint8List bytes)? transformer,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: type,
        allowMultiple: allowMultiple,
        allowedExtensions: allowedExtensions,
        withData: withData,
      );

      if (result == null) {
        return const FilePickResult(
          status: FilePickStatus.cancelled,
          message: 'User cancelled file selection',
        );
      }

      final List<PickedFile> pickedFiles = [];

      for (final file in result.files) {
        Uint8List? bytes = file.bytes;

        if (bytes == null && forceLoadData && file.path != null) {
          bytes = await File(file.path!).readAsBytes();
        }

        if (bytes == null) continue;

        final size = bytes.lengthInBytes;

        // ------ infer mime safely (version-proof) ------
        final inferredMime = _inferMimeFromExtension(file.extension);

        // ---------- VALIDATION ----------

        if (maxFileSizeInBytes != null && size > maxFileSizeInBytes) {
          return FilePickResult(
            status: FilePickStatus.validationFailed,
            message:
                'File exceeds maximum allowed size of $maxFileSizeInBytes bytes',
          );
        }

        if (minFileSizeInBytes != null && size < minFileSizeInBytes) {
          return FilePickResult(
            status: FilePickStatus.validationFailed,
            message:
                'File is smaller than minimum allowed size of $minFileSizeInBytes bytes',
          );
        }

        if (allowedMimeTypes != null &&
            inferredMime != null &&
            !allowedMimeTypes.contains(inferredMime)) {
          return FilePickResult(
            status: FilePickStatus.validationFailed,
            message: 'Unsupported file type: $inferredMime',
          );
        }

        if (transformer != null) {
          bytes = await transformer(bytes);
        }

        pickedFiles.add(
          PickedFile(
            name: file.name,
            bytes: bytes,
            size: size,
            path: file.path,
            extension: file.extension,
            mimeType: inferredMime,
          ),
        );
      }

      return FilePickResult(status: FilePickStatus.success, files: pickedFiles);
    } catch (e) {
      return FilePickResult(
        status: FilePickStatus.error,
        message: e.toString(),
      );
    }
  }
}
