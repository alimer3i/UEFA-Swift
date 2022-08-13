//
//  HeaderTabViewController.swift
//  UEFAMatch
//
//  Created by Ali Merhie on 8/13/22.
//

import UIKit

class HeaderTabViewController: BaseViewController<HeaderTabVM> {

    //MARK: - Properties
    override class var pageStoryBoard: AppStoryboard {
        get { return .HeaderTabStoryBoard }
    }
    let maxHeaderHeight: CGFloat = 290
    let minHeaderHeight: CGFloat = 100
    var previousScrollOffset: CGFloat = 0
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: FitContentTableView!
    @IBOutlet weak var tabsHolderView: UIView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var playingTitleLabel: UILabel!
    @IBOutlet weak var playingDescriptionLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tabsStack: UIStackView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabButtons()
        setupTableView()
        scrollView.delegate = self
        playingTitleLabel.text = "Playing"
        viewModel.viewDidLoad()
    }

    override func bindToViewModel() {
        super.bindToViewModel()
        viewModel.$reloadTable
            .sink { [weak self] value in
                guard let strongSelf = self else {return}
                strongSelf.tableView.reloadData()
            }.store(in: &cancellables)
        
        viewModel.$teamName
            .sink { [weak self] name in
                guard let strongSelf = self else {return}
                strongSelf.teamNameLabel.text = name
            }.store(in: &cancellables)
        
        viewModel.$matchName
            .sink { [weak self] name in
                guard let strongSelf = self else {return}
                strongSelf.playingDescriptionLabel.text = name
            }.store(in: &cancellables)
        
        viewModel.$selectedPageType
            .sink { [weak self] selectedType in
                guard let strongSelf = self else {return}
                strongSelf.tabsHolderView.backgroundColor = selectedType.tabBackgroundColor()
                strongSelf.backgroundImageView.image = selectedType.backgroundImage()
            }.store(in: &cancellables)
        
        viewModel.$selectedTab
            .sink { [weak self] selectedTab in
                guard let strongSelf = self else {return}
                strongSelf.tabsStack.arrangedSubviews.forEach { currentTab in
                    if currentTab is UIButton {
                        if let currentButton = currentTab as? UIButton{
                            currentButton.isSelected = (currentButton.tag == selectedTab.rawValue)
                            
                        }
                    }
                }            }.store(in: &cancellables)

    }

    func setUpTabButtons(){
        tabsStack.arrangedSubviews.forEach { currentTab in
            if currentTab is UIButton {
                if let currentButton = currentTab as? UIButton{
                    currentButton.setTitle(HomeTabsEnum(rawValue: currentTab.tag)?.gertitle(), for: .normal)
                    currentButton.setTitleColor(viewModel.selectedPageType.selectedTabColor(), for: .selected)
                    currentButton.setTitleColor(.white, for: .normal)

                }
            }
        }
        viewModel.selectedTab = .squad
    }
   func updateSelectedTab(){

    }
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tabButtonClicked(_ sender: UIButton) {
        viewModel.selectedTab = HomeTabsEnum(rawValue: sender.tag) ?? .squad
    }
}


extension HeaderTabViewController: UIScrollViewDelegate {
    func canAnimateHeader (_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + self.headerViewHeight.constant - minHeaderHeight
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    func setScrollPosition() {
        self.scrollView.contentOffset = CGPoint(x:0, y: 0)
    }
}
extension HeaderTabViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = (scrollView.contentOffset.y - previousScrollOffset)
        let isScrollingDown = scrollDiff > 0
        let isScrollingUp = scrollDiff < 0
        if canAnimateHeader(scrollView) {
            var newHeight = headerViewHeight.constant
            if isScrollingDown {
                newHeight = max(minHeaderHeight, headerViewHeight.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(maxHeaderHeight, headerViewHeight.constant + abs(scrollDiff))
            }
            if newHeight != headerViewHeight.constant {
                headerViewHeight.constant = newHeight
                setScrollPosition()
                previousScrollOffset = scrollView.contentOffset.y
            }
        }
    }
}

extension HeaderTabViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {

        tableView.dataSource = self
        self.view.backgroundColor = viewModel.selectedPageType.selectedTableColor()
        UITableViewHeaderFooterView.appearance().tintColor = viewModel.selectedPageType.selectedCellColor()

        tableView.backgroundColor = viewModel.selectedPageType.selectedTableColor()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell")
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle(at: section)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberofItems(at: section)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell") as! PlayerTableViewCell
        cell.holderView.backgroundColor = viewModel.selectedPageType.selectedCellColor()
        self.viewModel.configure(cell: cell, at: indexPath)
        return cell
    }
}
