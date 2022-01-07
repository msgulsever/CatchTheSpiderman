//
//  ViewController.swift
//  HeroBook
//
//  Created by user209356 on 1/6/22.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    


    @IBOutlet weak var highscoreLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    var score = 0
    var highscore = 0
    var gerisayim = 0
    var zamanlayici = Timer()
    var gzamanlayici = Timer()
    var spiderArray = ["0","1","2","3","4","5","6","7","8"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scoreLbl.text = "Score: \(score)"
        
        //hs check
        
    
        
        let storedHS = UserDefaults.standard.object(forKey: "hs")
        
        if storedHS == nil {
            highscore = 0
            highscoreLbl.text = "Highscore: \(highscore)"
        }
        
        if let newScore = storedHS as? Int   {
            highscore = newScore
            highscoreLbl.text = "Highscore: \(highscore)"
            
        }
    
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        collectionView.collectionViewLayout = layout
    
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource  = self
        
        gerisayim = 10
        timeLbl.text = String(gerisayim)
         print("viewedidload çalıştı")
        //collectionView.
        zamanlayici = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(geriSayimci), userInfo: nil, repeats: true)
        //gzamanlayici = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideimage), userInfo: nil, repeats: true)
    }
    
   
    @objc func geriSayimci(){
        
        gerisayim -= 1
        timeLbl.text = String(gerisayim)
        
        if gerisayim == 0 {
            zamanlayici.invalidate()
            
            if self.score > self.highscore {
                self.highscore = self.score
                highscoreLbl.text = "Highscore: \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "hs")
            }
            
            
            let alert = UIAlertController(title: "time's Up", message: "Do You Want to Play Again?", preferredStyle: UIAlertController.Style.alert)
            let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replaybutton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] (UIAlertAction) in
                
                //replay function
                self.score = 0
                self.scoreLbl.text = "Score: \(self.score)"
                self.gerisayim = 10
                self.timeLbl.text = String(self.gerisayim)
                
                self.zamanlayici = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.geriSayimci), userInfo: nil, repeats: true)            }
            alert.addAction(okbutton)
            alert.addAction(replaybutton)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        score += 1
        scoreLbl.text = "Score: \(score)"
        //print("you tapped me \(indexPath.row)")
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        
        //cell.contentView.isHidden = true
        
        for i in indexPath{
            cell.contentView.isHidden = true
            
        }

                
        let random = Int(arc4random_uniform(UInt32(indexPath.count - 1)))
        cell.contentView.viewWithTag(random)?.isHidden = false
        
        
        cell.configure(with: UIImage(named: "spider")!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    


}

