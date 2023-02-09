//
//  MainView.swift
//  ExampleObnins
//
//  Created by Nikita Kolmykov on 19.01.2023.
//

import Foundation
import UIKit

enum StateButton {
    case tappedAllNews
    case tappedMainNews
}

class MainViewController: UIViewController {
    
    private var obninskNameView = UIImageView()
        .set(\.image, to: UIImage(named: "obninskName"))
        .set(\.contentMode, to: .center)
        .set(\.backgroundColor, to: .white)
    
    private var tableView: UITableView!
    
    private var buttonView = UIView()
        .set(\.backgroundColor, to: .white)
    
    private var allNewsButton = UIButton()
    private var mainNewsButton: UIButton!
    private var activityView = UIActivityIndicatorView(style: .large)
    
    private var mainViewModel: MainViewModelType!
    
    private var count: Int = 20
    
    // Состояние кнопок
    private var stateButton: StateButton = .tappedAllNews {
        didSet {
            changeNewsButton()
            tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            showActivityIndicatory()
            count = 20
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewModel = MainViewModel(networkService: APIService(),view: self)
        setupViews()
        
        mainNewsButton.addTarget(self, action: #selector(tappedMainNews(sender:)), for: .touchUpInside)
        allNewsButton.addTarget(self, action: #selector(tappedAllNews(sender:)), for: .touchUpInside)
        
        
        
    }
    
    
    // MARK: METHODS
    
    func updateData() {
        tableView.reloadData()
    }
    
    // Нажатия на кнопки
    @objc private func tappedMainNews(sender: UIButton) {
        self.stateButton = .tappedMainNews
        self.mainViewModel.getHotNews()
    }
    
    @objc private func tappedAllNews(sender: UIButton) {
        self.stateButton = .tappedAllNews
        self.mainViewModel.getNews()
    }
    
    // Смена фона у кнопок
    private func changeNewsButton() {
        switch stateButton {
        case .tappedAllNews:
            self.mainNewsButton.setImage(UIImage(named: "mainNewsButton"), for: .normal)
            self.allNewsButton.setImage(UIImage(named: "allNewsButton"), for: .normal)
        case .tappedMainNews:
            self.mainNewsButton.setImage(UIImage(named: "mainNewsButton2"), for: .normal)
            self.allNewsButton.setImage(UIImage(named: "allNewsButton2"), for: .normal)
        }
    }
    
    // ActivityIndicator
    func showActivityIndicatory() {
        activityView.center = self.tableView.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func  hideActivityIndicatory() {
        activityView.center = self.tableView.center
        self.view.addSubview(activityView)
        activityView.stopAnimating()
        activityView.isHidden = true
    }
    
    // MARK: SETUP VIEWS
    
    private func setupViews() {
        
        // PROPERTY VIEW
        
        view.backgroundColor = .white
        
        allNewsButton.setImage(UIImage(named: "allNewsButton"), for: .normal)
        allNewsButton.contentMode = .scaleAspectFill
        allNewsButton.layer.cornerRadius = 18
        allNewsButton.clipsToBounds = true
        
        mainNewsButton = UIButton()
        mainNewsButton.setImage(UIImage(named: "mainNewsButton"), for: .normal)
        mainNewsButton.contentMode = .scaleAspectFill
        mainNewsButton.layer.cornerRadius = 18
        mainNewsButton.clipsToBounds = true
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsViewCell.self, forCellReuseIdentifier: "newsCell")
        tableView.backgroundColor = .white
        
        //CONSTRAINT
        
        // Констреинты безопасной зоны
        let guide = self.view.safeAreaLayoutGuide
        
        view.addSubview(obninskNameView)
        obninskNameView.translatesAutoresizingMaskIntoConstraints = false
        obninskNameView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        obninskNameView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        obninskNameView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        obninskNameView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        view.addSubview(buttonView)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.topAnchor.constraint(equalTo: obninskNameView.bottomAnchor).isActive = true
        buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        buttonView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        buttonView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: buttonView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        
        buttonView.addSubview(allNewsButton)
        allNewsButton.translatesAutoresizingMaskIntoConstraints = false
        allNewsButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 8).isActive = true
        allNewsButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 16).isActive = true
        allNewsButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        allNewsButton.widthAnchor.constraint(equalToConstant: 114).isActive = true

        buttonView.addSubview(mainNewsButton)
        mainNewsButton.translatesAutoresizingMaskIntoConstraints = false
        mainNewsButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 8).isActive = true
        mainNewsButton.leftAnchor.constraint(equalTo: allNewsButton.rightAnchor, constant: 8).isActive = true
        mainNewsButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        mainNewsButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
    }
}

// MARK: EXTENSION TABLE VIEW

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Количество возвращаемых ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mainViewModel.numberOfRows() == 0 { showActivityIndicatory() } else { hideActivityIndicatory() }
        
        return mainViewModel.numberOfRows()
    }
    
    // Возвращаемые ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = NewsViewCell(style: .default, reuseIdentifier: "newsCell")
        
        if indexPath.row + 1 == count { return loadingCell() }
        
        switch stateButton {
        case .tappedAllNews:
            let newsViewCellModel = mainViewModel.createNewsСell(indexPath: indexPath.row)
            cell.newsViewCellModel = newsViewCellModel
        case .tappedMainNews:
            let newsViewCellModel = mainViewModel.createHotNewsCell(indexPath: indexPath.row)
            cell.newsViewCellModel = newsViewCellModel
        }
        
        return cell
    }
    
    // Автоматическая высота ячеек
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // Нажатие на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailMainView()
        vc.modalPresentationStyle = .fullScreen
        vc.detailMainViewModel = mainViewModel.selectedNews(indexPath: indexPath)
        present(vc, animated: true)
    }
    
    // Подготовка новых ячеек
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Последняя видимая ячейка
        guard let lastCell = tableView.visibleCells.last else { return }
        
        // Индекс последней видимой ячейки
        guard let indexPath = tableView.indexPath(for: lastCell) else { return }
        
        // Подгружать новости в зависимости от выбранных
        if indexPath.row == (count - 1) {
            switch stateButton {
            case .tappedAllNews: mainViewModel.getSkipNews() ; count += 20
            case .tappedMainNews: mainViewModel.getSkipHotNews() ; count += 20
            }
        }
    }
    
    // Ячейка с индикатором загрузки
    func loadingCell() -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.contentView.backgroundColor = .white
        cell.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .systemGray
        
        cell.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: cell.centerXAnchor)
        ])
        activityIndicatorView.startAnimating()
        
        return cell
    }
    
}
