import UIKit
import DKSwitchSlider

class ViewController: UIViewController {
    
    lazy var switcher: DKSwitchSlider = {
        let switcher = DKSwitchSlider()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.onImage = UIImage(named: "icn-on")
        switcher.offImage = UIImage(named: "icn-off")
        switcher.thumbImage = UIImage(named: "icn-power")
        switcher.cornerRadius = 24
        switcher.thumbCornerRadius = 24
        switcher.isOn = true
        switcher.showLabel = true
        switcher.textColor = .white
        switcher.text = "ON"
        switcher.thumbBackgroundColor = .white
        switcher.thumbImageTintColor = .black
        switcher.onImageViewTintColor = .black
        switcher.offImageViewTintColor = .white
        switcher.addTarget(self, action: #selector(animateBackground), for: .valueChanged)

        return switcher
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(switcher)
        
        NSLayoutConstraint.activate([
            switcher.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            switcher.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            switcher.heightAnchor.constraint(equalToConstant: 56),
            switcher.widthAnchor.constraint(equalToConstant: 252),
        ])
    }
}

extension ViewController {
    @objc
    func animateBackground(sender: DKSwitchSlider) {
        UIView.animate(withDuration: 0.25) {
            self.switcher.text = sender.isOn ? "ON" : "OFF"
            self.switcher.textColor = sender.isOn ? .white : .black
            self.view.backgroundColor = sender.isOn ? UIColor(red: 1, green: 206/255, blue: 84/255, alpha: 1) : .black
        }
    }
}
