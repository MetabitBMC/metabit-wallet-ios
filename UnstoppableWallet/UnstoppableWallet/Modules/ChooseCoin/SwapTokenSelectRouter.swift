import UIKit
import ThemeKit

class SwapTokenSelectRouter {
    weak var viewController: UIViewController?
}

extension SwapTokenSelectRouter: ISwapTokenSelectRouter {

    func close() {
        viewController?.dismiss(animated: true)
    }

}

extension SwapTokenSelectRouter {

    static func module(path: SwapPath, exclude: [Coin], delegate: ICoinSelectDelegate) -> UIViewController {
        let router = SwapTokenSelectRouter()
        let swapTokenManager = SwapTokenManager(coinManager: App.shared.coinManager, walletManager: App.shared.walletManager, adapterManager: App.shared.adapterManager)

        let interactor = SwapTokenSelectInteractor(swapCoinManager: swapTokenManager)
        let presenter = SwapTokenSelectPresenter(interactor: interactor, router: router, factory: CoinBalanceViewItemFactory(), delegate: delegate, path: path, exclude: exclude)
        let viewController = SwapTokenSelectViewController(delegate: presenter)

//        interactor.delegate = presenter
        presenter.view = viewController
        router.viewController = viewController

        return ThemeNavigationController(rootViewController: viewController)
    }

}
