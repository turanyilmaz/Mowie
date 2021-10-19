//
//  ListView.swift
//  Mowie
//
//  Created by Turan Yilmaz on 7.04.2021.
//

import UIKit

protocol ListViewDelegate: AnyObject {
    func scrollViewDidScroll(scrollView: UIScrollView)
}

final class ListView: CustomView {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: ListViewDelegate?
    
    var didSelectCallback: ((ListViewModelProtocol) -> Void)?
    
    var viewModel: ListViewModel? {
        didSet {
            initView(with: viewModel)
        }
    }
    
    private func initView(with viewModel: ListViewModel?) {
        
        if (viewModel?.showSeparator).boolValue {
            tableView.separatorStyle = .singleLine
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        
        viewModel?.sections.forEach { (section) in
            tableView.register(UINib(nibName: section.cell.cellIdentifier, bundle: Bundle.main),
                               forCellReuseIdentifier: section.cell.cellIdentifier)
        }
        
        tableView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView: scrollView)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offset = scrollView.contentOffset.y
//        let dd = (scrollView.contentSize.height - scrollView.frame.size.height) - 60
//        if dd > 0, offset >= dd {
//            delegate?.scrolledToEnd()
//        }
//    }
}

extension ListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = viewModel?.sections[indexPath.section] else {
            return 0
        }
        
        switch section.cellHeight {
        case .automaticDimension:
            return UITableView.automaticDimension
        case .custom(let height):
            return height
        case .equally:
            return tableView.frame.height / CGFloat(section.items.count)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (viewModel?.sections.count).intValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.sections[section].items.count).intValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        
        let section = viewModel.sections[indexPath.section]
        let item = section.items[indexPath.row]
        let cellIdentifier = viewModel.sections[indexPath.section].cell.cellIdentifier
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ListViewCellProtocol {
            cell.configure(with: item)
//            cell.backgroundColor = .black
            cell.selectionStyle = .none
            
            if !viewModel.showSeparator {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            }
            
            
            
            
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let item = viewModel?.sections[indexPath.section].items[indexPath.row] else {
            return
        }
 
        didSelectCallback?(item)
    }
}




