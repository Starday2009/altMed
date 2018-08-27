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
    func registerButtonRegist() -> XCUIElement {
        return self.buttons["Register"]
    }
    func emailFieldRegist() -> XCUIElement {
        return self.textFields["Email"]
    }
    func passwordFieldRegist() -> XCUIElement {
        return self.secureTextFields["Password"]
    }
}

class RegisterPage {
    func enterUserName(username: String) {
        let emailFieldRegist = XCUIApplication().emailFieldRegist()
        emailFieldRegist.tap()
        emailFieldRegist.typeText(username)
    }
    func enterPassword(password: String) {
        let passwordFieldRegist = XCUIApplication().passwordFieldRegist()
        passwordFieldRegist.tap()
        passwordFieldRegist.typeText(password)
    }
    
    func clickRegisterBtn() {
        XCUIApplication().registerButtonRegist().tap()
    }

}
