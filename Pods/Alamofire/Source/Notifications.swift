//
//  Notifications.swift
//
//  Copyright (c) 2014-2018 Alamofire Software Foundation (http://alamofire.org/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

extension Notification.Name {
    /// Posted when a `Request`'s task is resumed. The notification `object` contains the resumed `Request`.
    public static let afDidResume = Notification.Name(rawValue: "org.alamofire.notification.name.request.didResume")

    /// Posted when a `Request`'s task is suspended. The notification `object` contains the suspended `Request`.
    public static let afDidSuspend = Notification.Name(rawValue: "org.alamofire.notification.name.request.didSuspend")

    /// Posted when a `Request` is cancelled. The notification `object` contains the cancelled `Request`.
    public static let afDidCancel = Notification.Name(rawValue: "org.alamofire.notification.name.request.didCancel")

    /// Posted when a `Request`'s task is completed. The notification `object` contains the completed `Request`.
    public static let afDidComplete = Notification.Name(rawValue: "org.alamofire.notification.name.request.didComplete")
}

// MARK: -

extension Notification {
    /// The `Request` contained by `self`'s `userInfo`, `nil` otherwise.
    public var afRequest: Request? {
        return userInfo?[String.afRequestKey] as? Request
    }

    /// Convenience initializer for a `Notification` containing a `Request` payload.
    ///
    /// - Parameters:
    ///   - name:    The name of the notification.
    ///   - request: The `Request` payload.
    init(name: Notification.Name, request: Request) {
        self.init(name: name, object: nil, userInfo: [String.afRequestKey: request])
    }
}

extension NotificationCenter {
    /// Convenience function for posting notifications with `Request` payloads.
    ///
    /// - Parameters:
    ///   - name:    The name of the notification.
    ///   - request: The `Request` payload.
    func postNotification(named name: Notification.Name, with request: Request) {
        let notification = Notification(name: name, request: request)
        post(notification)
    }
}

extension String {
    /// User info dictionary key representing the `URLSessionTask` associated with the notification.
    static var afRequestKey: String { return "org.alamofire.notification.key.request" }
}

/// `EventMonitor` that provides Alamofire's notifications.
public final class AlamofireNotifications: EventMonitor {
    public func request(_ request: Request, didCompleteTask task: URLSessionTask, with error: Error?) {
        NotificationCenter.default.postNotification(named: .afDidComplete, with: request)
    }

    public func requestDidResume(_ request: Request) {
        NotificationCenter.default.postNotification(named: .afDidResume, with: request)
    }

    public func requestDidSuspend(_ request: Request) {
        NotificationCenter.default.postNotification(named: .afDidSuspend, with: request)
    }

    public func requestDidCancel(_ request: Request) {
        NotificationCenter.default.postNotification(named: .afDidCancel, with: request)
    }
}
