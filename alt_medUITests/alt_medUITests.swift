//
//  alt_medUITests.swift
//  alt_medUITests
//
//  Created by Oksana Gorbachenko on 1/21/18.
//  Copyright © 2018 Oksana Gorbachenko. All rights reserved.
//

import XCTest

class alt_medUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
//    func testAAnEmail(){
//       let app = XCUIApplication()
//
//
//        let registerButton = app.buttons["Register"]
//        registerButton.tap()
//
//        let emailTextField = app.textFields["Email"]
//        emailTextField.tap()
//        emailTextField.typeText("oksana1@mail.com")
//
//
//        let passwordSecureTextField = app.secureTextFields["Password"]
//        passwordSecureTextField.tap()
//        passwordSecureTextField.typeText("qwerty")
//        app.buttons["Regirter"].tap()
//
//        app.navigationBars["alt_med.RegisterView"].buttons["App Launch screen"].tap()
//
//        let loginButton = app.buttons["Login"]
//        loginButton.tap()
//        emailTextField.tap()
//        emailTextField.typeText("oksana1@mail.com")
//
//        passwordSecureTextField.tap()
//        passwordSecureTextField.typeText("qwerty")
//        loginButton.tap()
//        assertNavigationBar(title: "Все клиенты", "Отсутсвует навигейшен бар Все клиенты")
//
//
//    }
    
    func testAddClient() {
        let app = XCUIApplication()
        assertNavigationBar(title: "Все клиенты", "Отсутсвует навигейшен бар Все клиенты")
        app.navigationBars["Все клиенты"].buttons["Add"].tap()
        app.alerts["Добавление клиента"].textFields["Введите имя"].typeText("Аня")
        app.alerts["Добавление клиента"].buttons["Add"].tap()
        app.tables.staticTexts["Аня"].tap()
        app.navigationBars["Аня"].buttons["Все клиенты"].tap()
        //swipe and delete
        app.tables.staticTexts["Аня"].swipeLeft()
        //delete button for any table item
        let deleteButton = app.tables.buttons["Delete"]
        deleteButton.tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAddOrder() {
        //my app and calendar
        let app = XCUIApplication()
        let calendarApp = XCUIApplication(bundleIdentifier: "com.apple.mobilecal")
        
       assertNavigationBar(title: "Все клиенты", "Отсутсвует навигейшен бар Все клиенты")
        //array with table items

        app.navigationBars["Все клиенты"].buttons["Add"].tap()
        app.alerts["Добавление клиента"].textFields["Введите имя"].typeText("TestName")
        app.alerts["Добавление клиента"].buttons["Add"].tap()
        
        
            let tablesQuery = app.tables.cells
            tablesQuery.element(boundBy: 0).tap()
        
        //tap to add button in nav bar
        let addButton =  app.navigationBars.buttons["Add"];
        XCTAssert(addButton.isHittable, "Кнопка addButton не тапабельна")
        addButton.tap()
        app.alerts["Запись клиента"].textFields["Название процедуры"].typeText("Маска")
        app.alerts["Запись клиента"].textFields["Дата проведения"].tap()
        
        let screenShot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenShot, quality: .low)
        attachment.lifetime = .keepAlways  // Сохранять скриншот, даже если тест успешно прошел
        add(attachment)
        
        app.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "May 29")
        app.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "6")
        app.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "10")
        
        app.alerts["Запись клиента"].buttons["Add Item"].tap()
//        app.alerts["“AltMed” Would Like to Access Your Calendar"].buttons["OK"].tap()
//
//
//        //swipe left and delete
        app.tables.staticTexts["Маска"].swipeLeft()
        let deleteButton = app.tables.buttons["Delete"]
        deleteButton.tap()
        //tap to home button
        XCUIDevice.shared.press(.home);
        // check if event is in calendar
//
        calendarApp.launch()
        let event = calendarApp.buttons["Запись клиента Аня, from 6:10 PM to 8:33 PM"]
        XCTAssert(event.exists)
        
        // delete event
        event.tap()
        calendarApp.toolbars.buttons["Delete Event"].tap()
        calendarApp.sheets.buttons["Delete Event"].tap()
//
    }
    
    func assertNavigationBar(title: String, _ message: String = "", file: StaticString = #file, line: UInt = #line) {
//        XCTAssert(app.navigationBars[title].exists, message, file: file, line: line)
//        XCTAssert(false, message, file: file, line: line)
        let app = XCUIApplication()
        let allClientsButton = app.navigationBars["Все клиенты"]
        guard allClientsButton.waitForExistence(timeout: 2) else {
            XCTFail("All clients title isn`t exist")
            return
        }
    }
}
