//
//  GeneralErrors.swift
//  General
//
//  Created by Михаил Андреичев on 28.04.2020.
//

import Foundation

struct CustomError: LocalizedError {
    init(errorDescription: String?) {
        self.errorDescription = errorDescription
    }

    var errorDescription: String?
}

enum GeneralError: LocalizedError {
    case authError
    case remoteError
    case requestError

    var errorDescription: String? {
        switch self {
        case .authError:
            return Text.Errors.authError
        case .remoteError:
            return Text.Errors.remoteError
        case .requestError:
            return Text.Errors.requestError
        }
    }
}
