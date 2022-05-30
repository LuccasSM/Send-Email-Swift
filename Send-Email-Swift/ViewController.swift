//
//  ViewController.swift
//  Send-Email-Swift
//
//  Created by Luccas Santana Marinho on 30/05/22.
//

import UIKit
import MessageUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Toque aqui", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(showMailComposer), for: .touchUpInside)
        return button
    }()
    
    @objc func showMailComposer() {
        
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["mathaluc2016@outlook.com"])
        composer.setSubject("recuperar senha!".uppercased())
        composer.setMessageBody("Olá recuperando sua senha, Senha nova é, 123456. OBS: Nunca a compartilhe com ninguém! Qualquer dúvida nos encontramos à disposição! Atenciosamente equipe de tecnologia Banco bankpf S.A (Email: ajuda-tecnologia@bankpf.com.br)", isHTML: false)
        
        present(composer, animated: true)
    }
}

extension ViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            controller.dismiss(animated: true)
            return
        }
        
        switch result {
        case .cancelled:
            print("Cancelado")
        case .failed:
            print("Falha ao enviar")
        case .saved:
            print("Salvo")
        case .sent:
            print("Email enviado")
        @unknown default:
            break
        }
        
        controller.dismiss(animated: true)
    }
}
