//
//  ViewController.swift
//  Closures
//
//  Created by Macbook on 15/01/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelNombre: UILabel!
    let stringTexto = ""
    let misPreferencias = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        //misPreferencias.removeObject(forKey: "nombre")
//        misPreferencias.set("Hugo", forKey: "nombre")
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        var miNombre = misPreferencias.string(forKey: "nombre") ?? ""
        if miNombre == ""{
           preguntarNombre()
            miNombre = misPreferencias.string(forKey: "nombre") ?? ""
            
            print("Placeholder \(miNombre)")
        }else{
            let alertController = UIAlertController(title: "Yes te conozco", message: "Bienvenido \(miNombre)", preferredStyle: .alert)
            let confirmar = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(confirmar)
            self.present(alertController, animated: true, completion: nil)
        }
        self.labelNombre?.text = miNombre
        
        let stringParaJson = "https://raw.githubusercontent.com/MonCab/CursoIntermedioIntersemestral/master/example.json"
       
        guard let url = URL(string: stringParaJson)  else{return}
        
        URLSession.shared.dataTask(with: url) {(data, response, err) in
            guard let data = data else {return}
            
           // let misDatos = String(data: data, encoding: .utf8)
         //   print(misDatos!)
            
            do{
                let miAlumno = try JSONDecoder().decode(Alumno.self, from: data)
                
            } catch let error{
                print("hubo error")
            }
        }.resume()
        
        
        
        
    }
    func preguntarNombre(){
        let alertController = UIAlertController(title: "Presentate", message: "Escribe tu nombre", preferredStyle: .alert)
        let confirmar = UIAlertAction(title: "Agregar", style: .default, handler: {
            (_) in
            if let textField = alertController.textFields?.first, let miTexto = textField.text{
                self.misPreferencias.set(miTexto, forKey: "nombre")
            }
            
        })
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel ){(_) in }
            alertController.addTextField{
                (textField) in
                textField.placeholder = "Ingresas tu nombre"
            }
        alertController.addAction(confirmar)
        alertController.addAction(cancelar)
        self.present(alertController, animated: true, completion: nil)
     return
    }

}

