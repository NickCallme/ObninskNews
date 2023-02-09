//
//  GallaryViewController.swift
//  ExampleObnins
//
//  Created by Nikita Kolmykov on 19.01.2023.
//

import Foundation
import UIKit

class GalleryViewController: UIViewController {
    
    private var imageViewObnisnk: UIImageView!
    private var collectionView: UICollectionView!
    
    var galleryViewModel: GalleryViewModelType!
    
    // Индекс ячейки для выполнения подгрузки
    private var count = 24
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        galleryViewModel = GalleryViewModel(networkService: APIService(), view: self)
        
        setupView()
    }
    
    // MARK: METHODS
    
    // Обновить коллекцию
    func upadteData() {
        collectionView.reloadData()
    }
    
    
    
    
    //MARK: SETUP VIEW
    
    func setupView() {
        
        // PROPERTY VIEW
        view.backgroundColor = .white
        
        imageViewObnisnk = UIImageView(image: UIImage(named: "obninskName"))
        imageViewObnisnk.contentMode = .center
        
        let spacing: CGFloat = 3
        let sizeCell = (view.frame.width - CGFloat(spacing * 2)) / 3
        
        let layoutFlow = UICollectionViewFlowLayout()
        layoutFlow.itemSize = CGSize(width: sizeCell, height: sizeCell)
        layoutFlow.minimumLineSpacing = spacing
        layoutFlow.minimumInteritemSpacing = spacing
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutFlow)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        // Регистрация для новостных ячеек
        collectionView.register(GalleryViewCell.self, forCellWithReuseIdentifier: "\(GalleryViewCell.self)")
        // Регистрация для ячейки с индикатором загрузки
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "\(UICollectionViewCell.self)")
        collectionView.contentInset.bottom = sizeCell * 2
        
        // CONSTAINT
        
        view.addSubview(imageViewObnisnk)
        imageViewObnisnk.translatesAutoresizingMaskIntoConstraints = false
        imageViewObnisnk.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageViewObnisnk.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageViewObnisnk.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageViewObnisnk.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: imageViewObnisnk.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

// MARK: EXTENSION COLLECTION VIEW

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    // Количество возвращаемых ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryViewModel.numberOfItems()
    }
    
    // Возвращаемые ячейки
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GalleryViewCell.self)", for: indexPath) as? GalleryViewCell else { return UICollectionViewCell() }
        
        if indexPath.row + 1 == count { return loadingCells(indexPath: indexPath) }
        
        let model = galleryViewModel.createGalleryCellModel(indexPath: indexPath.row)
        cell.cellViewModel = model
        return cell
    }
    
    // Презентовать констроллер при нажатии на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCellViewModel = galleryViewModel.selectedCell(indexPath: indexPath.row)
        let vc = SelectedCellViewController()
        vc.selectedCellViewModel = selectedCellViewModel
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    // Запрос на подгрузку новых ячеек
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let lastCell = collectionView.visibleCells.last else { return }
        guard let indexPath = collectionView.indexPath(for: lastCell) else { return }
        
        if indexPath.row >= (count - 9) {
            
            galleryViewModel.getSkipGallery()
            count += 24
        }
    }
    
    // Ячейка с индикацией загрузки
    func loadingCells(indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(UICollectionViewCell.self)", for: indexPath)
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .systemGray
        
        cell.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
        ])
        
        activityIndicatorView.startAnimating()
        
        return cell
    }
    
}
