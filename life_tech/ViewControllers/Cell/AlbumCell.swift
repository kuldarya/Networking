import UIKit

class AlbumCell: UITableViewCell {

    @IBOutlet weak var albumTitleLabel: UILabel!
    
    var album: Album? {
        didSet {
            self.albumTitleLabel.text = album?.title
            self.albumTitleLabel.text = album?.title.capitalizingFirstLetter()
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
