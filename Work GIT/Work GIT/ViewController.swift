import UIKit

final class ViewController: UIViewController {
    // MARK: - private properties

    private let nameTextField = UITextField()
    private let ageTextField = UITextField()

    // MARK: - lyfe cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearanceView()
        layoutTextFields()
        setupAppearanceTextFields()
        setupNotificationCenter()
        closeKeyboard()
    }

    // MARK: - helpers

    private func setupAppearanceView() {
        view.backgroundColor = .white
    }

    private func closeKeyboard() {
        let tap = UIGestureRecognizer(target: self, action: #selector(tapOnScreen))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    private func layoutTextFields() {
        for el in [nameTextField, ageTextField] {
            view.addSubview(el)
            el.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),

            ageTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            ageTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }

    private func setupAppearanceTextFields() {
        for el in [nameTextField, ageTextField] {
            el.borderStyle = .roundedRect
            el.tintColor = .black
            el.font = UIFont.systemFont(ofSize: 18)
        }
        nameTextField.placeholder = "Введите имя"
        ageTextField.placeholder = "Введите возраст"
        ageTextField.keyboardType = .numberPad
    }

    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showKeyBoard),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(hideKeyBoard),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    @objc func showKeyBoard(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            view.frame.origin.y -= keyboardHeight / 2
            
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func hideKeyBoard(notification: Notification) {
        view.frame.origin.y = 0

        UIView.animate(withDuration: CATransaction.animationDuration()) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func tapOnScreen() {
        view.endEditing(true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
