//
//  File.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 01.02.2023.
//

import UIKit

class SensNewsView: UIViewController {
    
    private var contentView = UIView()
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var textLabel = UILabel()
    private var backToMainButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        backToMainButton.addTarget(self, action: #selector(back(sender: )), for: .touchUpInside)
    }
    
    // MARK: METHODS
    
    @objc func back(sender: UIButton) {
//        dismiss(animated: true)
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    // MARK: SETUP VIEW
    
    func setupView() {
        
        // PROPERTY
        view.backgroundColor = .white
        
        imageView.image = UIImage(named: "sentNews")
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.text = "Новость отправлена!"
        
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.font = .systemFont(ofSize: 17)
        textLabel.text = "Мы как можно быстрее обработаем заявку и оповестим Вас о том, что новость опубликована"
        
        backToMainButton.setTitle("Вернуться на главную", for: .normal)
        backToMainButton.setTitleColor(.white, for: .normal)
        backToMainButton.backgroundColor = .systemBlue
        backToMainButton.layer.cornerRadius = 8
        backToMainButton.clipsToBounds = true
        backToMainButton.setTitleColor(UIColor.init(white: 1, alpha: 0.3), for: .highlighted)
        
        // CONSTRAINT
        
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 260/357)
        ])
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        contentView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 66)
        ])
        
        contentView.addSubview(backToMainButton)
        backToMainButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backToMainButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 24),
            backToMainButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backToMainButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backToMainButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            backToMainButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
}
