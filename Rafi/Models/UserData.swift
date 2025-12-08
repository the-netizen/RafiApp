//moved noors login model  here

import Foundation

struct User: Identifiable {
    let id = UUID()
    let username: String
}

enum AuthError: Error, LocalizedError {
    case emptyFields
    case invalidCredentials
    
    var errorDescription: String? {
        switch self {
        case .emptyFields:
            return "الرجاء إدخال اسم المستخدم وكلمة المرور"
        case .invalidCredentials:
            return "بيانات الدخول غير صحيحة"
        }
    }
}

final class AuthService {
    func login(username: String, password: String) async throws -> User {
        if username.isEmpty || password.isEmpty {
            throw AuthError.emptyFields
        }
        
        try await Task.sleep(nanoseconds: 800_000_000)
        
        if password == "1234" {
            return User(username: username)
        } else {
            throw AuthError.invalidCredentials
        }
    }
}

