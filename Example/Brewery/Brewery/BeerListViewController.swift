//
//  BeerListViewController.swift
//  Brewery
//
//  Created by 유한석 on 2022/03/01.
//

import UIKit

class BeerListViewController: UITableViewController{
    var beerList = [Beer]()
    var dataTasks = [URLSessionTask]()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UINavigationBar
        title = "패캠브루어리"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //UITableView 설정
        tableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell")
        tableView.rowHeight = 150
        tableView.prefetchDataSource = self
        fetchBeer(of: currentPage)
    }
}

extension BeerListViewController: UITableViewDataSourcePrefetching {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as? BeerListCell else { return UITableViewCell()}
        
        let beer = beerList[indexPath.row]
        cell.configure(with: beer)
        print("ROW: \(indexPath.row)")
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeer = beerList[indexPath.row]
        let detailViewController = BeerDetailViewController()
        
        detailViewController.beer = selectedBeer
        self.show(detailViewController, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentPage != 1 else { return }
        indexPaths.forEach{
            if ($0.row + 1)/25 + 1 == currentPage{
                self.fetchBeer(of: currentPage)
            }
        }
    }
}

// data Fetching
private extension BeerListViewController{
    func fetchBeer(of page: Int){
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)"),
        dataTasks.firstIndex(where: { $0.originalRequest?.url == url}) == nil
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request){[weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else{
                      print("ERROR : URL SESSION DATA TASK \(error?.localizedDescription)")
                      return
                  }
            switch response.statusCode{
            case (200...299): // 정상
                self.beerList += beers
                self.currentPage += 1
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case (400...499): // 클라이언트에러
                print("ERROR : CLIENT ERROR \(response.statusCode) ")
            case (500...599): // 서버에러
                print("ERROR : SERVER ERROR \(response.statusCode) ")
            default:
                print("ERROR : ERROR \(response.statusCode) ")
            }
        }
        
        dataTask.resume()
        dataTasks.append(dataTask)
    }
}
