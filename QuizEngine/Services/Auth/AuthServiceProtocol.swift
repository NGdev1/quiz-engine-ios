//
//  AuthServiceProtocol.swift
//  QuizEngine
//
//  Created by Admin on 27.05.2021.
//

protocol AuthServiceProtocol {
    func signIn(_ form: Auth.SignInForm, completion: @escaping (Auth.TokenDto?, Error?) -> Void)
    func signUp(_ form: Auth.SignUpForm, completion: @escaping (Auth.TokenDto?, Error?) -> Void)
}
