//
//  AppLoginAuth.swift
//  Created on 2023/11/8
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2023 WZLY. All rights reserved.
//  @author 邱啟祥(739140860@qq.com)   
//

import UIKit
import AuthenticationServices

/// 登录
@available(iOS 13,*)
public class AppleLoginAuth: NSObject {
    
    // 返回类型
    public enum ResultType {
        case IDCredential(data: ASAuthorizationAppleIDCredential)
        case PWCredential(data: ASPasswordCredential)
    }
    
    public typealias AppleLoginAuthSucesshandler = (_ result: ResultType) -> Void
    public typealias AppleLoginAuthFailHandler = (_ error: Error) -> Void
    
    var sucessHandler: AppleLoginAuthSucesshandler?
    var failHandler: AppleLoginAuthFailHandler?
    
    /// 检测是否授权成功
    func check(userIdentifier: String, compleBlock: ((_ isAuthorized: Bool)->Void)?){
        // 保存的  ASAuthorizationCredential.user 信息
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                compleBlock?(true)
                break 
            case .revoked, .notFound:
                DispatchQueue.main.async {
                    compleBlock?(false)
                }
            default:
                compleBlock?(false)
                break
            }
        }
    }
    
    // 开启登录
    public func handleAuthorizationAppleIDButtonPress(sucess: AppleLoginAuthSucesshandler?, fail: AppleLoginAuthFailHandler?) {

        sucessHandler = sucess
        failHandler = fail
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

// MARK - ASAuthorizationControllerDelegate
@available(iOS 13, *)
extension AppleLoginAuth: ASAuthorizationControllerDelegate {

    public func authorizationController(controller: ASAuthorizationController,
          didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user // 保存一下, 用于校验登录状态
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            guard let token = appleIDCredential.identityToken else {
                failHandler?(NSError(domain: "授权失败， token返回空", code: -1201))
                break
            }
            sucessHandler?(.IDCredential(data: appleIDCredential))
            break
        case let passwordCredential as ASPasswordCredential:
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            sucessHandler?(.PWCredential(data: passwordCredential))
            
        default:
            failHandler?(NSError(domain: "授权失败", code: -1200))
            break
        }
    }

        /// - Tag: did_complete_error
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            // Handle error.
        failHandler?(error)
    }
}

/// MARK: ASAuthorizationControllerPresentationContextProviding
@available(iOS 13, *)
extension AppleLoginAuth: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.keyWindow!
    }
}
