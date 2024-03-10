import UIKit

final class ViewController: UIViewController {
    // MARK: - private properties

    private let nameTextField = UITextField()
    private let ageTextField = UITextField()

    private let alertButton = UIButton()

    // MARK: - private variables

    private var counter = 0

    // MARK: - lyfe cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // view
        setupAppearanceView()

        // textFields
        layoutTextFields()
        setupAppearanceTextFields()

        // button
        layoutButton()
        setupAppearanceButton()
        tapToButton()

        // NotificationCenter
        setupNotificationCenter()

        // other
        closeKeyboard()
    }

    // MARK: - helpers

    private func setupAppearanceView() {
        view.backgroundColor = .white
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
            el.font = UIFont.systemFont(ofSize: 17)
        }
        nameTextField.placeholder = "Введите имя"
        ageTextField.placeholder = "Введите возраст"
        ageTextField.keyboardType = .numberPad
    }

    private func layoutButton() {
        view.addSubview(alertButton)
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertButton.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 30),
            alertButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.48),
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupAppearanceButton() {
        alertButton.setTitle("Отправить данные!", for: .normal)
        alertButton.setTitleColor(.white, for: .normal)
        alertButton.backgroundColor = .systemBlue
        alertButton.layer.cornerRadius = 10
        alertButton.layer.shadowColor = UIColor.systemBlue.cgColor
        alertButton.layer.shadowOffset = .init(width: 0, height: 0)
        alertButton.layer.shadowRadius = 8
        alertButton.layer.shadowOpacity = 0.5
    }

    private func tapToButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(sendData))
        alertButton.addGestureRecognizer(tap)
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

    private func closeKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnScreen))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    // @objc methods
    @objc func sendData() {
        let nameTF = nameTextField.text
        let ageTF = ageTextField.text

        if nameTF == "" || ageTF == "" {
            showAlert(title: "Упс..", message: "Кажется, вы ввели не все данные.")
        } else {
            showAlert(title: "Успех!", message: "Вы удачно отправили свои данные.")
            nameTextField.text = .none
            ageTextField.text = .none
        }
    }

    @objc func showKeyBoard(_ notification: Notification) {
        counter += 1
        if counter == 1 {
            guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardHeight = keyboardFrame.cgRectValue.height
            view.frame.origin.y -= keyboardHeight / 2

            UIView.animate(withDuration: CATransaction.animationDuration()) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func hideKeyBoard(notification: Notification) {
        UIView.animate(withDuration: CATransaction.animationDuration()) {
            self.view.frame.origin.y = 0
            self.view.layoutIfNeeded()
            self.counter = 0
        }
    }

    @objc func tapOnScreen() {
        view.endEditing(true)
        ageTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - extension

extension ViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}
