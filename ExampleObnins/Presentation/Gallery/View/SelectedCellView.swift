//
//  SellectedCellView.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 27.01.2023.
//

import UIKit
import Kingfisher

class SelectedCellViewController: UIViewController {
    
    private var imageView = UIImageView()
    private var textLabel = UILabel()
    private var cancelButton = UIButton()
    private var transitButton = UIButton()
    
    var selectedCellViewModel: SelectedCellViewModelType? {
        didSet {
            guard let model = selectedCellViewModel else { return }
            
            imageView.kf.setImage(with: URL(string: model.image))
            textLabel.text = model.text
            selectedCellViewModel?.getNews(id: model.id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        cancelButton.addTarget(self, action: #selector(cancel(sender: )), for: .touchUpInside)
        transitButton.addTarget(self, action: #selector(transitToNews(sender: )), for: .touchUpInside)
    }
    
    // MARK: METHODS
    
    // Выход обратно
    @objc private func cancel(sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    // Переход при нажатии на контроллер с новостью
    @objc private func transitToNews(sender: UIButton) {
        
        let detailMainViewModel = selectedCellViewModel?.createDetailMainViewModel()
        let vc = DetailMainView()
        vc.detailMainViewModel = detailMainViewModel
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    // MARK: SETUP VIEW
    
    func setupView() {
        
        // PROPERTY VIEW
        
        view.backgroundColor = .black.withAlphaComponent(0.8)
        
        transitButton.backgroundColor = .systemBlue
        transitButton.layer.cornerRadius = 8
        transitButton.clipsToBounds = true
        transitButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        transitButton.setTitle("Перейти к новости", for: .normal)
        transitButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        transitButton.titleLabel?.textColor = .white
        transitButton.setTitleColor(UIColor.init(white: 1, alpha: 0.3), for: .highlighted)
        
        textLabel.font = .systemFont(ofSize: 17)
        textLabel.textColor = .white
        textLabel.numberOfLines = 2
        
        imageView.contentMode = .scaleAspectFill
        
        cancelButton.setImage(UIImage(named: "cancelButton"), for: .normal)
        
        // CONSTRAINT
        
        view.addSubview(transitButton)
        transitButton.translatesAutoresizingMaskIntoConstraints = false
        transitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        transitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        transitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        transitButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        view.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.bottomAnchor.constraint(equalTo: transitButton.topAnchor, constant: -16).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 57).isActive = true
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -16).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 456/375).isActive = true
        
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
    }
}
