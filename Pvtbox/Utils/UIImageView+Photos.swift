/**
*  
*  Pvtbox. Fast and secure file transfer & sync directly across your devices. 
*  Copyright © 2020  Pb Private Cloud Solutions Ltd. 
*  
*  Licensed under the Apache License, Version 2.0 (the "License");
*  you may not use this file except in compliance with the License.
*  You may obtain a copy of the License at
*     http://www.apache.org/licenses/LICENSE-2.0
*  
*  Unless required by applicable law or agreed to in writing, software
*  distributed under the License is distributed on an "AS IS" BASIS,
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*  See the License for the specific language governing permissions and
*  limitations under the License.
*  
**/

import Foundation
import Photos

extension UIImageView {
    func loadWithLocalIdentifier(
        _ identifier: String,
        completion: @escaping (_ error: String?) -> ()) -> PHImageRequestID? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 1
        guard let asset = PHAsset.fetchAssets(
            withLocalIdentifiers: [identifier], options: fetchOptions)
            .firstObject else {
                completion("Asset not found")
                return nil
        }
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.deliveryMode = .opportunistic
        requestOptions.isNetworkAccessAllowed = true
        requestOptions.isSynchronous = false
        
        return PHImageManager.default().requestImage(
            for: asset,
            targetSize: frame.size,
            contentMode: .aspectFit,
            options: requestOptions,
            resultHandler: { [weak self] image, _ in
                self?.image = image
                completion(nil)
        })
    }
}
