//
//  MovieDetailsViewController.swift
//  Cinetopia
//
//  Created by Guilherme Golfetto on 02/08/24.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    //-----------------------------------------------------------------------
    // MARK: - Subviews
    //-----------------------------------------------------------------------
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = movie.title
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: movie.image))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var classificationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Classificação dos usuários: \(movie.rate)"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = movie.synopsis
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    
    //-----------------------------------------------------------------------
    // MARK: - injected properties
    //-----------------------------------------------------------------------

    let movie: Movie
    
    //-----------------------------------------------------------------------
    // MARK: - initialization
    //-----------------------------------------------------------------------
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-----------------------------------------------------------------------
    // MARK: - view lifecycle
    //-----------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background
        addSubviews()
        setupConstraints()
    }
    
    
    //-----------------------------------------------------------------------
    // MARK: - private methods
    //-----------------------------------------------------------------------
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(posterImageView)
        view.addSubview(classificationLabel)
        view.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            posterImageView.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 200),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
            
            classificationLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 16),
            classificationLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: classificationLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            
        ])
    }

}

#Preview {
    MovieDetailsViewController(movie: movies[0])
}
