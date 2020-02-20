//
//  ViewController.swift
//  dragAndDrop
//
//  Created by Vijay Theja Marri on 2/19/20.
//  Copyright © 2020 Vijay Theja Marri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var numberArray = ["1","2","3","4","5","6","7","8","9","10"]
    var shuffle: [String] = []
    
    fileprivate var longPressGesture:UILongPressGestureRecognizer!
    
    @IBOutlet var topLabel: UILabel!
    
    
    @IBAction func Shuffle(_ sender: Any) {
        collectionView.reloadData()
       // numberArray.shuffled()
        shuffle = numberArray.shuffled()
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffle = numberArray.shuffled()

        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longHandleGesture(gesture:)))
        longPressGesture.minimumPressDuration = 0.1
        collectionView.addGestureRecognizer(longPressGesture)
        
    }
    
    @objc func longHandleGesture(gesture:UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case .began:
          guard  let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            case .changed:
                collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
        
    }
}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.cellLabel.text = shuffle[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var Wid:CGFloat = 100
        var hei:CGFloat = 100
        return CGSize(width: Wid, height: hei)
    }
    

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemCell = shuffle.remove(at: sourceIndexPath.item)
        shuffle.insert(itemCell, at: destinationIndexPath.item)
    }
    
    
    
}
