import UIKit


class GradientView: UIView {
    
    var gradientColors = [UIColor.orange, UIColor.red] {
        didSet { gradientLayer.colors = gradientColors.compactMap { colour in print(colour.cgColor); return colour.cgColor } }
    }
    
    var roundedCornerRatio: CGFloat = 0.0 {
        didSet {
            gradientLayer.frame = bounds
            //update mask layer
            let cornerPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width / 2 * roundedCornerRatio)
            let maskLayer = CAShapeLayer()
            maskLayer.path = cornerPath.cgPath
            layer.mask = maskLayer
            //may need to be redrawn as well
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private var gradientLayer: CAGradientLayer = {
        //setup
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        return gradientLayer
    }()
    
    convenience init(cornerRoundingRatio: CGFloat) {
        self.init(frame: CGRect(origin: CGPoint(x: 50.0, y: 50.0), size: CGSize(width: 50.0, height: 50.0)))
        roundedCornerRatio = cornerRoundingRatio
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.addSublayer(gradientLayer)
        roundedCornerRatio = 0.5
        gradientColors = [UIColor.orange, UIColor.red]
    }
    
    
}
