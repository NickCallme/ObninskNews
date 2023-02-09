//
//  InfoViewController.swift
//  ExampleObnins
//
//  Created by Nikita Kolmykov on 19.01.2023.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    
    private var statusBarView = UIView()
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var mainImage: UIImageView!
    private var dateAndTagView: UIView!
    private var dateLabel: UILabel!
    private var tagLabel: UILabel!
    private var aboutObninskView: UIView!
    private var townHeaderLabel: UILabel!
    private var townTextLabel: UILabel!
    private var textHeaderLabel: UILabel!
    private var textLabel: UILabel!
    private var sightLabel: UILabel!
    private var sightStackView = UIStackView()
    
    private var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            return setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSight()
        setupViews()
    }
    
    // MARK: TEMPORARY METHOD
    
    private func setupSight() {
        
        sightLabel = UILabel()
        sightLabel.textColor = .black
        sightLabel.font = .boldSystemFont(ofSize: 20)
        sightLabel.text = "Достопримечательности:"
        
        sightLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        sightStackView.addArrangedSubview(sightLabel)
        
        let sights = DataShights.shared.getSights()
        for sight in sights {
            let sightView = SightView(frame: CGRect(), sight: sight)
            
            sightStackView.addArrangedSubview(sightView)
        }
    }
    
    // MARK: SETUP VIEWS
    func setupViews() {
        
        // PROPERTY VIEWS
        
        statusBarStyle = .lightContent
        
        
        
        statusBarView.backgroundColor = UIColor(white: 1, alpha: 0)
        
        view.backgroundColor = .white
        
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        
        contentView = UIView()
        
        mainImage = UIImageView()
        mainImage.image = UIImage(named: "townImage")
        mainImage.contentMode = .scaleAspectFill
        mainImage.clipsToBounds = true
        
        dateAndTagView = UIView()
        
        dateLabel = UILabel()
        dateLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.text = "Последнее обновление: 06.06.2022"
        
        tagLabel = UILabel()
        tagLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 13)
        tagLabel.text = "Город - История"
        
        aboutObninskView = UIView()
        
        townHeaderLabel = UILabel()
        townHeaderLabel.textColor = .black
        townHeaderLabel.font = .boldSystemFont(ofSize: 28)
        townHeaderLabel.text = "Обнинск"
        
        townTextLabel = UILabel()
        townTextLabel.textColor = .black
        townTextLabel.numberOfLines = 0
        townTextLabel.font = .systemFont(ofSize: 17)
        townTextLabel.text = "Город областного значения на севере Калужской области, первый наукоград России."
        
        textHeaderLabel = UILabel()
        textHeaderLabel.textColor = .black
        textHeaderLabel.font = .boldSystemFont(ofSize: 20)
        textHeaderLabel.text = "Население:"
        
        textLabel = UILabel()
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 17)
        textLabel.text = """
        На 1 января 2022 года по численности населения город находился на 143-м месте из 1117 городов Российской Федерации.
        
        В Обнинске проживает 12 % населения области. Это второй по величине город в Калужской области после Калуги.
        
        Численность экономически активного населения — 59,05 тыс. человек.
        
        На предприятиях и организациях города занято 49,6 тыс. человек (без учёта предпринимателей без образования юридического лица), в том числе в материальном производстве — 37,9 % занятых, в непроизводственной сфере — 62,1 %.
        """
        
        sightStackView = UIStackView()
        sightStackView.axis = .vertical
        sightStackView.spacing = 8
        
        // CONSTRAINT
        
        let guide = view.safeAreaLayoutGuide
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(statusBarView)
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusBarView.topAnchor.constraint(equalTo: view.topAnchor),
            statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBarView.bottomAnchor.constraint(equalTo: guide.topAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32).isActive = true
        
        contentView.addSubview(mainImage)
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        mainImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        mainImage.heightAnchor.constraint(equalTo: mainImage.widthAnchor, multiplier: 316/375).isActive = true
        
        contentView.addSubview(dateAndTagView)
        dateAndTagView.translatesAutoresizingMaskIntoConstraints = false
        dateAndTagView.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 16).isActive = true
        dateAndTagView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        dateAndTagView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        dateAndTagView.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        dateAndTagView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: dateAndTagView.topAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: dateAndTagView.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: dateAndTagView.trailingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        dateAndTagView.addSubview(tagLabel)
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        tagLabel.leadingAnchor.constraint(equalTo: dateAndTagView.leadingAnchor).isActive = true
        tagLabel.trailingAnchor.constraint(equalTo: dateAndTagView.trailingAnchor).isActive = true
        tagLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        contentView.addSubview(aboutObninskView)
        aboutObninskView.translatesAutoresizingMaskIntoConstraints = false
        aboutObninskView.topAnchor.constraint(equalTo: dateAndTagView.bottomAnchor, constant: 12).isActive = true
        aboutObninskView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        aboutObninskView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        aboutObninskView.addSubview(townHeaderLabel)
        townHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        townHeaderLabel.topAnchor.constraint(equalTo: aboutObninskView.topAnchor).isActive = true
        townHeaderLabel.leadingAnchor.constraint(equalTo: aboutObninskView.leadingAnchor).isActive = true
        townHeaderLabel.trailingAnchor.constraint(equalTo: aboutObninskView.trailingAnchor).isActive = true
        townHeaderLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        aboutObninskView.addSubview(townTextLabel)
        townTextLabel.translatesAutoresizingMaskIntoConstraints = false
        townTextLabel.topAnchor.constraint(equalTo: townHeaderLabel.bottomAnchor, constant: 4).isActive = true
        townTextLabel.leadingAnchor.constraint(equalTo: aboutObninskView.leadingAnchor).isActive = true
        townTextLabel.trailingAnchor.constraint(equalTo: aboutObninskView.trailingAnchor).isActive = true
        
        aboutObninskView.addSubview(textHeaderLabel)
        textHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        textHeaderLabel.topAnchor.constraint(equalTo: townTextLabel.bottomAnchor, constant: 24).isActive = true
        textHeaderLabel.leadingAnchor.constraint(equalTo: aboutObninskView.leadingAnchor).isActive = true
        textHeaderLabel.trailingAnchor.constraint(equalTo: aboutObninskView.trailingAnchor).isActive = true
        textHeaderLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        aboutObninskView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: textHeaderLabel.bottomAnchor, constant: 16).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: aboutObninskView.bottomAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: aboutObninskView.leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: aboutObninskView.trailingAnchor).isActive = true
        
        contentView.addSubview(sightStackView)
        sightStackView.translatesAutoresizingMaskIntoConstraints = false
        sightStackView.topAnchor.constraint(equalTo: aboutObninskView.bottomAnchor, constant: 16).isActive = true
        sightStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        sightStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        sightStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        setupSight()
    }
    
}

// MARK: EXTENSION SCROLL

extension InfoViewController: UIScrollViewDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    // Поменять цвет статус бару
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let coordinates = CGFloat(scrollView.contentOffset.y)
        let finish: CGFloat = mainImage.frame.maxY - statusBarView.frame.height
        
        let alphaMultiplier = finish / coordinates
        
        if coordinates > finish {
            statusBarView.backgroundColor = UIColor(white: 1, alpha: 1)
            statusBarStyle = .darkContent
        } else {
            statusBarView.backgroundColor = UIColor(white: 1, alpha: 1 / alphaMultiplier)
            self.statusBarStyle = .lightContent
        }
    }
    
}
