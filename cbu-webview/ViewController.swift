
import UIKit
import WebKit
import AuthenticationServices
import SwiftUI



extension UIColor {
    convenience init?(hex: String) {
        var rgb: UInt64 = 0
        let scanner = Scanner(string: hex.trimmingCharacters(in: .whitespacesAndNewlines))
        if hex.hasPrefix("#") {
            scanner.currentIndex = scanner.string.index(after: scanner.currentIndex)
        }
        if scanner.scanHexInt64(&rgb) {
            let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgb & 0x0000FF) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: 1.0)
            return
        }
        return nil
    }
}



class ViewController: UIViewController {
    
    @State private var finished = false
    
    
    // UIImageView for the icon
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo") // Replace "iconName" with the name you gave the icon image
        imageView.contentMode = .scaleAspectFit // Adjust the image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    // Create the label
    let myLabel: UILabel = {
        let label = UILabel()
        label.text = "Bem-vindo ao By Unico!"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont(name: "AtkinsonHyperlegible-Bold" , size: 18) // Change "FontName" to the desired font name
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false// Allows the use of Auto Layout
        return label
    }()
    
    let myLabel2: UILabel = {
        let label = UILabel()
        label.text = "Abaixo insira o ID gerado:"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.font = UIFont(name: "AtkinsonHyperlegible-Regular" , size: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false// Allows the use of Auto Layout
        return label
    }()
    
    // create a input
    let  inputTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Insira seu texto aqui"
        textField.layer.cornerRadius = 10
        textField.font = UIFont(name: "AtkinsonHyperlegible-Regular" , size: 14)
        textField.borderStyle = .roundedRect // sets the border style
        textField.translatesAutoresizingMaskIntoConstraints = false // Allows the use of Auto Layout
        return textField
    }()
    
    
    
    // create a button
    let confirmButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(hex: "#1172eb")
        button.setTitleColor(.white, for: .normal) // Text in white
        button.titleLabel?.font = UIFont(name: "AtkinsonHyperlegible-Bold", size: 16)
        button.layer.cornerRadius = 10 // Rounded edges
        button.layer.masksToBounds = true // sets Rounded edges
        button.setTitle("Confirmar", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false // Allows the use of Auto Layout
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        //
        
        
        // Adds icons,labels and button to the view
        view.addSubview(iconImageView)
        view.addSubview(myLabel)
        view.addSubview(myLabel2)
        view.addSubview(inputTextField)
        view.addSubview(confirmButton)
        
        // setting constraints to the icon
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            iconImageView.heightAnchor.constraint(equalToConstant: 80), // Change as per your need
            iconImageView.widthAnchor.constraint(equalToConstant: 80)   // Change as per your need
        ])
        // Define the constraints of the label
        NSLayoutConstraint.activate([
            myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120),
            myLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // left side limit
            myLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20) // right side limit
            
            
            
        ])
        
        NSLayoutConstraint.activate([
            myLabel2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myLabel2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            myLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // left side limit
            myLabel2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20) // right side limit
            
            
            
        ])
        
        // Sets the constraints of the input
        NSLayoutConstraint.activate([
            inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputTextField.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 45),
            inputTextField.widthAnchor.constraint(equalToConstant: 290) // Sets the width of the input field
        ])
        
        // Sets the constraints of the button
        NSLayoutConstraint.activate([
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 130),
            confirmButton.heightAnchor.constraint(equalToConstant: 40), // Sets the heigth of the button
            confirmButton.widthAnchor.constraint(equalToConstant: 290)  // Sets the width of the button
        ])
    }
    @objc func dismissKeyboard() {
        // Method to hide the keyboard
        view.endEditing(true)
    }
    
    @objc func buttonTapped() {
                 guard let urlString = inputTextField.text, !urlString.isEmpty else {
                    showErrorAlert("\nPor favor, insira uma URL. b,mn\n Please enter a URL.")
                    return
                }
                    let fullURLString = "https://cadastro.uat.unico.app/process/\(urlString)"
                    guard let url = URL(string: fullURLString) else {
                    showErrorAlert("\nA URL inserida não é válida.\n\n The URL entered is not valid.")
                    return
                }
        

            func showErrorAlert(_ message: String) {
                let alert = UIAlertController(title: "Atenção/Attention", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        
            // Force the orientation for portrait
        var supportedInterfaceOrientations: UIInterfaceOrientationMask {
                    return .portrait // Sets only the portait orientation
                }
        var shouldAutorotate: Bool {
                    return false // disable the automatic orientation
                }
        
        let unicoController = UnicoAuthenticationController()
        
        
            var session: ASWebAuthenticationSession?
            session = ASWebAuthenticationSession(url: url, callbackURLScheme: "BUNDLE") { callbackURL, error in
                guard callbackURL != nil else {
                    if let error = error {
                        return print("Erro durante o processo: \(error.localizedDescription)")
                    }
                    return
                }
                
                // Process the URL`s callback for to verificate if the process has been finished
                session?.cancel()
                self.finished = true
            }
            
            session?.presentationContextProvider = unicoController
            session?.prefersEphemeralWebBrowserSession = true
            session?.start()
        }
        
    }
    

    
    class UnicoAuthenticationController: NSObject, ASWebAuthenticationPresentationContextProviding {
        
        @State private var finished = false
        func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let mainWindow = windowScene.windows.first {
                    return mainWindow
                }
            }
            return ASPresentationAnchor()
            
            
        }
     
        
    }
    

