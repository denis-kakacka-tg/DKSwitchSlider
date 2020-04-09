import UIKit

open class DKSwitchSliderThumbView: UIView {
    fileprivate let thumbImageView = UIImageView(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = false
        thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thumbImageView)
        
        NSLayoutConstraint.activate([
            thumbImageView.heightAnchor.constraint(equalToConstant: 24),
            thumbImageView.widthAnchor.constraint(equalToConstant: 24),
            thumbImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

open class DKSwitchSlider: UIControl {
    
    private var thumbView = DKSwitchSliderThumbView(frame: .zero)
    private var onImageView = UIImageView(frame: .zero)
    private var offImageView = UIImageView(frame: .zero)
    private var onPoint = CGPoint.zero
    private var offPoint = CGPoint.zero
    private var isAnimating = false
    
    public var animationOptions: UIView.AnimationOptions = [
        UIView.AnimationOptions.curveEaseOut,
        UIView.AnimationOptions.beginFromCurrentState,
        UIView.AnimationOptions.allowUserInteraction
    ]
    
    public var isOn: Bool = true
    public var animationDuration: TimeInterval = 0.35
    public var cornerRadius: CGFloat = 0
    
    public var onTintColor: UIColor = UIColor(red: 59/255, green: 140/255, blue: 0, alpha: 1) {
        didSet {
            setupUI()
        }
    }
    
    public var offTintColor: UIColor = UIColor(red: 212/255, green: 218/255, blue: 230/255, alpha: 1) {
        didSet {
            setupUI()
        }
    }
    
    public var onImage: UIImage? {
        didSet {
            onImageView.image = onImage
        }
    }
    
    public var onImageViewTintColor: UIColor = .black {
        didSet {
            onImageView.tintColor = onImageViewTintColor
        }
    }
    
    public var offImageViewTintColor: UIColor = .black {
         didSet {
             offImageView.tintColor = offImageViewTintColor
         }
     }
    
    public var offImage: UIImage? {
        didSet {
            offImageView.image = offImage
        }
    }
    
    // MARK: - Label
    public var showLabel: Bool = true {
        didSet {
            setupUI()
        }
    }
    
    public var textLabel = UILabel() {
        didSet {
            setupUI()
        }
    }
    
    public var textColor = UIColor.white {
        didSet {
            setupUI()
        }
    }
    
    public var text: String = "" {
        didSet {
            setupUI()
        }
    }
    
    // MARK: - Thumb
    public var thumbImageView: UIImageView {
        return thumbView.thumbImageView
    }
    
    public var thumbImage: UIImage? = nil {
        didSet {
            guard let image = thumbImage else { return }
            thumbView.thumbImageView.image = image
        }
    }
    
    public var thumbImageTintColor: UIColor = .blue {
        didSet {
            thumbView.thumbImageView.tintColor = thumbImageTintColor
        }
    }
    
    public var thumbShadowColor: UIColor = UIColor.black {
        didSet {
            thumbView.layer.shadowColor = thumbShadowColor.cgColor
        }
    }
    
    public var thumbShadowOffset: CGSize = CGSize(width: 0.75, height: 2) {
        didSet {
            thumbView.layer.shadowOffset = thumbShadowOffset
        }
    }
    
    public var thumbShaddowRadius: CGFloat = 1.5 {
        didSet {
            thumbView.layer.shadowRadius = thumbShaddowRadius
        }
    }
    
    public var thumbShaddowOppacity: Float = 0.4 {
        didSet {
            thumbView.layer.shadowOpacity = thumbShaddowOppacity
        }
    }
    
    public var thumbCornerRadius: CGFloat = 0 {
        didSet {
            thumbView.layer.cornerRadius = thumbCornerRadius
        }
    }
    
    public var thumbBackgroundColor: UIColor = UIColor.white {
        didSet {
            self.thumbView.backgroundColor = thumbBackgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        animate()
        return true
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isAnimating {
            layer.cornerRadius = cornerRadius
            backgroundColor = isOn ? onTintColor : offTintColor
            
            let thumbSize = thumbView.frame.size != CGSize.zero ? thumbView.frame.size : CGSize(width: bounds.size.height - 4, height: bounds.height - 4)
            let yPostition = (bounds.size.height - thumbSize.height) / 2
            onPoint = CGPoint(x: bounds.size.width - thumbSize.width - 4, y: yPostition)
            offPoint = CGPoint(x: 4, y: yPostition)
            thumbView.frame = CGRect(origin: isOn ? onPoint : offPoint, size: thumbSize)
            thumbView.layer.cornerRadius = thumbCornerRadius
            
            let frameSize = thumbSize.width > thumbSize.height ? thumbSize.height * 0.6 : thumbSize.width * 0.6
            let onOffImageSize = CGSize(width: frameSize, height: frameSize)
            
            if onImage != nil {
                onImageView.frame.size = onOffImageSize
                onImageView.center = CGPoint(x: onPoint.x + thumbView.frame.size.width / 2, y: thumbView.center.y)
                onImageView.isHidden = isOn
            }
            
            if offImage != nil {
                offImageView.frame.size = onOffImageSize
                offImageView.center = CGPoint(x: offPoint.x + thumbView.frame.size.width / 2, y: thumbView.center.y)
                offImageView.isHidden = !isOn
            }
        }
    }
}

// MARK: - Private
extension DKSwitchSlider {
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func setupUI() {
        clear()
        clipsToBounds = false
        backgroundColor = isOn ? onTintColor : offTintColor
        
        thumbView.backgroundColor = thumbBackgroundColor
        thumbView.layer.shadowColor = thumbShadowColor.cgColor
        thumbView.layer.shadowRadius = thumbShaddowRadius
        thumbView.layer.shadowOpacity = thumbShaddowOppacity
        thumbView.layer.shadowOffset = thumbShadowOffset
        
        onImageView.contentMode = .scaleAspectFit
        offImageView.contentMode = .scaleAspectFit
        
        addSubview(thumbView)
        addSubview(onImageView)
        addSubview(offImageView)
        
        setupLabel()
    }
    
    private func setupLabel() {
        guard self.showLabel else { return }
        
        textLabel.textAlignment = .center
        textLabel.textColor = textColor
        textLabel.text = text
        textLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(textLabel, belowSubview: thumbView)
        textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setOnOffImageFrame() {
        guard onImage != nil || offImage != nil else { return }
        
        onImageView.center.x = !isOn ? onPoint.x + thumbView.frame.size.width / 2 : frame.width - onImageView.frame.width / 2
        offImageView.center.x = isOn ? offPoint.x + thumbView.frame.size.width / 2 : offImageView.frame.width / 2
        onImageView.isHidden = isOn
        offImageView.isHidden = !isOn
    }
    
    private func animate(on: Bool? = nil) {
        isOn = on ?? !isOn
        sendActions(for: UIControl.Event.valueChanged)
        isAnimating = true
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.25, options: animationOptions, animations: {
            self.setupViewsOnAction()
        }, completion: { _ in
            self.isAnimating = false
        })
    }
    
    private func setupViewsOnAction() {
        thumbView.frame.origin.x = isOn ? onPoint.x : offPoint.x
        backgroundColor = isOn ? onTintColor : offTintColor
        setOnOffImageFrame()
    }
}
