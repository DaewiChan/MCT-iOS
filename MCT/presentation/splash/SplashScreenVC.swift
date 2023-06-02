//
//  SplashScreenVC.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//
import Foundation
import UIKit

class SplashScreenVC: UIViewController {
    private var observation: NSKeyValueObservation?
    private var timer = Timer()
    
    var currentProgressBar: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switchView()
    }
    

    deinit{
        observation?.invalidate()
        timer.invalidate()
    }
    
    func switchView() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            let isLogin = PrefHelper.shared.getPrefValueBool(PrefKey.IS_LOGIN)
            if isLogin {
                let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as! MainVC
                mainVC.modalPresentationStyle = .fullScreen
                let appDel = (UIApplication.shared.delegate as! AppDelegate)
                appDel.window?.rootViewController = mainVC
            }else {
                let loginVC = UIStoryboard(name: "Account", bundle: nil).instantiateViewController(withIdentifier: "login") as! LoginVC
                loginVC.modalPresentationStyle = .fullScreen
                let appDel = (UIApplication.shared.delegate as! AppDelegate)
                appDel.window?.rootViewController = loginVC
            }
        }
    }
    

}
