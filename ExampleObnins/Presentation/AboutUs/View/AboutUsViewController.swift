//
//  AboutUsViewController.swift
//  ExampleObnins
//
//  Created by Nikita Kolmykov on 19.01.2023.
//

import Foundation
import UIKit

class AboutUsViewController: UIViewController {
    
    private var imageViewObninsk: UIImageView!
    private var scrollViewAbout: UIScrollView!
    private var contentView: UIView!
    private var suggestView: UIView!
    private var textView = UITextView()
    private var suggestNewsButton: UIButton!
    private var suggestImage: UIImageView!
    
    var aboutUsViewModel: AboutUsViewModelType? {
        didSet {
            guard let model = aboutUsViewModel else { return }
            textView.attributedText = model.text.attributedHtmlString
            textView.textAlignment = .natural
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutUsViewModel = AboutUsViewModel(networkService: APIService(), view: self)
        
        setupView()
        
        suggestNewsButton.addTarget(self, action: #selector(transitToSuggest(sender: )), for: .touchUpInside)
    }
    
    // MARK: METHODS
    
    @objc func transitToSuggest(sender: UIButton) {
        
        let vc = SuggestNewsView()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func updateData(text: String) {
        textView.text = text
    }
    
    // MARK: SETUP VIEW
    
    func setupView() {
        
        // PROPERTY VIEW
        
        view.backgroundColor = .white
        
        imageViewObninsk = UIImageView(image: UIImage(named: "obninskName"))
        imageViewObninsk.contentMode = .center
        
        suggestView = UIView()
        
        scrollViewAbout = UIScrollView()
        scrollViewAbout.contentOffset.y = 16
        
        contentView = UIView()
        
        textView = UITextView()
        textView.backgroundColor = .white
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 17)
        textView.textColor = .black
        
        suggestNewsButton = UIButton()
        suggestNewsButton.layer.cornerRadius = 8
        suggestNewsButton.clipsToBounds = true
        suggestNewsButton.backgroundColor = .systemBlue
        suggestNewsButton.setTitle("Предложить новость", for: .normal)
        suggestNewsButton.titleLabel?.textColor = .white
        suggestNewsButton.setTitleColor(UIColor.init(white: 1, alpha: 0.3), for: .highlighted)
        
        // CONSTRAINT
        
        view.addSubview(imageViewObninsk)
        imageViewObninsk.translatesAutoresizingMaskIntoConstraints = false
        imageViewObninsk.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageViewObninsk.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageViewObninsk.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageViewObninsk.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        view.addSubview(suggestView)
        suggestView.translatesAutoresizingMaskIntoConstraints = false
        suggestView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        suggestView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        suggestView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        suggestView.heightAnchor.constraint(equalToConstant: 76).isActive = true
        
        suggestView.addSubview(suggestNewsButton)
        suggestNewsButton.translatesAutoresizingMaskIntoConstraints = false
        suggestNewsButton.topAnchor.constraint(equalTo: suggestView.topAnchor, constant: 16).isActive = true
        suggestNewsButton.bottomAnchor.constraint(equalTo: suggestView.bottomAnchor, constant: -16).isActive = true
        suggestNewsButton.leadingAnchor.constraint(equalTo: suggestView.leadingAnchor, constant: 16).isActive = true
        suggestNewsButton.trailingAnchor.constraint(equalTo: suggestView.trailingAnchor, constant: -16).isActive = true
        
        view.addSubview(scrollViewAbout)
        scrollViewAbout.translatesAutoresizingMaskIntoConstraints = false
        scrollViewAbout.topAnchor.constraint(equalTo: imageViewObninsk.bottomAnchor).isActive = true
        scrollViewAbout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        scrollViewAbout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        scrollViewAbout.bottomAnchor.constraint(equalTo: suggestView.topAnchor).isActive = true
        
        scrollViewAbout.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollViewAbout.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollViewAbout.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollViewAbout.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollViewAbout.trailingAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollViewAbout.centerXAnchor).isActive = true
        
        contentView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
}
