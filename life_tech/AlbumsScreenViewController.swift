import UIKit
import Alamofire

class AlbumsScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var albumsArray: [Album] = []
    var url = "https://jsonplaceholder.typicode.com/albums"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(self.url).responseData { response in
            guard let data = response.data else { return }
            
            do {
                self.albumsArray = try
                    JSONDecoder().decode([Album].self, from: data)
            } catch {
                print("Error getting your data")
            }

            self.albumsArray.sort { $0.title < $1.title }
            
            self.tableView.reloadData()
        }
    }
}

extension AlbumsScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumTitleCell", for: indexPath) as? AlbumCell else {
            return UITableViewCell()
        }
        cell.album = self.albumsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "PhotosScreenViewController") as? PhotosScreenViewController else {
            return
        }
        controller.album = albumsArray[indexPath.item]
        self.navigationController?.pushViewController(controller, animated: true)

    }
}
