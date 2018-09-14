import Foundation
import UIKit
import Alamofire

class PhotosScreenViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var album: Album!
    var photosArray: [Photo] = []
    var url = URL(string: "https://jsonplaceholder.typicode.com/photos")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(self.url).responseData { response in
            guard let data = response.data else { return }
            
            do {
                self.photosArray = try JSONDecoder()
                    .decode([Photo].self, from: data)
                    .filter { $0.albumId == self.album.id }
            } catch {
                print("Error getting your data")
            }
                self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension PhotosScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.photo = self.photosArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "FullScreenViewController") as? FullScreenViewController else {
            return
        }
        controller.providesPresentationContextTransitionStyle = true
        controller.definesPresentationContext = true
        controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        controller.photo = self.photosArray[indexPath.item]
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
