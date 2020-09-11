//
//  ViewController.swift
//  Stamp
//
//  Created by esaki yuki on 2020/09/10.
//  Copyright © 2020 esaki yuKki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //スタンプ画像の名前が入った配列
    var imageNameArray: [String] = ["hana", "hoshi", "onpu", "shitumon"]
    
    //選択しているスタンプ画像の番号
    var imageIndex: Int = 0
    
    @IBOutlet var haikeiImageView: UIImageView!
    
    //スタンプ画像が入るimageView
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectedFirst() {
        imageIndex = 1
    }
    
    @IBAction func selectedSecond() {
        imageIndex = 2
    }
    
    @IBAction func selectedThird() {
        imageIndex = 3
    }
    
    @IBAction func selectedFourth() {
        imageIndex = 4
    }
    
    @IBAction func back() {
        self.imageView.removeFromSuperview()
    }
    
    @IBAction func selectbackbraund() {
        //UIImagePickerControllerのインスタンス
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        //フォトライブラリをつくる設定
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        //フォトライブラリを呼び出す
        //self.presentは画面遷移するメソッド
        //今回はimagePickerController（フォトライブラリ）に画面遷移？
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func save() {
        //画面のスクリーンショットを取得
        let rect: CGRect = CGRect(x: 0,y: 0, width: 320, height: 380)
        UIGraphicsBeginImageContext(rect.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //フォトライブラリに保存
        UIImageWriteToSavedPhotosAlbum(capture!, nil, nil, nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //タッチされた位置を取得
        let touch: UITouch = touches.first!
        let location: CGPoint = touch.location(in: self.view)
        
        //imageIndexは選択しているスタンプの番号
        //imageIndexが0ではないってことは、スタンプが選ばれている状態のこと
        if imageIndex != 0 {
            //スタンプサイズを40pxの正方形サイズに
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            //押されたスタンプの画像を設定
            //imageIndexの番号は1から始まるけどimageNameArrayの配列の最初は0から始めるから[imageIndex - 1]ってするのかな？
            let image: UIImage = UIImage(named: imageNameArray[imageIndex - 1])!
            imageView.image = image
            //タッチされた位置に画像を置く
            //locationでタッチされた位置を取得している
            imageView.center = CGPoint(x: location.x, y: location.y)
            //画像を表示する
            self.view.addSubview(imageView)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //imageに選んだ画像を設定する
        //UIImage型に変換？
        let image = info[.originalImage] as? UIImage
        //imageを背景に設定
        haikeiImageView.image = image
        //フォトライブラリを閉じる
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}

