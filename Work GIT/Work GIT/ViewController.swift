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
            el.font = UIFont.systemFont(ofSize: 18)
        }
        nameTextField.placeholder = "Введите имя"
        ageTextField.placeholder = "Введите возраст"
        ageTextField.keyboardType = .numberPad
    }
}
