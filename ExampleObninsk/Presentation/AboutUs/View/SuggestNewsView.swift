//
//  SuggestNewsView.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 29.01.2023.
//

import UIKit
import PhotosUI


class SuggestNewsView: UIViewController {
    
    private var navigationBarView = UIView()
    private var navigationBarLabel = UILabel()
    private var backButton = UIButton()
    
    private var scrollView = UIScrollView()
    private var stackView = UIStackView()
    
    private var nameView = UIView()
    private var nameLabel = UILabel()
    private var nameTextField = UITextField()
    
    private var numberView = UIView()
    private var numberLabel = UILabel()
    private var numberTextField = UITextField()
    
    private var themeView = UIView()
    private var themeLabel = UILabel()
    private var themeTextField = UITextField()
    private var themeButton = UIButton()
    
    private var emailView = UIView()
    private var emailLabel = UILabel()
    private var emailTextField = UITextField()
    
    private var detailsView = UIView()
    private var detailsLabel = UILabel()
    private var detailsTextView = UITextView()
    
    private var timeView = UIView()
    private var timeLabel = UILabel()
    private var timeTextField = UITextField()
    private var timeButton = UIButton()
    
    private var addPhotoView = UIView()
    private var addPhotoLabel = UILabel()
    private var addPhotoButton = UIButton()
    
    private var suggestNewsView = UIView()
    private var suggestNewsButton = UIButton()
    
    private var activeInput: UIView?
    
    var model: ModelTheme? {
        didSet {
            guard let model = model else { return }
            nameTextField.text = model.nameText
            numberTextField.text = model.numberText
            themeTextField.text = model.themeText
            emailTextField.text = model.emailText
            detailsTextView.text = model.detailText
            timeTextField.text = model.timeText
            checkButtonActivity()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        // Добавить разделительную линию в stackView
        stackView.addSeparators(color: .systemGray)
        
        disableButton()
        
        backButton.addTarget(self, action: #selector(back(sender: )), for: .touchUpInside)
        
        timeButton.addTarget(self, action: #selector(openDatePicker(sender: )), for: .touchUpInside)
        themeButton.addTarget(self, action: #selector(changeTheme(sender: )), for: .touchUpInside)
        addPhotoButton.addTarget(self, action: #selector(openPhotoLibrary(sender: )), for: .touchUpInside)
        
        suggestNewsButton.addTarget(self, action: #selector(transitToSentNews(sender: )), for: .touchUpInside)
        
        // Закрытие клавиатуры при нажатии где-либо кроме клавиатуры
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
        // Добавить поле done над клавиатурой
        detailsTextView.addDoneButtonToKeyboard(myAction: #selector(detailsTextView.resignFirstResponder))
        numberTextField.addDoneButtonToKeyboard(myAction: #selector(numberTextField.resignFirstResponder))
        
    }
    
    // MARK: METHODS
    
    
    // Вернуться на предыдущий контроллер
    @objc func back(sender: UIButton) {
        dismiss(animated: true)
    }
    
    // Включить кнопку
    private func enableButton() {
        suggestNewsButton.isEnabled = true
        suggestNewsButton.backgroundColor = .systemBlue
    }
    
    // Отключить кнопку
    private func disableButton() {
        suggestNewsButton.isEnabled = false
        suggestNewsButton.backgroundColor = .systemGray
    }
    
    // Создание внутреней модели для передачи в input
    private func createModel() -> ModelTheme {
        
        let modelTheme = ModelTheme(nameText: nameTextField.text,
                                   numberText: numberTextField.text,
                                   themeText: themeTextField.text,
                                   emailText: emailTextField.text,
                                   detailText: detailsTextView.text,
                                   timeText: timeTextField.text,
                                   image: nil)
        
        return modelTheme
    }
    
    // Открыть выбор темы
    @objc func changeTheme(sender: UIButton) {
        
        let vc = ThemeView()
        vc.modelTheme = createModel()
        vc.modalPresentationStyle = .currentContext
        present(vc, animated: true)
    }
    
    // Открыть DatePicker
    @objc func openDatePicker(sender: UIButton) {
        let vc = DatePickerView()
        vc.model = createModel()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    // Открыть библиотеку фото
    @objc func openPhotoLibrary(sender: UIButton) {
        
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = .images
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated: true)
    }
    
    // Вложить фото
    private func setImage(image: UIImage?) {
        if image == nil { return }
        addPhotoButton.setImage(image, for: .normal)
        addPhotoButton.imageView?.contentMode = .scaleAspectFill
        addPhotoButton.imageView?.clipsToBounds = true
        addPhotoLabel.text = "Фото прикреплено"
        
        checkButtonActivity()
    }
    
    // Переход на Контроллер "Новость отправлена"
    @objc func transitToSentNews(sender: UIButton) {
        
        let vc = SensNewsView()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    // MARK: SETUP VIEW
    
    func setupView() {
        
        // PROPERTY VIEWS
        view.backgroundColor = .white
        scrollView.backgroundColor = .white
        
        navigationBarLabel.textAlignment = .center
        navigationBarLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        navigationBarLabel.textColor = .systemBlue
        navigationBarLabel.text = "Предложить новость"
        
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        
        nameLabel.font = .systemFont(ofSize: 15)
        nameLabel.textColor = .systemGray
        nameLabel.text = "Ваше имя"
        
        suggestNewsButton.backgroundColor = .systemBlue
        suggestNewsButton.layer.cornerRadius = 8
        suggestNewsButton.clipsToBounds = true
        suggestNewsButton.setTitle("Предложить новость", for: .normal)
        suggestNewsButton.isEnabled = false
        
        stackView.axis = .vertical
        stackView.spacing = 8
        
        nameTextField.delegate = self
        nameTextField.font = .systemFont(ofSize: 17)
        nameTextField.placeholder = "Как к Вам обращаться?"
        
        numberLabel.font = .systemFont(ofSize: 15)
        numberLabel.textColor = .systemGray
        numberLabel.text = "Номер телефона"
        
        numberTextField.delegate = self
        numberTextField.textContentType = .telephoneNumber
        numberTextField.keyboardType = .phonePad
        numberTextField.font = .systemFont(ofSize: 17)
        numberTextField.placeholder = "Введите номер телефона"
        
        themeLabel.font = .systemFont(ofSize: 15)
        themeLabel.textColor = .systemGray
        themeLabel.text = "Тема новости"
        
        themeTextField.delegate = self
        themeTextField.isEnabled = false
        themeTextField.font = .systemFont(ofSize: 17)
        themeTextField.placeholder = "Выберите вариант"

        
        emailLabel.font = .systemFont(ofSize: 15)
        emailLabel.textColor = .systemGray
        emailLabel.text = "E-mail"
        
        emailTextField.delegate = self
        emailTextField.font = .systemFont(ofSize: 17)
        emailTextField.placeholder = "Введите адрес электронной почты"
        
        detailsLabel.font = .systemFont(ofSize: 15)
        detailsLabel.textColor = .systemGray
        detailsLabel.text = "Подробности"
        
        detailsTextView.delegate = self
        detailsTextView.font = .systemFont(ofSize: 17)
        detailsTextView.isScrollEnabled = false
        
        timeLabel.font = .systemFont(ofSize: 15)
        timeLabel.textColor = .systemGray
        timeLabel.text = "Время публикации"
        
        timeTextField.delegate = self
        timeTextField.isEnabled = false
        timeTextField.font = .systemFont(ofSize: 17)
        timeTextField.placeholder = "Выберите время публикации"
        
        addPhotoLabel.textAlignment = .left
        addPhotoLabel.font = .systemFont(ofSize: 15)
        addPhotoLabel.textColor = .systemGray
        addPhotoLabel.text = "Прикрепите фотографию"
        
        addPhotoButton.backgroundColor = .systemBlue
        addPhotoButton.layer.cornerRadius = 8
        addPhotoButton.clipsToBounds = true
        addPhotoButton.setImage(UIImage(named: "photoIcon"), for: .normal)
        addPhotoButton.imageView?.contentMode = .center
        
        // CONSTRAINT
        
        view.addSubview(navigationBarView)
        navigationBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBarView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        navigationBarView.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: navigationBarView.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: navigationBarView.leadingAnchor, constant: 14),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        navigationBarView.addSubview(navigationBarLabel)
        navigationBarLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBarLabel.centerYAnchor.constraint(equalTo: navigationBarView.centerYAnchor),
            navigationBarLabel.topAnchor.constraint(equalTo: navigationBarView.topAnchor, constant: 12),
            navigationBarLabel.leadingAnchor.constraint(equalTo: navigationBarView.leadingAnchor),
            navigationBarLabel.trailingAnchor.constraint(equalTo: navigationBarView.trailingAnchor)
        ])
        
        view.addSubview(suggestNewsView)
        suggestNewsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            suggestNewsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            suggestNewsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            suggestNewsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            suggestNewsView.heightAnchor.constraint(equalToConstant: 76)
        ])
        
        suggestNewsView.addSubview(suggestNewsButton)
        suggestNewsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            suggestNewsButton.bottomAnchor.constraint(equalTo: suggestNewsView.bottomAnchor, constant: -16),
            suggestNewsButton.leadingAnchor.constraint(equalTo: suggestNewsView.leadingAnchor, constant: 16),
            suggestNewsButton.trailingAnchor.constraint(equalTo: suggestNewsView.trailingAnchor, constant: -16),
            suggestNewsButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: suggestNewsView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        addPhotoView.addSubview(addPhotoButton)
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addPhotoButton.topAnchor.constraint(equalTo: addPhotoView.topAnchor,constant: 16),
            addPhotoButton.leadingAnchor.constraint(equalTo: addPhotoView.leadingAnchor),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 60),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        addPhotoView.addSubview(addPhotoLabel)
        addPhotoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addPhotoLabel.topAnchor.constraint(equalTo: addPhotoView.topAnchor,constant: 36),
            addPhotoLabel.leadingAnchor.constraint(equalTo: addPhotoButton.trailingAnchor, constant: 16),
            addPhotoLabel.trailingAnchor.constraint(equalTo: addPhotoView.trailingAnchor),
            addPhotoLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        setupCell(viewElement: nameView, elmentLabel: nameLabel, elementField: nameTextField)
        setupCell(viewElement: numberView, elmentLabel: numberLabel, elementField: numberTextField)
        setupCell(viewElement: themeView, elmentLabel: themeLabel, elementField: themeTextField)
        setupCell(viewElement: emailView, elmentLabel: emailLabel, elementField: emailTextField)
        setupCell(viewElement: detailsView, elmentLabel: detailsLabel, elementField: detailsTextView)
        setupCell(viewElement: timeView, elmentLabel: timeLabel, elementField: timeTextField)
        stackView.addArrangedSubview(addPhotoView)
        addPhotoView.translatesAutoresizingMaskIntoConstraints = false
        addPhotoView.heightAnchor.constraint(equalToConstant: 92).isActive = true
    
        themeView.addSubview(themeButton)
        themeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            themeButton.topAnchor.constraint(equalTo: themeTextField.topAnchor),
            themeButton.bottomAnchor.constraint(equalTo: themeTextField.bottomAnchor),
            themeButton.leadingAnchor.constraint(equalTo: themeTextField.leadingAnchor),
            themeButton.trailingAnchor.constraint(equalTo: themeTextField.trailingAnchor)
        ])
        
        timeView.addSubview(timeButton)
        timeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeButton.topAnchor.constraint(equalTo: timeTextField.topAnchor),
            timeButton.bottomAnchor.constraint(equalTo: timeTextField.bottomAnchor),
            timeButton.leadingAnchor.constraint(equalTo: timeTextField.leadingAnchor),
            timeButton.trailingAnchor.constraint(equalTo: timeTextField.trailingAnchor)
        ])
    }
    
    func setupCell(viewElement: UIView, elmentLabel: UIView, elementField: UIView) {
        
        stackView.addArrangedSubview(viewElement)
        viewElement.translatesAutoresizingMaskIntoConstraints = false
        viewElement.heightAnchor.constraint(greaterThanOrEqualToConstant: 70).isActive = true
        
        viewElement.addSubview(elmentLabel)
        elmentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            elmentLabel.topAnchor.constraint(equalTo: viewElement.topAnchor, constant: 12),
            elmentLabel.leadingAnchor.constraint(equalTo: viewElement.leadingAnchor),
            elmentLabel.trailingAnchor.constraint(equalTo: viewElement.trailingAnchor),
            elmentLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        viewElement.addSubview(elementField)
        elementField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            elementField.topAnchor.constraint(equalTo: elmentLabel.bottomAnchor, constant: 4),
            elementField.leadingAnchor.constraint(equalTo: viewElement.leadingAnchor),
            elementField.trailingAnchor.constraint(equalTo: viewElement.trailingAnchor),
            elementField.bottomAnchor.constraint(equalTo: viewElement.bottomAnchor, constant: 12),
            elementField.heightAnchor.constraint(greaterThanOrEqualToConstant: 22)
        ])
    }
    
}

// MARK: PHPICKER

extension SuggestNewsView: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        results.forEach { results in
            results.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                DispatchQueue.main.async {
                    self.setImage(image: image)
                }
            }
        }
    }
    
}

// MARK: KEYBOARD

extension SuggestNewsView: KeyboardHandler {
    
    var observerInput: UIView? {
        get {
            return activeInput
        }
        set {
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startObservingKeyboardChanges()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopObservingKeyboardChanges()
    }
    
    var bottomConstraint: NSLayoutConstraint! {
        get {
            scrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        }
        set {
            
        }
    }
    
}

// MARK: TextField & TextView Deligate

extension SuggestNewsView: UITextFieldDelegate, UITextViewDelegate {
    
    
    // Функция проверки активности кнопки
   func checkButtonActivity() {
        
        let arrayCheck = [nameTextField,numberTextField,themeTextField,emailTextField,timeTextField]
        
        
        var check = true
        
        for field in arrayCheck {
            if field.text == "" { check = false }
        }
        
        if detailsTextView.text == "" { check = false }
        
        if addPhotoButton.imageView?.image == UIImage(named: "photoIcon") { check = false }
        
        if check { enableButton() } else { disableButton() }
    }
    
    // Проверка активности кнопки textField
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        checkButtonActivity()
    }
    
    // Проверка активности кнопки text View
    func textViewDidChange(_ textView: UITextView) {
        
        checkButtonActivity()
    }
    
    // Нажатие на клавиатуре Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Передача активного input в keyboard manger
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeInput = textField
    }
    
    // Передача активного input в keyboard manger
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        activeInput = textView
        return true
    }
    
    
}
