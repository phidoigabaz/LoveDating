//
//  EventLoveViewController.swift
//  LoveDating
//
//  Created by Tạ Thành Đạt on 5/13/19.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

class EventLoveViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var draAndDropView: UIView = {
        let myView  = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.backgroundColor = .blue
        return myView
    }()
    var newCoord: CGPoint = CGPoint(x: 0, y: 0)
    var firstCoord: CGPoint = CGPoint(x: 0, y: 0)
    
    var viewModel: EventLoveViewModel!
    var results = CoreDataHelper.getData(entityName)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setViewModel()
        configCollectionView()
    }
    
    override func setupView() {
        view.addSubview(draAndDropView)
        view.addConstraint(NSLayoutConstraint(item: draAndDropView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100))
        view.addConstraint(NSLayoutConstraint(item: draAndDropView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100))
        view.addConstraint(NSLayoutConstraint(item: draAndDropView, attribute: .right , relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -20))
        view.addConstraint(NSLayoutConstraint(item: draAndDropView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -20))
        let panGestureToView = UILongPressGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        panGestureToView.minimumPressDuration = 0.0
        draAndDropView.addGestureRecognizer(panGestureToView)
    }
    
    func setViewModel() {
        viewModel?.results = results
    }
    
    func configCollectionView() {
        let nib = UINib(nibName: ItemCollectionViewCell.nibName(), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ItemCollectionViewCell.nibName())
        let layout = collectionView.collectionViewLayout as! SnakeUICollectionLayout
        layout.didReorderHandler = { [weak self] fromIndexPath, toIndexPath in
            //self?.moveItem(fromIndex: fromIndexPath.item, toIndex: toIndexPath.item)
        }
        collectionView.reloadData()
    }
    
    //MARK: METHODS
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        if (recognizer.view == nil) {
            return
        }
        
        if (recognizer.state == .began) {
            
        } else if(recognizer.state == .ended) {
            
        }
        
        self.newCoord = recognizer.location(in: self.view)
        let x = self.newCoord.x - (recognizer.view?.frame.width ?? 0) / 2
        let y = self.newCoord.y - (recognizer.view?.frame.height ?? 0) / 2
        draAndDropView.frame = CGRect(x: x, y: y, width: draAndDropView.frame.width, height: draAndDropView.frame.height)
        view.bringSubviewToFront(draAndDropView)
    }}

extension EventLoveViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getItemsCount() ?? 0 + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.nibName(),
                                                      for: indexPath) as! ItemCollectionViewCell
        cell.delegate = self
        return cell
    }
}

extension EventLoveViewController: ItemCollectionViewCellDelegate {
    func didSelectInsert(_ cell: ItemCollectionViewCell, sender: Any) {
        viewModel?.inserAndSaveItem("1", "title", "photo")
        //insertItemToCollection(index: self.viewModel?.getItemsCount() ?? 0 + 1)
    }
    
    func insertItemToCollection(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.performBatchUpdates({
            self.collectionView.insertItems(at: [indexPath])
        }, completion: {
            (finished: Bool) in
        })
    }
}
