//
//  ViewController.swift
//  ParallaxView
//
//  Created by Mukesh on 24/10/18.
//  Copyright © 2018 BooEat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDefaultParallax()
    }
    
    private func addDefaultParallax() {
        ParallaxView.add(to: tableView, image: UIImage(named: "sampleImage")!, title: "ParallaxView")
    }
    
    private func addCustomViewParallax() {
        let parallexView = UINib(nibName: "ParallaxContainerView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! ParallaxContainerView
        
        parallexView.imageView.image = UIImage(named: "sampleImage")
        parallexView.titleLabel.text = "ParallaxView"
        
        ParallaxView.add(to: tableView, view: parallexView, bottomStreachingView: parallexView.imageView)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Sample Data \(indexPath.row+1)"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sample Header \(section+1)"
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        (tableView.tableHeaderView as? ParallaxView)?.scrollViewDidScroll(scrollView)
    }
}
