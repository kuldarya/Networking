import UIKit
import Alamofire
import AlamofireImage

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var photo: Photo? {
        didSet {
            self.titleLabel.text = photo?.title
            self.loadImage()
        }
    }
    
    func loadImage() {
        guard let thumbnailUrl = photo?.thumbnailUrl else {
            return
        }
        
        Alamofire.request(thumbnailUrl).responseImage { [weak self] (response) in
            guard let image = response.result.value else {
                return
            }
            DispatchQueue.main.async {
                self?.photoImageView.image = image
            }
        }
    }
}
