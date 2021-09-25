//
//  FeedListVC.swift
//  Smoothie
//
//  Created by Ajay Yadav on 25/09/21.
//

import UIKit
import AVKit
import AVFoundation
import Kingfisher

class FeedListVC: UIViewController {
    
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgCountry: UILabel!

    var objFeedModel:FeedDataModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        lblDate.attributedText = CommonFunctions.sharedInstance.setAttributedText(textOne: "\(CommonFunctions.sharedInstance.getCurrentDate())\n", textTwo: "Today", colorOne: UIColor.darkGray, colorSecond: UIColor.black, fontOne: UIFont(name: "HelveticaNeue", size: 12.0)!, fontTwo: UIFont(name: "HelveticaNeue-Bold", size: 25.0)!)
        let indFlag = "".flag(country: "IN")
        
        imgCountry.text = indFlag
        initialSetup()
    }
    
    func initialSetup(){
        tblList.register(UINib(nibName: "WebUrlTblCell", bundle: .main), forCellReuseIdentifier: "WebUrlTblCell")
        tblList.register(UINib(nibName: "ImageTblCell", bundle: .main), forCellReuseIdentifier: "ImageTblCell")
        tblList.register(UINib(nibName: "VideoTblCell", bundle: .main), forCellReuseIdentifier: "VideoTblCell")

        tblList.delegate = self
        tblList.dataSource = self
        objFeedModel = FeedDataModel()
        updataFeedList()
        objFeedModel?.getFeedList(urlStr: APIConstant.feedList)
//        fetchRequest()        
        
    }

    @IBAction func btnFetchAction(_ sender: Any) {
        objFeedModel?.getFeedList(urlStr: APIConstant.feedList)
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        objFeedModel?.arrFeedList = []
        DispatchQueue.main.async {
            self.tblList.reloadData()
        }
    }

    func updataFeedList(){
        objFeedModel?.isDataLoaded = {(isViewLoaded) in
            DispatchQueue.main.async {
                self.tblList.reloadData()
            }
        }
    }
}


extension FeedListVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objFeedModel?.arrFeedList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let objEmployee = objFeedModel?.arrFeedList[indexPath.row]
        
        if objEmployee?.item_type == "url" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WebUrlTblCell", for: indexPath) as? WebUrlTblCell,objFeedModel?.arrFeedList.count ?? 0 > indexPath.row else{
                return UITableViewCell()
            }
            let objEmployee = objFeedModel?.arrFeedList[indexPath.row]
            cell.lblText.text = objEmployee?.item_type ?? ""
            cell.lblUrl.animate(newText: objEmployee?.data ?? "", characterDelay: 0.3)
            
            
            
            return cell
        }else if objEmployee?.item_type == "image" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTblCell", for: indexPath) as? ImageTblCell,objFeedModel?.arrFeedList.count ?? 0 > indexPath.row else{
                return UITableViewCell()
            }
            let objEmployee = objFeedModel?.arrFeedList[indexPath.row]
            cell.lblText.text = objEmployee?.item_type ?? ""
            let url = URL(string: objEmployee?.data ?? "")
            cell.imgView.kf.setImage(with: url)
            return cell
        }else if objEmployee?.item_type == "video"{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTblCell", for: indexPath) as? VideoTblCell,objFeedModel?.arrFeedList.count ?? 0 > indexPath.row else{
                return UITableViewCell()
            }
            
            let objEmployee = objFeedModel?.arrFeedList[indexPath.row]
            //let s = flag(country: objEmployee?.ISO2 ?? "")
            cell.lblText.text = objEmployee?.item_type
            let url = NSURL(string: objEmployee?.data ?? "");
            let avPlayer = AVPlayer(url: url! as URL)
            cell.vwPlayer.playerLayer.backgroundColor = UIColor.red.cgColor
            cell.vwPlayer.playerLayer.player = avPlayer
            cell.vwPlayer.player?.play()
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WebUrlTblCell", for: indexPath) as? WebUrlTblCell,objFeedModel?.arrFeedList.count ?? 0 > indexPath.row else{
            return UITableViewCell()
        }
        cell.lblText.text = objEmployee?.item_type ?? ""
        cell.lblUrl.text = "\(objEmployee?.data ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = (cell as? VideoTblCell) else { return };
        let visibleCells = tableView.visibleCells;
        let minIndex = visibleCells.startIndex;
        if tableView.visibleCells.index(of: cell) == minIndex {
            videoCell.vwPlayer.player?.play();
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = cell as? VideoTblCell else { return };
        
        videoCell.vwPlayer.player?.pause();
        videoCell.vwPlayer.player = nil;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return objFeedModel?.heightForRowAtIndexPath() ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objEmployee = objFeedModel?.arrFeedList[indexPath.row]
        if objEmployee?.item_type == "url" {
            let webVC = WebViewVC()
            webVC.urlString = objEmployee?.data
            self.present(webVC, animated: true) {
            }
        }
    }
}

class PlayerView: UIView {
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer;
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue;
        }
    }
}
