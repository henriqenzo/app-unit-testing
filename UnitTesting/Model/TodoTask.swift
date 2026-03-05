//
//  TodoTask.swift
//  UnitTesting
//
//  Created by Enzo Henrique Botelho Romão on 03/03/26.
//

import Foundation

struct TodoTask: Identifiable {
    let id: UUID = UUID()
    var text: String
}
