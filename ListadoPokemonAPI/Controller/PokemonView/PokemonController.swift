//
//  PokemonController.swift
//  ListadoPokemonAPI
//
//  Created by Abel Lazaro on 03/09/22.
//

import UIKit

class PokemonController: UIViewController {

    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var numPokedexLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var habilityOneLabel: UILabel!
    @IBOutlet weak var habilityTowLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var attkLabel: UILabel!
    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var specialAttkLabel: UILabel!
    @IBOutlet weak var specialDefLabel: UILabel!
    
    var details: pokeDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataComponents()
        
    }
    
    private func setupDataComponents() {
        
        let url = URL(string: details!.sprites!.front_default!)!
        downloadImage(from: url)
        numPokedexLabel.text = "#\(details!.id!)"
        nameLabel.text = "Nombre: \(details!.name!)"
        
        switch details!.abilities?.count {
        case 1:
            habilityOneLabel.text = "Habilidad: \(details!.abilities![0].ability!.name!)"
            habilityTowLabel.isHidden = true
            break
        case 2:
            habilityOneLabel.text = "Habilidad 1: \(details!.abilities![0].ability!.name!)"
            habilityTowLabel.text = "Habilidad 2: \(details!.abilities![1].ability!.name!)"
            break
        default:
            print("")
        }
        
        heightLabel.text = "Altura: \(details!.height!)"
        weightLabel.text = "Peso: \(details!.weight!)"
        hpLabel.text = "HP: \(details!.stats![0].base_stat!)"
        attkLabel.text = "Attk: \(details!.stats![1].base_stat!)"
        defLabel.text = "Def:: \(details!.stats![2].base_stat!)"
        specialAttkLabel.text = "Attk Especial: \(details!.stats![3].base_stat!)"
        specialDefLabel.text = "Def Especial: \(details!.stats![4].base_stat!)"
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Descarga iniciada")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Descarga terminada")
            
            DispatchQueue.main.async() { [weak self] in
                self?.pokemonImageView.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: false)
        } else {
            self.dismiss(animated: false, completion: nil)
        }
    }

}
