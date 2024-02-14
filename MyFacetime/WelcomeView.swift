//
//  WelcomeView.swift
//  MyFacetime
//
//  Created by Afraz Siddiqui on 2/14/24.
//

import UIKit

protocol WelcomeViewDelegate: AnyObject {
    func didTapSignIn(email: String?, password: String?)

    func didTapSignUp(email: String?, password: String?)
}

class WelcomeView: UIView {

    weak var delegate: WelcomeViewDelegate?

    enum State {
        case sign_in
        case sign_up
    }

    private var state: State = .sign_in

    // Field: email/pass

    private let emailField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.placeholder = "Email Address"
        field.returnKeyType = .next
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .secondarySystemBackground
        return field
    }()

    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.returnKeyType = .next
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .secondarySystemBackground
        return field
    }()


    // Action button

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // Change state button

    private let stateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(emailField)
        addSubview(passwordField)
        addSubview(button)
        addSubview(stateButton)

        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        stateButton.addTarget(self, action: #selector(didTapStateButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            emailField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            emailField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
            emailField.heightAnchor.constraint(equalToConstant: 50),

            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            passwordField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
       
            button.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            button.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            button.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50),

            stateButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            stateButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            stateButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
            stateButton.heightAnchor.constraint(equalToConstant: 50),
       ])
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc private func didTapButton() {
        switch state {
        case .sign_in:
            delegate?.didTapSignIn(email: emailField.text, password: passwordField.text)
        case .sign_up:
            delegate?.didTapSignUp(email: emailField.text, password: passwordField.text)
        }
    }

    @objc private func didTapStateButton() {
        switch state {
        case .sign_in:
            state = .sign_up
            stateButton.setTitle("Sign In", for: .normal)
            button.setTitle("Sign Up", for: .normal)
        case .sign_up:
            state = .sign_in
            stateButton.setTitle("Create Account", for: .normal)
            button.setTitle("Sign In", for: .normal)

        }
    }
}
