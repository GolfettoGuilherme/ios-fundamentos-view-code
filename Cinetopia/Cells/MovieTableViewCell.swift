//
//  MovieTableViewCell.swift
//  Cinetopia
//
//  Created by Guilherme Golfetto on 02/08/24.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //-----------------------------------------------------------------------
    // MARK: - subviews
    //-----------------------------------------------------------------------
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true 
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white.withAlphaComponent(0.75)
        return label
    }()
    
    //-----------------------------------------------------------------------
    // MARK: - initialization
    //-----------------------------------------------------------------------
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupContraints()
        backgroundColor = .background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-----------------------------------------------------------------------
    // MARK: - overrides
    //-----------------------------------------------------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------
    
    func configureCell(movie: Movie) {
        titleLabel.text = movie.title
        posterImageView.image = UIImage(named: movie.image)
        releaseDateLabel.text = "Lançamento: \(movie.releaseDate)"
    }
    
    //-----------------------------------------------------------------------
    // MARK: - private methods
    //-----------------------------------------------------------------------
    
    private func addSubviews() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
    }
    
    private func setupContraints() {
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            releaseDateLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16)
        ])
        
    }

}
