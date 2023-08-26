//
//  ViewController.swift
//  ListadoPokemonAPI
//
//  Created by Abel Lazaro on 03/09/22.
//

import UIKit

class ViewController: UIViewController {

    var pokemones: pokeModel?
    
    var pokemonesFiltrados: [pokemon]?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getpokemon()
        tableView.reloadData()
    }

    private func getpokemon() {
        
        APIService.shared.getPokemones() { [weak self] (res, err) in
            if let err = err {
                print("Error al obtener pokemones", err)
                return
            }

            guard let res = res else { return }

            DispatchQueue.main.async {
                self?.pokemones = res
                self?.pokemonesFiltrados = self?.pokemones?.results
                self?.tableView.reloadData()
            }

        }
        
    }
    
    private func getPokemonDetails(url: String) {
        
        APIService.shared.getPokemonDetails(url: url) { [weak self] (res, err) in
            if let err = err {
                print("Error al obtener pokemones", err)
                return
            }

            guard let res = res else { return }

            DispatchQueue.main.async {
                
                let confirmView : PokemonController = UIStoryboard(name: "PokemonView", bundle: nil).instantiateViewController(withIdentifier: "PokemonController") as! PokemonController
                confirmView.providesPresentationContextTransitionStyle = true
                confirmView.definesPresentationContext = true
                confirmView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                confirmView.details = res
                self?.present(confirmView, animated: true, completion: nil)
                
            }

        }
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if pokemones?.results != nil {
            return pokemonesFiltrados!.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = pokemonesFiltrados![indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getPokemonDetails(url: pokemonesFiltrados![indexPath.row].url!)
    }
    
}


extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        pokemonesFiltrados?.removeAll()
        
        if searchText == "" || searchText.isEmpty {
            
            pokemonesFiltrados = pokemones?.results!
            view.endEditing(true)
            tableView.reloadData()
            
        } else {
            
            for pokemon in 0..<(pokemones?.results!.count)! {
                if pokemones!.results![pokemon].name!.forSorting.lowercased().localizedCaseInsensitiveContains(searchText.lowercased().forSorting) {
                    pokemonesFiltrados?.append(pokemones!.results![pokemon])
                }
            }
            
        }
        
        tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        view.endEditing(true)
    }


}

