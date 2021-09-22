//
//  DetailController.swift
//  IMDb
//
//  Created by DenisTirta on 22/09/21.
//

import UIKit
import SwiftyJSON
import SDWebImage
import LoadingPlaceholderView

class DetailController: UIViewController {

    var headerXib = DetailHeaderView()
    var tableList = UITableView()
    
    var list: TopMovies?
    var detail: Detail?
    
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
                .appendingPathComponent("detail\(list?.id ?? "").json")

            let data = try Data(contentsOf: fileURL)
            
            do {
                self.detail = try JSONDecoder().decode(Detail.self, from: data)
            } catch {
                self.view.toasShow(msg: error.localizedDescription, position: .bottom)
            }
            
            
            self.headerXib.valueTitle.text = self.detail?.title ?? ""
            self.tableList.reloadData()
            self.hiddenLoadingPlaceholderView()
            
        } catch {
            print("check url detail = \(ListAPI.detailMovie(id: list?.id ?? ""))")
            AFReq(url: ListAPI.detailMovie(id: list?.id ?? ""), view: self.view) { status, JSON, statusCode in
                if status{
                    print("sukses = \(JSON)")
                    
                    do {
                        self.detail = try JSONDecoder().decode(Detail.self, from: JSON.rawData())
                    } catch {
                        self.view.toasShow(msg: error.localizedDescription, position: .bottom)
                    }
                    
                    do {
                        let fileURL = try FileManager.default
                            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                            .appendingPathComponent("detail\(self.list?.id ?? "").json")

                        try JSON.rawData()
                            .write(to: fileURL)
                    } catch {
                        self.view.toasShow(msg: error.localizedDescription, position: .bottom)
                    }
                    
                    self.headerXib.valueTitle.text = self.detail?.title ?? ""
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
        headerXib = Bundle.main.loadNibNamed(DetailHeaderView.className, owner: nil, options: nil)?.first as! DetailHeaderView
        headerXib.delegate = self
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
        tableList.register(UINib(nibName: DetailHeaderCell.className, bundle: nil), forCellReuseIdentifier: DetailHeaderCell.className)
        tableList.register(UINib(nibName: DetailBodyCell.className, bundle: nil), forCellReuseIdentifier: DetailBodyCell.className)
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

extension DetailController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderCell.className, for: indexPath) as! DetailHeaderCell
            
            cell.valueYearHours.text = "Rank \(self.list?.rank ?? "") - \(self.detail?.year ?? "")"
            
            cell.valueImg?.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.valueImg.sd_setImage(with: URL(string: self.detail?.image ?? ""), placeholderImage: UIImage(named: "Default"))
            
            cell.valueBgImg?.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.valueBgImg.sd_setImage(with: URL(string: self.detail?.trailer?.thumbnailURL ?? ""), placeholderImage: UIImage(named: "Default"))
            
            cell.TimeTrailer.text = self.detail?.runtimeStr ?? ""
            
            cell.btnPhotos.setTitle("\(self.detail?.images?.items?.count ?? 0) Photos", for: .normal)

            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailBodyCell.className, for: indexPath) as! DetailBodyCell
            
            cell.valueGendre.text = self.detail?.genres ?? ""
            cell.valueCrew.text = self.list?.crew ?? ""
            cell.valuePlot.text = self.detail?.plot ?? ""
            cell.valueRating.text = self.detail?.imDBRating ?? ""
            
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
        
}

extension DetailController: DetailHeaderViewDelegate{
    func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

