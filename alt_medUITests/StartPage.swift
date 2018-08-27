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
    func registerButtonPage() -> XCUIElement {
        return self.buttons["Registration"]
    }
    func loginButtonPage() -> XCUIElement {
        return self.buttons["Login"]
    }
    
   
}

class StartPage {
    
    func clickRegisterBtn() {
        XCUIApplication().registerButtonPage().tap()
    }
    func clickLoginBtn() {
        XCUIApplication().loginButtonPage().tap()
    }
    
}
