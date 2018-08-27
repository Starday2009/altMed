//
//  LoginPage.swift
//  alt_medUITests
//
//  Created by Oksana Gorbachenko on 8/27/18.
//  Copyright © 2018 Oksana Gorbachenko. All rights reserved.
//
import Foundation
import XCTest

extension XCUIApplication {
    func loginButtonLog() -> XCUIElement {
        return self.buttons["Login"]
    }
    func emailFieldLog() -> XCUIElement {
        return self.textFields["Email"]
    }
    func passwordFieldLog() -> XCUIElement {
        return self.secureTextFields["Password"]
    }
}

class LoginPage {
    func enterUserName(username: String) {
        let emailFieldLog = XCUIApplication().emailFieldLog()
        emailFieldLog.tap()
        emailFieldLog.typeText(username)
    }
    func enterPassword(password: String) {
        let passwordFieldLog = XCUIApplication().passwordFieldLog()
        passwordFieldLog.tap()
        passwordFieldLog.typeText(password)
    }
    
    func clickLoginBtn() {
        XCUIApplication().loginButtonLog().tap()
    }

}
