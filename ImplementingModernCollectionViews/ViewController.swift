import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            let controller = UINavigationController(rootViewController: List2ViewController())
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true)
        })
    }
}

