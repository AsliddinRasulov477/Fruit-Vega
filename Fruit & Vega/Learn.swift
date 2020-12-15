//
//  LearnViewController.swift
//  Quize Fruit&Vegetables
//
//  Created by Asliddin Rasulov on 1/17/20.
//  Copyright © 2020 Asliddin. All rights reserved.
//

import UIKit
import AVFoundation

let imagesArray = ["APPLE", "ORANGE", "BANANA", "PINEAPPLE", "PEAR", "STRAWBERRY", "CHERRIES", "POMEGRANATE", "GRAPES", "KIWI", "LEMON", "MELON", "PEACH", "PLUM", "WATERMELON", "BRINJAL", "BROCCOLI", "CABBAGE", "CARROT", "CHILLI", "BEET", "CHIVE", "CORIANDER", "CORN", "CUCUMBER", "GARLIC", "LEEK", "MUSHROOM", "POTATO", "PUMPKIN", "RADISH", "TOMATO", "BELL PEPPERS", "PEA"]
let fruits = ["APPLE", "ORANGE", "BANANA", "PINEAPPLE", "PEAR", "STRAWBERRY", "CHERRIES", "POMEGRANATE", "GRAPES", "KIWI", "LEMON", "MELON", "PEACH", "PLUM", "WATERMELON"]
let vegetables = ["BRINJAL", "BROCCOLI", "CABBAGE", "CARROT", "CHILLI", "BEET", "CHIVE", "CORIANDER", "CORN", "CUCUMBER", "GARLIC", "LEEK", "MUSHROOM", "POTATO", "PUMPKIN", "RADISH", "TOMATO", "BELL PEPPERS", "PEA"]

class Learn: UIViewController  {    
    
    @IBOutlet weak var backward: UIButton!
    @IBOutlet weak var forward: UIButton!
    @IBOutlet weak var collectionView : UICollectionView!
    
    let showAlert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
    let speechSynthesizer = AVSpeechSynthesizer()
    var ward = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer.stop()
        let speechUtterance = AVSpeechUtterance(string: imagesArray[ward])
        DispatchQueue.main.async {
            self.speechSynthesizer.speak(speechUtterance)
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        playSoundWith(fileName: "Back", fileExtinsion: "wav")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func forward(_ sender: UIButton) {
        playSoundWith(fileName: "Back", fileExtinsion: "wav")
        ward = Int(collectionView.contentOffset.x / view.frame.width)
        if ward == imagesArray.count - 1 {
            ward = -1
        }
        let speechUtterance = AVSpeechUtterance(string: imagesArray[ward + 1])
        DispatchQueue.main.async {
            self.speechSynthesizer.speak(speechUtterance)
        }
        collectionView.scrollToItem(at: IndexPath(row: ward + 1, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func backward(_ sender: UIButton) {
        playSoundWith(fileName: "Back", fileExtinsion: "wav")
        ward = Int(collectionView.contentOffset.x / view.frame.width)
        if ward == 0 {
            ward = imagesArray.count
        }
        let speechUtterance = AVSpeechUtterance(string: imagesArray[ward - 1])
        DispatchQueue.main.async {
            self.speechSynthesizer.speak(speechUtterance)
        }
        collectionView.scrollToItem(at: IndexPath(row: ward - 1, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension Learn: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "learnCell", for: indexPath) as! LearnCell
        cell.imageView.image = UIImage(named: imagesArray[indexPath.row].lowercased())
        cell.nameLabel.text = imagesArray[indexPath.row]
        return cell
    }
    
}
