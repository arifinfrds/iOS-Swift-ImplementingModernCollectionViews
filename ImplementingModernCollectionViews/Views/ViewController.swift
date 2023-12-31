import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            let loader = StubItemLoader()
            let controller = UINavigationController(rootViewController: List2ViewController(loader: loader))
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true)
        })
    }
}

