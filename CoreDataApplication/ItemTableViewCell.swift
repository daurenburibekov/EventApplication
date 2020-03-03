import UIKit

class ItemTableViewCell: UITableViewCell {

    private let catmanager = CategoryManager()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    func configureCell(event: Event){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        setupBg(event: event)
        titleLabel.text = event.name
        typeLabel.text = (catmanager.getCategory(id: Int(event.categoryId)))?.name
        dateLabel.text = formatter.string(from: event.date!)
        placeLabel.text = event.place
        
    }

    func setupBg(event: Event){
        titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        typeLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        dateLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        placeLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        bgView.layer.cornerRadius = 10;
        if event.categoryId == 2{
            self.bgView.backgroundColor = #colorLiteral(red: 1, green: 0.5401105881, blue: 0.5554484725, alpha: 1)
        } else if event.categoryId == 3{
            self.bgView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.5852756561, alpha: 1)
        } else if event.categoryId == 4{
            self.bgView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        } else if event.categoryId == 1{
            self.bgView.backgroundColor = #colorLiteral(red: 0.7464560866, green: 0.5540207624, blue: 0.9708413482, alpha: 1)
        }
    }
}
