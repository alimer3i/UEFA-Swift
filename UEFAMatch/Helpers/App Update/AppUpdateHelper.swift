//
//  RemoteConfig.swift
//  VirtualNumber
//
//  Created by Joe Maghzal on 24/05/2022.
//

import Foundation
import Firebase
import FirebaseRemoteConfig
import ObjectMapper

class AppUpdateHelper {
    static let shared = AppUpdateHelper()
    var version: String {
        let version = RemoteConfig.remoteConfig().configValue(forKey: "latestAppVersion").stringValue ?? ""
        if AppSettings.lastReceivedVersion != version {
            AppSettings.ignoresUpdates = false
        }
        AppSettings.lastReceivedVersion = version
        return version
    }
    var forceUpdate: Bool {
        return RemoteConfig.remoteConfig().configValue(forKey: "forceUpdate").boolValue
    }
    var isOutdated: Bool {
        return version.versionCompare(DeviceHelper.appVersion) == .orderedDescending
    }
    func fetchCloudValues(completion: @escaping () -> Void) {
        fetchAppStoreId()
        let config = RemoteConfigSettings()
        config.minimumFetchInterval = 0
        RemoteConfig.remoteConfig().configSettings = config
        RemoteConfig.remoteConfig().fetch { status, error in
            guard status == .success else {return}
            RemoteConfig.remoteConfig().activate { _, _ in
                _ = self.version
                completion()
            }
        }
    }
    func fetchAppStoreId(with completion: (() -> Void)? = nil) {
        guard let router = try? AppStoreAPI.appStoreId.asURLRequest() else {return}
        APIManager.shared.sessionManager.request(router)
            .validate()
            .response { data in
                guard let json = try? JSONSerialization.jsonObject(with: data.data ?? Data(), options: []) as? [String: Any], let responseBody = Mapper<AppStoreResults>().map(JSON: json),  let id = responseBody.results?.first?.trackId else {return}
                AppSettings.appStoreId = String(id)
                if let completion = completion {
                    completion()
                }
            }
    }
}

extension String {
    func versionCompare(_ otherVersion: String) -> ComparisonResult {
        let versionDelimiter = "."
        var versionComponents = self.components(separatedBy: versionDelimiter)
        var otherVersionComponents = otherVersion.components(separatedBy: versionDelimiter)
        let zeroDiff = versionComponents.count - otherVersionComponents.count
        if zeroDiff == 0 {
            return self.compare(otherVersion, options: .numeric)
        }else {
            let zeros = Array(repeating: "0", count: abs(zeroDiff))
            if zeroDiff > 0 {
                otherVersionComponents.append(contentsOf: zeros)
            }else {
                versionComponents.append(contentsOf: zeros)
            }
            return versionComponents.joined(separator: versionDelimiter)
                .compare(otherVersionComponents.joined(separator: versionDelimiter), options: .numeric)
        }
    }
}
