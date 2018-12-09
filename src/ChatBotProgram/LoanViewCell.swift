


import UIKit

protocol LoanButtonPressedDelegate {
    func addPressed()
}

class LoanViewCell: UITableViewCell {
    
    var delegate: LoanButtonPressedDelegate?

    
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var labelContainerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    //change later
    @IBAction func addLoanLabel(_ sender: UIButton) {
        delegate?.addPressed()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconImageView.layer.cornerRadius = 16
        iconImageView.layer.masksToBounds = true
        
        labelContainerView.layer.cornerRadius = 8
        labelContainerView.layer.masksToBounds = true
        
        labelContainerView.backgroundColor = .orange
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with message: Message) {
        
        iconImageView.image = UIImage(named: message.getImage())
        
        messageLabel.text = message.text
        messageLabel.textColor = .chatBackgroundStart
        
        let dateFormatterMessage = DateFormatter()
        dateFormatterMessage.setLocalizedDateFormatFromTemplate("hh:mm")
        timeLabel.text = dateFormatterMessage.string(from: message.date)
        timeLabel.textColor = .mainGreen
        
    }
}
