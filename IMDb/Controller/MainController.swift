//
//  MainController.swift
//  IMDb
//
//  Created by DenisTirta on 21/09/21.
//

import UIKit
import SwiftyJSON
import SDWebImage
import LoadingPlaceholderView

class MainController: UIViewController {
    
    var headerXib = HeaderStyle1View()
    var tableList = UITableView()
    var list: [TopMovies]?
    var loadingPlaceholderView = LoadingPlaceholderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoadingPlaceholderView()
        setupHeader()
        setupTable()
        
        callAPI()
        
    }
    
    func setupLoadingPlaceholderView() {
        setNeedsStatusBarAppearanceUpdate()
        
        loadingPlaceholderView.gradientColor = .white
        loadingPlaceholderView.backgroundColor = .white
        loadingPlaceholderView.cover(view)
    }
    
    func hiddenLoadingPlaceholderView() {
        // simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.setNeedsStatusBarAppearanceUpdate()
            self?.loadingPlaceholderView.uncover()
        }
    }
    
    private func callAPI(){
        do {
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("top250.json")

            let data = try Data(contentsOf: fileURL)
            
            do {
                self.list = try JSONDecoder().decode([TopMovies].self, from: data)
            } catch {
                self.view.toasShow(msg: error.localizedDescription, position: .bottom)
            }
            
            self.tableList.reloadData()
            self.hiddenLoadingPlaceholderView()
            
        } catch {
            AFReq(url: ListAPI.listTop250Movies(), view: self.view) { status, JSON, statusCode in
                if status{
                    print("sukses = \(JSON)")
                    
                    do {
                        self.list = try JSONDecoder().decode([TopMovies].self, from: JSON["items"].rawData())
                    } catch {
                        self.view.toasShow(msg: error.localizedDescription, position: .bottom)
                    }
                    
                    do {
                        let fileURL = try FileManager.default
                            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                            .appendingPathComponent("top250.json")

                        try JSON["items"].rawData()
                            .write(to: fileURL)
                    } catch {
                        self.view.toasShow(msg: error.localizedDescription, position: .bottom)
                    }
                    
                    self.tableList.reloadData()
                    self.hiddenLoadingPlaceholderView()
                }else{
                    print("error = \(JSON)")
                    self.hiddenLoadingPlaceholderView()
                }
            }

        }
    }

    private func setupHeader(){
        headerXib = Bundle.main.loadNibNamed(HeaderStyle1View.className, owner: nil, options: nil)?.first as! HeaderStyle1View
        self.view.addSubview(headerXib)
    
        headerXib.translatesAutoresizingMaskIntoConstraints = false
        headerXib.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        headerXib.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        headerXib.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0).isActive = true
        headerXib.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0/3.5).isActive = true
    }
    
    private func setupTable(){
        tableList.delegate = self
        tableList.dataSource = self
        tableList.separatorStyle = .none
        tableList.register(UINib(nibName: CollectionListCell.className, bundle: nil), forCellReuseIdentifier: CollectionListCell.className)
        tableList.register(UINib(nibName: ListStyle2Cell.className, bundle: nil), forCellReuseIdentifier: ListStyle2Cell.className)
        tableList.register(UINib(nibName: ListStyle3Cell.className, bundle: nil), forCellReuseIdentifier: ListStyle3Cell.className)
        self.view.addSubview(tableList)

        tableList.translatesAutoresizingMaskIntoConstraints = false
        tableList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        tableList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        tableList.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.width/3.5).isActive = true
        tableList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true        
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension MainController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.list?.count ?? 0 > 0{
            return 3
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 10
        case 2:
            return 1
        default:
            return 0
        }
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionListCell.className, for: indexPath) as! CollectionListCell
            
            if self.list?.count ?? 0 > 0{
                cell.list = self.list
                cell.setupColletion()
            }
            
            cell.delegate = self
            return cell
        case 1:
            let rank = Int(self.list?[indexPath.row+10].rank ?? "0") ?? 0
            if rank % 2 == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: ListStyle3Cell.className, for: indexPath) as! ListStyle3Cell

                cell.imgMovie?.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
                cell.imgMovie.sd_setImage(with: URL(string: self.list?[indexPath.row+10].image ?? ""), placeholderImage: UIImage(named: "Default"))

                cell.valueRating.text = self.list?[indexPath.row+10].imDBRating ?? ""
                cell.valueYear.text = self.list?[indexPath.row+10].year ?? ""
                cell.nameMovie.text = self.list?[indexPath.row+10].title ?? ""
                cell.valueCrew.text = self.list?[indexPath.row+10].crew ?? ""
                
                cell.bgView.layer.borderColor = UIColor.white.cgColor
                cell.bgView.layer.borderWidth = 1
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: ListStyle2Cell.className, for: indexPath) as! ListStyle2Cell

                cell.imgMovie?.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
                cell.imgMovie.sd_setImage(with: URL(string: self.list?[indexPath.row+10].image ?? ""), placeholderImage: UIImage(named: "Default"))

                cell.valueRating.text = self.list?[indexPath.row+10].imDBRating ?? ""
                cell.valueYear.text = self.list?[indexPath.row+10].year ?? ""
                cell.nameMovie.text = self.list?[indexPath.row+10].title ?? ""
                cell.valueCrew.text = self.list?[indexPath.row+10].crew ?? ""
                
                cell.bgView.layer.borderColor = UIColor.white.cgColor
                cell.bgView.layer.borderWidth = 1
                cell.selectionStyle = .none
                return cell
            }
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionListCell.className, for: indexPath) as! CollectionListCell
            
            let count = self.list?.count ?? 0
            if count > 0{
                cell.list = self.list
                cell.count = count - 20
                cell.setupColletion2()
            }
            
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailController.className) as! DetailController
            controller.list = self.list?[indexPath.row+10]
            self.navigationController?.pushViewController(controller, animated: true)
        default:
            break
        }
    }
    
}

extension MainController: CollectionListCellDelegate{
    func actionDetail(index: Int) {
        let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailController.className) as! DetailController
        controller.list = self.list?[index]
        self.navigationController?.pushViewController(controller, animated: true)

    }
}
