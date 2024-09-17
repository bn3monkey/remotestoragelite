import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:logger/logger.dart';
import 'package:remotestoragelite/src/core/util/circularbuffer/CircularBuffer.dart';
import 'package:remotestoragelite/src/core/util/values/enums/FileState.dart';
import 'package:remotestoragelite/src/core/util/values/results/AppResult.dart';
import 'package:remotestoragelite/src/data/source/LocalDataSource/LocalDataSource.dart';
import 'package:remotestoragelite/src/data/source/RemoteDataSource/RemoteDataSource.dart';
import 'package:remotestoragelite/src/domain/repositories/NetworkConnectionRepository.dart';

class NetworkConnectionRepositoryImpl extends NetworkConnectionRepository {
  LocalDataSource localDataSource;
  RemoteDataSource remoteDataSource;
  NetworkConnectionRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<String> findIPAddress() async {
    try {
      for (var interface in await NetworkInterface.list()) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
            return addr.address;
          }
        }
      }
    } catch (e) {
      print("Cannot find ipAddress");
    }
    return "";
  }

  @override
  // TODO: implement ipAddress
  String get ipAddress => _ipAddress;
  final String _ipAddress = "";

  @override
  // TODO: implement port
  String get port => _port;
  String _port = "2753";

  @override
  void savePort(String port) {
    _port = port;
  }

  FileState _currentState = FileState.idle;
  final CircularBuffer _buffer = CircularBuffer(65536);
  String _filename = "";
  int _filesize = 0;

  Future<FileState> _createFile(
      void Function(AppResult, String) onMessageReceived) async {
    final filenamebuffer = _buffer.read(128);
    if (filenamebuffer == null) return FileState.idle;

    _filename = utf8.decode(filenamebuffer);

    await localDataSource.open(localDataSource.storagePath, _filename);

    onMessageReceived(AppResult.fileCreate, _filename);
    Logger().d("filename : $_filename");

    return FileState.getFileSize;
  }

  Future<FileState> _getFileLength(
      void Function(AppResult, String) onMessageReceived) async {
    final filesizebuffer = _buffer.read(4);
    if (filesizebuffer == null) return FileState.getFileSize;
    final _filesizedata = filesizebuffer.buffer.asByteData();
    _filesize = _filesizedata.getInt32(0, Endian.little);
    onMessageReceived(AppResult.fileWrite, _filename);
    Logger().d("filename : $_filename filesize : $_filesize");
    return FileState.fileWritten;
  }

  Future<FileState> _receiveFileData(
      void Function(AppResult, String) onMessageReceived) async {
    final contentbuffer = _buffer.read(_filesize);
    if (contentbuffer == null) return FileState.fileWritten;

    await localDataSource.write(contentbuffer);
    onMessageReceived(AppResult.fileWrite, _filename);
    Logger().d("filename : $_filename filesize_saved : $_filesize");
    return FileState.fileClosed;
  }

  Future<FileState> _closeFile(
      void Function(AppResult, String) onMessageReceived) async {
    await localDataSource.close();
    onMessageReceived(AppResult.fileClose, _filename);
    Logger().d("filename : $_filename closed");
    return FileState.idle;
  }

  Future<void> _saveFile(Uint8List data,
      void Function(AppResult, String) onMessageReceived) async {
    Logger().d("Data Received (${data.length})");
    _buffer.write(data);

    if (_currentState == FileState.idle) {
      _currentState = await _createFile(onMessageReceived);
    }
    if (_currentState == FileState.getFileSize) {
      _currentState = await _getFileLength(onMessageReceived);
    }
    if (_currentState == FileState.fileWritten) {
      _currentState = await _receiveFileData(onMessageReceived);
    }
    if (_currentState == FileState.fileClosed) {
      _currentState = await _closeFile(onMessageReceived);
    }
    return;
  }

  void _resetFile(AppResult result, String message,
      void Function(AppResult, String) onMessageReceived) {
    _currentState = FileState.idle;
    _filesize = 0;
    _buffer.clear();
  }

  @override
  Future<bool> openNetworkConnection(
      int port, void Function(AppResult, String) onMessageReceived) async {
    return await remoteDataSource.open(port, (data) {
      _saveFile(data, onMessageReceived);
    }, (result, message) {
      _resetFile(result, message, onMessageReceived);
    }, onMessageReceived);
  }

  @override
  Future<void> closeNetworkConnection() async {
    await remoteDataSource.close();
  }
}
