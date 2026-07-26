import Foundation

/// 信令消息统一模型。与 signaling-server/server.js 协议保持一致。
enum SignalingMessage: Equatable {
    case registered(userId: String)
    case kicked(reason: String)
    case incomingCall(from: String, media: String)
    case ringing(from: String)
    case accept(from: String)
    case reject(from: String, reason: String?)
    case offer(from: String, sdp: String)
    case answer(from: String, sdp: String)
    case ice(from: String, candidate: [String: Any])
    case hangup(from: String)
    case error(reason: String?, originalType: String?)
    case unknown(type: String)
}

extension SignalingMessage {
    /// 从原始 JSON 字典解析为强类型消息
    static func from(dict: [String: Any]) -> SignalingMessage {
        let type = dict["type"] as? String ?? ""
        let from = dict["from"] as? String ?? ""
        switch type {
        case "registered":
            return .registered(userId: dict["userId"] as? String ?? "")
        case "kicked":
            return .kicked(reason: dict["reason"] as? String ?? "")
        case "call":
            return .incomingCall(from: from, media: dict["media"] as? String ?? "video")
        case "ringing":
            return .ringing(from: from)
        case "accept":
            return .accept(from: from)
        case "reject":
            return .reject(from: from, reason: dict["reason"] as? String)
        case "offer":
            return .offer(from: from, sdp: dict["sdp"] as? String ?? "")
        case "answer":
            return .answer(from: from, sdp: dict["sdp"] as? String ?? "")
        case "ice":
            let candidate = dict["candidate"] as? [String: Any] ?? [:]
            return .ice(from: from, candidate: candidate)
        case "hangup":
            return .hangup(from: from)
        case "error":
            return .error(reason: dict["reason"] as? String, originalType: dict["originalType"] as? String)
        default:
            return .unknown(type: type)
        }
    }
}
