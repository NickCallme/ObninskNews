//
//  DatePickerView.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 01.02.2023.
//

import UIKit

class DatePickerView: UIViewController {
    
    private var datePickerSubstrate = UIView()
    private var cancelDatePicker = UIButton()
    private var enterDatePicker = UIButton()
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        datePicker.locale = Locale(identifier: "ru_RU")
        return datePicker
    }()
    
    var model: ModelTheme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        // стартовое значение времени
        valueChanged(sender: nil)
        
        cancelDatePicker.addTarget(self, action: #selector(cancel(sender: )), for: .touchUpInside)
        enterDatePicker.addTarget(self, action: #selector(enter(sender: )), for: .touchUpInside)
        datePicker.addTarget(self, action: #selector(valueChanged(sender: )), for: .valueChanged)
    }
    
    // MARK: METHODS
    
    // Выход
    @objc func cancel(sender: UIButton) {
        dismiss(animated: true)
    }
    
    // Принять дату
    @objc func enter(sender: UIButton) {
        
        guard let vc = presentingViewController as? SuggestNewsView else { return }
        vc.model = model
        dismiss(animated: true)
    }
    
    // Действие при прокрутке DatePicker
    @objc func valueChanged(sender: UIDatePicker?) {
        let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            model?.timeText = formatter.string(from: datePicker.date)
    }
    
    // MARK: SETUP VIEW
    
    func setupView() {
        
        // PROPERTY
        
        view.backgroundColor = .black.withAlphaComponent(0.4)
        datePickerSubstrate.backgroundColor = .white
        
        cancelDatePicker.setTitle("Отмена", for: .normal)
        cancelDatePicker.setTitleColor(.systemBlue, for: .normal)
        
        enterDatePicker.setTitle("Выбрать", for: .normal)
        enterDatePicker.setTitleColor(.systemBlue, for: .normal)
        
        // CONSTRAINT
        
        view.addSubview(datePickerSubstrate)
        datePickerSubstrate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePickerSubstrate.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            datePickerSubstrate.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePickerSubstrate.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        datePickerSubstrate.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: datePickerSubstrate.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: datePickerSubstrate.trailingAnchor)
        ])
        
        datePickerSubstrate.addSubview(cancelDatePicker)
        cancelDatePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelDatePicker.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: 8),
            cancelDatePicker.leadingAnchor.constraint(equalTo: datePickerSubstrate.leadingAnchor, constant: 16),
            cancelDatePicker.topAnchor.constraint(equalTo: datePickerSubstrate.topAnchor, constant: 8),
            cancelDatePicker.heightAnchor.constraint(equalToConstant: 22),
            cancelDatePicker.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        datePickerSubstrate.addSubview(enterDatePicker)
        enterDatePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enterDatePicker.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: 8),
            enterDatePicker.trailingAnchor.constraint(equalTo: datePickerSubstrate.trailingAnchor, constant: -16),
            enterDatePicker.topAnchor.constraint(equalTo: datePickerSubstrate.topAnchor, constant: 8),
            enterDatePicker.heightAnchor.constraint(equalToConstant: 22),
            enterDatePicker.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        
    }
}
