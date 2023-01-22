// Autogenerated from Pigeon (v7.0.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif



private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: FlutterError) -> [Any?] {
  return [
    error.code,
    error.message,
    error.details
  ]
}

/// Generated class from Pigeon that represents data sent in messages.
struct LatLng {
  var latitude: Double
  var longitude: Double

  static func fromList(_ list: [Any?]) -> LatLng? {
    let latitude = list[0] as! Double
    let longitude = list[1] as! Double

    return LatLng(
      latitude: latitude,
      longitude: longitude
    )
  }
  func toList() -> [Any?] {
    return [
      latitude,
      longitude,
    ]
  }
}

private class PluginHostApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return LatLng.fromList(self.readValue() as! [Any])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class PluginHostApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? LatLng {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class PluginHostApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return PluginHostApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return PluginHostApiCodecWriter(data: data)
  }
}

class PluginHostApiCodec: FlutterStandardMessageCodec {
  static let shared = PluginHostApiCodec(readerWriter: PluginHostApiCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol PluginHostApi {
  func asy(msg: LatLng, completion: @escaping (LatLng) -> Void)
  func sy(msg: LatLng) -> LatLng
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class PluginHostApiSetup {
  /// The codec used by PluginHostApi.
  static var codec: FlutterStandardMessageCodec { PluginHostApiCodec.shared }
  /// Sets up an instance of `PluginHostApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: PluginHostApi?, id: Int64?) {
    let asyChannel = FlutterBasicMessageChannel(name: "pro.flown.PluginHostApi_$id.asy", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      asyChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let msgArg = args[0] as! LatLng
        api.asy(msg: msgArg) { result in
          reply(wrapResult(result))
        }
      }
    } else {
      asyChannel.setMessageHandler(nil)
    }
    let syChannel = FlutterBasicMessageChannel(name: "pro.flown.PluginHostApi_$id.sy", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      syChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let msgArg = args[0] as! LatLng
        let result = api.sy(msg: msgArg)
        reply(wrapResult(result))
      }
    } else {
      syChannel.setMessageHandler(nil)
    }
  }
}
private class PluginFlutterApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return LatLng.fromList(self.readValue() as! [Any])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class PluginFlutterApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? LatLng {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class PluginFlutterApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return PluginFlutterApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return PluginFlutterApiCodecWriter(data: data)
  }
}

class PluginFlutterApiCodec: FlutterStandardMessageCodec {
  static let shared = PluginFlutterApiCodec(readerWriter: PluginFlutterApiCodecReaderWriter())
}

/// Generated class from Pigeon that represents Flutter messages that can be called from Swift.
class PluginFlutterApi {
  private let binaryMessenger: FlutterBinaryMessenger
  private let id: Int64?
  init(binaryMessenger: FlutterBinaryMessenger, id: Int64?){
    self.binaryMessenger = binaryMessenger
    self.id = id
  }
  var codec: FlutterStandardMessageCodec {
    return PluginFlutterApiCodec.shared
  }
  func asy(msg msgArg: LatLng, completion: @escaping (LatLng) -> Void) {
    let channel = FlutterBasicMessageChannel(name: "pro.flown.PluginFlutterApi_$id.asy", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([msgArg] as [Any?]) { response in
      let result = response as! LatLng
      completion(result)
    }
  }
  func sy(msg msgArg: LatLng, completion: @escaping (LatLng) -> Void) {
    let channel = FlutterBasicMessageChannel(name: "pro.flown.PluginFlutterApi_$id.sy", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([msgArg] as [Any?]) { response in
      let result = response as! LatLng
      completion(result)
    }
  }
}
