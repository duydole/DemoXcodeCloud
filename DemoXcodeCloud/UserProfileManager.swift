//
//  Math.swift
//  DemoGithubActions
//
//  Created by Đỗ Lê Duy on 13/6/25.
//

import Foundation

/// Manages user profile data with storage, retrieval, and validation.
class UserProfileManager {
    // MARK: - Properties
    private var userProfiles: [String: UserProfile] = [:]
    private let defaults = UserDefaults.standard
    private let profileKey = "UserProfiles"
    
    // MARK: - Structs
    struct UserProfile {
        let id: String
        var name: String
        var email: String?
        var age: Int?
        var lastUpdated: Date
    }
    
    // MARK: - Initialization
    init() {
        loadProfiles()
    }
    
    // MARK: - Public Methods
    
    /// Creates a new user profile.
    /// - Returns: True if creation succeeds, false if ID exists or name is invalid.
    func createProfile(id: String, name: String, email: String?, age: Int?) -> Bool {
        guard !userProfiles.keys.contains(id), isValidName(name) else {
            return false
        }
        
        let profile = UserProfile(
            id: id,
            name: name.trimmingCharacters(in: .whitespaces),
            email: email,
            age: age,
            lastUpdated: Date()
        )
        userProfiles[id] = profile
        saveProfiles()
        return true
    }
    
    /// Updates an existing profile.
    /// - Returns: True if update succeeds, false if ID doesn't exist or data is invalid.
    func updateProfile(id: String, name: String?, email: String?, age: Int?) -> Bool {
        guard var profile = userProfiles[id] else {
            return false
        }
        
        if let newName = name, isValidName(newName) {
            profile.name = newName.trimmingCharacters(in: .whitespaces)
        }
        
        if let newEmail = email, isValidEmail(newEmail) {
            profile.email = newEmail
        }
        
        if let newAge = age, newAge >= 0 {
            profile.age = newAge
        }
        
        profile.lastUpdated = Date()
        userProfiles[id] = profile
        saveProfiles()
        return true
    }
    
    /// Retrieves a profile by ID.
    func getProfile(id: String) -> UserProfile? {
        return userProfiles[id]
    }
    
    /// Deletes a profile by ID.
    func deleteProfile(id: String) -> Bool {
        guard userProfiles.removeValue(forKey: id) != nil else {
            return false
        }
        saveProfiles()
        return true
    }
    
    // MARK: - Private Methods
    
    /// Loads profiles from UserDefaults.
    private func loadProfiles() {
        if let data = defaults.data(forKey: profileKey),
           let profiles = try? JSONDecoder().decode([String: UserProfile].self, from: data) {
            userProfiles = profiles
        }
    }
    
    /// Saves profiles to UserDefaults.
    private func saveProfiles() {
        if let data = try? JSONEncoder().encode(userProfiles) {
            defaults.set(data, forKey: profileKey)
        }
    }
    
    /// Validates name (non-empty after trimming).
    private func isValidName(_ name: String) -> Bool {
        return !name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    /// Validates email format.
    private func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
}

// MARK: - Codable Conformance for UserProfile
extension UserProfileManager.UserProfile: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, email, age, lastUpdated
    }
}

class Math {
    // Write methods about Math
    static func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    static func subtract(_ a: Int, _ b: Int) -> Int {
        return a - b
    }
    
    static func multiply(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
    
    static func divide(_ a: Int, _ b: Int) -> Int? {
        guard b != 0 else { return nil }
        return a / b
    }
}
