//
//  ActionViewController.swift
//  ShortURLBuilderAction
//
//  Created by Terry Tan on 19/10/2024.
//

import UIKit
import SwiftUI
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        guard
            let item = extensionContext?.inputItems.first as? NSExtensionItem,
            let itemProvider = item.attachments?.first as? NSItemProvider,
            itemProvider.canLoadObject(ofClass: URL.self)
        else {
            print("Did not receive input")
            close()
            return
        }

        itemProvider.loadItem(forTypeIdentifier: "public.url") { [weak self] secureCodingItem, error in
            guard let self else { return }

            guard let url = secureCodingItem as? URL else {
                close()
                return
            }
            print("URL: \(url.absoluteString)")

            Task { @MainActor in
                self.showURLView(url: url)
            }
        }
    }

    private func showURLView(url: URL) {
        let viewController = UIHostingController(rootView: ShortURLBuilderActionView(url: url) { [weak self] in
            self?.close()
        })
        view.addSubview(viewController.view)
        addChild(viewController)

        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        viewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    private func close() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        extensionContext!.completeRequest(returningItems: extensionContext!.inputItems, completionHandler: nil)
    }
}
