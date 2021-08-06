// User.swift
// Copyright © Roadmap. All rights reserved.

import Foundation

/// Структура пользователя
struct User {
    let userName: String
    let userAvatarImageName: String
    let userPhotosNames: [String]
}

/// Структура пользователей по букве
struct UserWithLetter {
    let letter: Character
    let users: [User]
}
