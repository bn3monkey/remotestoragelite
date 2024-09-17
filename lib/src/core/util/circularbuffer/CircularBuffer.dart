import 'dart:typed_data';

class CircularBuffer {
  final Uint8List _buffer;
  int _readIndex = 0;
  int _writeIndex = 0;
  int _size = 0;

  CircularBuffer(int capacity) : _buffer = Uint8List(capacity);

  // 버퍼에 데이터를 추가 (memcpy 유사 방식으로 데이터 복사)
  bool write(Uint8List data) {
    int available = availableSpace();
    if (data.length > available) {
      return false; // 남은 공간이 부족하면 실패
    }

    int firstPartLength = _buffer.length - _writeIndex; // 첫 부분에 남은 공간
    if (data.length <= firstPartLength) {
      // 데이터를 한 번에 복사할 수 있으면 setRange 사용
      _buffer.setRange(_writeIndex, _writeIndex + data.length, data);
    } else {
      // 데이터를 두 번 나누어 복사해야 하는 경우
      _buffer.setRange(_writeIndex, _writeIndex + firstPartLength,
          data.sublist(0, firstPartLength));
      _buffer.setRange(
          0, data.length - firstPartLength, data.sublist(firstPartLength));
    }

    _writeIndex = (_writeIndex + data.length) % _buffer.length;
    _size += data.length;
    return true;
  }

  // 원하는 길이만큼 데이터를 소비 (읽기)
  Uint8List? read(int length) {
    if (length > _size) {
      return null; // 남은 데이터보다 많이 읽으려 하면 실패
    }

    Uint8List result = Uint8List(length);

    int firstPartLength = _buffer.length - _readIndex; // 첫 부분에 남은 데이터
    if (length <= firstPartLength) {
      result.setRange(
          0, length, _buffer.sublist(_readIndex, _readIndex + length));
    } else {
      result.setRange(0, firstPartLength,
          _buffer.sublist(_readIndex, _readIndex + firstPartLength));
      result.setRange(firstPartLength, length,
          _buffer.sublist(0, length - firstPartLength));
    }

    _readIndex = (_readIndex + length) % _buffer.length;
    _size -= length;
    return result;
  }

  // 현재 버퍼에 남은 데이터 크기
  int availableData() => _size;

  // 남은 공간 크기
  int availableSpace() => _buffer.length - _size;

  // 버퍼가 꽉 찼는지 확인
  bool isFull() => _size == _buffer.length;

  void clear() {
    _readIndex = 0;
    _writeIndex = 0;
    _size = 0;
  }
}
