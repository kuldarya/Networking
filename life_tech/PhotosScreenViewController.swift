import UIKit
import Alamofire

class PhotosCellViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photosArray: [Photo] = []
    var url = ("https://jsonplaceholder.typicode.com/photos")

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


}
