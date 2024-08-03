//
//  MoviesViewController.swift
//  Cinetopia
//
//  Created by Giovanna Moeller on 30/10/23.
//

import UIKit

class MoviesViewController: UIViewController {
    
    //-----------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------
    
    private var filteredMovies: [Movie] = []
    private var isSearchActive: Bool = false
    private var movieService: MovieService = MovieService()
    
    //-----------------------------------------------------------------------
    // MARK: - Subviews
    //-----------------------------------------------------------------------
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Pesquisar"
        searchBar.searchTextField.backgroundColor = .white
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
       let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false //necessário
        tableview.backgroundColor = .clear //limpar o fundo
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        return tableview
    }()
    
    //-----------------------------------------------------------------------
    // MARK: - View Lifecycle
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setupNavigationBar()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        addSubviews()
        setupContraints()
        fetchMovies()
    }
    
    
    //-----------------------------------------------------------------------
    // MARK: - Private methods
    //-----------------------------------------------------------------------
    
    @objc private func hideKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    private func fetchMovies() {
        movieService.getMovies { movies in
            print(movies)
        }
    }

    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            
            //tableview se prendendo ao redor da tela
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), //prender no topo da tela
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor), //prender ao leading
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor), //prender ao traling
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) //prender no bottom
            
        ])
    }
    
    private func setupNavigationBar() {
        
        title = "Filmes Populares"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.titleView = searchBar
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//-----------------------------------------------------------------------
// MARK: - UITableViewDataSource and UITableViewDelegate
//-----------------------------------------------------------------------

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearchActive ? filteredMovies.count : movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell {
            
            let movie = isSearchActive ? filteredMovies[indexPath.row] : movies[indexPath.row]
            
            cell.configureCell(movie: movie)
            cell.selectionStyle = .none
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = isSearchActive ? filteredMovies[indexPath.row] : movies[indexPath.row]
        
        let detailsVC = MovieDetailsViewController(movie: movie)
        
        navigationController?.pushViewController(detailsVC,animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 160 }

}


extension MoviesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            isSearchActive = false
        } else {
            isSearchActive = true
            filteredMovies = movies.filter({ movie in
                movie.title.lowercased().contains(searchText.lowercased())
            })
        }
        
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // para sumir com o teclado
    }
    
}
