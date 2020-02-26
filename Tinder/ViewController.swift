//
//  ViewController.swift
//  Tinder
//
//  Created by 丹下敦矢 on 2020/02/25.
//  Copyright © 2020 丹下敦矢. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var basicCard: UIView!
    @IBOutlet weak var likeImageView: UIImageView!
    var centerOfCard:CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerOfCard = basicCard.center
    }
    
    
    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
        // 角度を変える
        let xFromCenter = card.center.x - view.center.x
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
        
        if xFromCenter > 0 {
            likeImageView.image = UIImage(named: "good")
            likeImageView.alpha = 1
            likeImageView.tintColor = UIColor.red
        } else if xFromCenter < 0 {
            likeImageView.image = UIImage(named: "bad")
            likeImageView.alpha = 1
            likeImageView.tintColor = UIColor.blue
        }
        
        if sender.state == UIGestureRecognizer.State.ended {
            // 左に大きくスワイプ
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = CGPoint(x: card.center.x - 250, y:card.center.y)
                })
                return
            } else if card.center.x > self.view.frame.width - 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = CGPoint(x: card.center.x + 250, y:card.center.y)
                })
                return
            }
            
            // もとに戻す処理
            UIView.animate(withDuration: 0.2, animations: {
                card.center = self.centerOfCard
                card.transform = .identity
            })
        }
        
    }
    

}

