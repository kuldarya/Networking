import UIKit
import Alamofire
import AlamofireImage

class FullScreenViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.loadFullScreenImage()
        }
    
    @IBAction func closeFullScreenButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadFullScreenImage() {
        guard let fullScreenImageUrl = photo?.url else {
            return
        }
        
        Alamofire.request(fullScreenImageUrl).responseImage { [weak self] (response) in
            guard let image = response.result.value else {
                return
            }
            DispatchQueue.main.async {
                self?.photoImageView.image = image
            }
        }
    }
}
