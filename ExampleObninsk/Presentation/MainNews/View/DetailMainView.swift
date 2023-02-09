//
//  DetailMainView.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 20.01.2023.
//

import UIKit
import Kingfisher

class DetailMainView: UIViewController {
    
    private var statusBarView = UIView()
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var backButton = UIButton()
    private var imageView = UIImageView()
    private var dateLabel = UILabel()
    private var tagLabel = UILabel()
    private var titleLable = UILabel()
    private var textView = UITextView()
    private var authorLabel = UILabel()
    private var authorNameLabel = UILabel()
    private var reviewCountImage = UIImageView()
    private var reviewCountLabel = UILabel()
    
    var detailMainViewModel: DetailMainViewModelType? {
        willSet(detailMainViewModel) {
            guard let detailModel = detailMainViewModel else { return }
            imageView.kf.setImage(with: URL(string: detailModel.image))
            dateLabel.text = detailModel.date
            tagLabel.text = detailModel.tag
            titleLable.text = detailModel.title
            textView.attributedText = detailModel.text.attributedHtmlString
            authorNameLabel.text = detailModel.author
            reviewCountLabel.text = detailModel.reviewCount
        }
    }
    
    private var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            return setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        
        backButton.addTarget(self, action: #selector(back(sender: )), for: .touchUpInside)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    // MARK: METHODS
    
    @objc private func back(sender: UIButton) {
        dismiss(animated: true)
    }
    
    // MARK: SETUP VIEW
    
    func setupViews() {
        
        // PROPERTY VIEW
        statusBarStyle = .lightContent
        
        statusBarView.backgroundColor = UIColor(white: 1, alpha: 0)
        
        view.backgroundColor = .white
        
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        dateLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 15)
        
        tagLabel.textColor = .systemGray
        tagLabel.font = .systemFont(ofSize: 15)
        
        titleLable.textColor = .black
        titleLable.numberOfLines = 0
        titleLable.font = .boldSystemFont(ofSize: 21)
        
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textAlignment = .natural
        textView.font = .systemFont(ofSize: 17)
        
        authorLabel.textColor = .systemGray
        authorLabel.font = .systemFont(ofSize: 17)
        authorLabel.text = "Автор публикации"
        
        authorLabel.textColor = .black
        authorNameLabel.font = .boldSystemFont(ofSize: 17)
        
        reviewCountImage.contentMode = .scaleAspectFill
        reviewCountImage.image = UIImage(named: "countOfViews")
        
        reviewCountLabel.textColor = .black
        reviewCountLabel.font = .boldSystemFont(ofSize: 17)
        
        // CONSTRAINT
        
        let guide = view.safeAreaLayoutGuide
        
        view.addSubviews(scrollView)
        view.addSubview(statusBarView)
        view.addSubview(backButton)
        
        scrollView.addSubviews(contentView)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        contentView.addSubviews(imageView,dateLabel,tagLabel,titleLable,textView,authorLabel,authorNameLabel,reviewCountLabel,reviewCountImage)
        
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        statusBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        statusBarView.bottomAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 275/375).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        tagLabel.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 22).isActive = true
        tagLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16).isActive = true
        titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLable.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 8).isActive = true
        textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        textView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 24).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor).isActive = true
        authorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        authorNameLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        authorNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24).isActive = true
        
        reviewCountLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewCountLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 35).isActive = true
        reviewCountLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        reviewCountLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        reviewCountImage.translatesAutoresizingMaskIntoConstraints = false
        reviewCountImage.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 38).isActive = true
        reviewCountImage.rightAnchor.constraint(equalTo: reviewCountLabel.leftAnchor, constant: -12).isActive = true
        reviewCountImage.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }

}

// MARK: EXTENSION SCROLL

extension DetailMainView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let coordinates = CGFloat(scrollView.contentOffset.y)
        let finish: CGFloat = imageView.frame.maxY - statusBarView.frame.height
        
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
