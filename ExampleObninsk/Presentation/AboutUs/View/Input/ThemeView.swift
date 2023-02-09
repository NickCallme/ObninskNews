//
//  themeChouseView.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 30.01.2023.
//

import UIKit

class ThemeView: UIViewController {
    
    private var topView = UIView()
    private var cancelButton = UIButton()
    private var labelTopView = UILabel()
    
    private var tableView = UITableView()
    
    private var themes = ["Важное","Бизнес","Благоустройство","Власть","Вопрос-ответ","Выборы","Другое"]
    
    var modelTheme: ModelTheme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        cancelButton.addTarget(self, action: #selector(cancel(sender: )), for: .touchUpInside)
    }
    
    // MARK: METHODS
    
    @objc func cancel(sender: UIButton) {
        dismiss(animated: true)
    }
    
    // MARK: SETUP VIEW
    
    func setupView() {
        
        // PROPERTY
        
        view.backgroundColor = .white
        
        cancelButton.setImage(UIImage(named:"backButton"), for: .normal)
        
        labelTopView.textColor = .systemBlue
        labelTopView.textAlignment = .center
        labelTopView.text = "Тема новости"
        labelTopView.font = .boldSystemFont(ofSize: 17)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ThemeCell.self, forCellReuseIdentifier: "\(ThemeCell.self)")
        
        
        // CONSTRAINT
        
        view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        topView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
            cancelButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            cancelButton.heightAnchor.constraint(equalToConstant: 24),
            cancelButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        topView.addSubview(labelTopView)
        labelTopView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelTopView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            labelTopView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            labelTopView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 12),
            labelTopView.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

// MARK: EXTENSION TABLE VIEW

extension ThemeView: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ThemeCell.self)") as? ThemeCell else { return UITableViewCell() }
        cell.label.text = themes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        modelTheme?.themeText = themes[indexPath.row]
        
//        let vc = SuggestNewsView()
//        vc.model = modelTheme
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
        
        guard let vc = presentingViewController as? SuggestNewsView else { return }
        vc.model = modelTheme
        dismiss(animated: true)
    }
}
