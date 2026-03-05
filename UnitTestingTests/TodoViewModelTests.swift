//
//  TodoViewModelTests.swift
//  UnitTestingTests
//
//  Created by Enzo Henrique Botelho Romão on 03/03/26.
//

import XCTest

@testable import UnitTesting

final class TodoViewModelTests: XCTestCase {
    private var sut: TodoViewModel!
    
    override func setUp() {
        super.setUp()
        sut = TodoViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_addTask() {
        // Arrange
        sut.addInputText = "Test task"
        let initialTaskCount = sut.tasks.count
        
        // Act
        sut.addTask()
        
        // Assert
        XCTAssertEqual(sut.tasks.count, initialTaskCount + 1)
        XCTAssertEqual(sut.tasks.last?.text, "Test task")
    }
    
    func test_addEmptyTask() {
        // Arrange
        sut.addInputText = ""
        let initialTaskCount = sut.tasks.count
        
        // Act
        sut.addTask()
        
        // Assert
        XCTAssertEqual(sut.tasks.count, initialTaskCount)
    }
    
    func test_addSpaceString() {
        // Arrange
        sut.addInputText = " "
        let initialTaskCount = sut.tasks.count
        
        // Act
        sut.addTask()
        
        // Assert
        XCTAssertEqual(sut.tasks.count, initialTaskCount)
    }
    
    func test_deleteTask() {
        // Arrange
        sut.addInputText = "Test task"
        let initialTaskCount = sut.tasks.count
        sut.addTask()
        XCTAssertEqual(sut.tasks.count, initialTaskCount + 1)
        
        // Act
        sut.delete(task: sut.tasks.last!)
        
        // Assert
        XCTAssertEqual(sut.tasks.count, initialTaskCount)
    }
    
    func test_startEditingTask() {
        // Arrange
        let initialState = sut.isEditing
        
        // Act
        sut.startEditing(task: sut.tasks.last!)
        
        // Assert
        XCTAssert(initialState != sut.isEditing)
    }
    
    func test_editTask() {
        // Arrange
        sut.editInputText = "New text"
        sut.taskIdToEdit = sut.tasks.last?.id
        
        // Act
        sut.editTask()
        
        // Assert
        XCTAssertEqual(sut.taskBeingEdited?.text, "New text")
    }
    
    func test_editWithEmptyString() {
        // Arrange
        sut.editInputText = ""
        sut.taskIdToEdit = sut.tasks.last?.id
        
        // Act
        sut.editTask()
        
        // Assert
        XCTAssertNotEqual(sut.taskBeingEdited?.text, "")
    }
    
    func test_editWithSpaceString() {
        // Arrange
        sut.editInputText = " "
        sut.taskIdToEdit = sut.tasks.last?.id
        
        // Act
        sut.editTask()
        
        // Assert
        XCTAssertNotEqual(sut.taskBeingEdited?.text, " ")
    }
    
    func test_editWithoutId() {
        // Arrange
        sut.editInputText = "New text"
        
        // Act
        sut.editTask()
        
        // Assert
        XCTAssertNil(sut.taskIdToEdit)
        XCTAssertNil(sut.taskBeingEdited)
        XCTAssert(sut.editInputText == "New text")
    }
}
