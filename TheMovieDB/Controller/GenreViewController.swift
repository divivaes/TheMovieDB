
import UIKit

class GenreViewController: UITableViewController {
    
    var genres: [Genres] = []{
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        parseGenreTitles()
        largeTitleSetup()
        
    }
    
    func largeTitleSetup(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 1, green: 210, blue: 119)]
    }
    
    func parseGenreTitles(){
        guard let urlFeatured = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=02da584cad2ae31b564d940582770598&language=en-US")
            else { return }
        URLSession.shared.dataTask(with: urlFeatured) { (data, response, error) in
            guard let data = data else { return }
            do {
                let genreTitles = try JSONDecoder().decode(GenreTitles.self, from: data)
                self.genres = genreTitles.genres
            } catch let err{
                print("Err", err)
            }
            
            }.resume()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        let genre = genres[indexPath.row]
        cell.textLabel?.text = genre.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let moviesByGenreMovieController = MoviesByGenreViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let genre = genres[indexPath.row]
        moviesByGenreMovieController.genreId = genre.id
        moviesByGenreMovieController.genreTitle = genre.name
        navigationController?.pushViewController(moviesByGenreMovieController, animated: true)
    }
}
