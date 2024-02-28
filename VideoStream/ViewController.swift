//
//  ViewController.swift
//  VideoStream
//
//  Created by Ivan on 28/02/24.
//

import UIKit
import AVKit
import AVFoundation
class ImageCell : UICollectionViewCell{
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var playButton: UIButton!
}
class ViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate{
   
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    var timer = Timer()
    var counter = 0
    
    var imgArr = ["adam","madame","dakota","adam","madame","dakota"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = 0
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        DispatchQueue.main.async {
              self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        
        // Do any additional setup after loading the view.
    }
    @objc func changeImage() {
             
         if counter < imgArr.count {
              let index = IndexPath.init(item: counter, section: 0)
              self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              pageView.currentPage = counter
              counter += 1
         } else {
              counter = 0
              let index = IndexPath.init(item: counter, section: 0)
              self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
               pageView.currentPage = counter
               counter = 1
         }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.img.image = UIImage(named: imgArr[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!
          let player = AVPlayer(url: url)
          
          let vc = AVPlayerViewController()
          vc.player = player
         
          
        self.present(vc, animated: true) {
                    player.play()
            
        }
    }
    
  /*  private func setupView()
       {
           let pathClouds  = URL(fileURLWithPath: Bundle.main.path(forResource: "clouds", ofType: "mp4")!)

           player = AVPlayer(url: pathClouds)

           let newLayer = AVPlayerLayer(player: player)
           newLayer.frame = self.videoViewOutlet.frame
           self.videoViewOutlet.layer.addSublayer(newLayer)
           newLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill

           player.play()

           //loop it
           player.actionAtItemEnd = .none

           NotificationCenter.default.addObserver(self, selector: #selector(ViewController.videoDidPlayToEnd(notification:)),
                                                  name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)

           NotificationCenter.default.addObserver(self, selector: #selector(enteredBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(enteredForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
       }
    
    
    @objc func videoDidPlayToEnd(notification: Notification)
        {
            let player: AVPlayerItem = notification.object as! AVPlayerItem
            player.seek(to: .zero, completionHandler: nil)
        }

        @objc func enteredBackground() {
            player.pause()
        }

        @objc func enteredForeground() {
            player.play()
        }
   
   */
}
   
   

