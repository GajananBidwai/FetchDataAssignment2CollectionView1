//
//  ViewController.swift
//  FetchDataAssignment2CollectionView1
//
//  Created by Mac on 23/12/23.
//

import UIKit
import Kingfisher
class ViewController: UIViewController {

    @IBOutlet weak var postCollectionView: UICollectionView!
    var post : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        initializeCollectionView()
        registerXIBWithCollectionView()
    }
    func fetchData()
    {
        let postUrl = URL(string: "https://jsonplaceholder.typicode.com/photos")
        var PostRequest = URLRequest(url: postUrl!)
        
        PostRequest.httpMethod = "Get"
        
        let postSession = URLSession(configuration: .default)
        
        let postDataTask = postSession.dataTask(with: PostRequest) { postData, postResponjse, postError in
            let postResponse = try! JSONSerialization.jsonObject(with: postData!)  as! [[String : Any]]
            
            for eachResponse in postResponse
            {
                let postDictionary = eachResponse as! [String : Any]
                
                let postAlbumId = postDictionary["albumId"] as! Int
                let postid = postDictionary["id"] as! Int
                let postTitle = postDictionary["title"] as! String
                let postUrlString = postDictionary["url"] as! String
                let postThumbnailId = postDictionary["thumbnailUrl"] as! String
                
                let postObject = Post(albumId: postAlbumId, id: postid, title: postTitle, urlString: postUrlString, thumbnailUrl: postThumbnailId)
                print(postData)
                print(postResponse)
                print(postThumbnailId)
                
                self.post.append(postObject)
                
                }
            
            DispatchQueue.main.async {
                self.postCollectionView.reloadData()
            }
            
        }
        postDataTask.resume()
    
        
        
    }
    func initializeCollectionView()
    {
        postCollectionView.dataSource = self
        postCollectionView.delegate = self
    }
    func registerXIBWithCollectionView()
    {
        let uinib = UINib(nibName: "PostCollectionViewCell", bundle: nil)
        postCollectionView.register(uinib, forCellWithReuseIdentifier: "PostCollectionViewCell")
    }

}
extension ViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        post.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCollectionViewCell = self.postCollectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        
        postCollectionViewCell.albumId.text = String(post[indexPath.item].albumId)
        postCollectionViewCell.id.text = String(post[indexPath.item].id)
        postCollectionViewCell.title.text = post[indexPath.item].title
        postCollectionViewCell.url.kf.setImage(with: URL(string: post[indexPath.item].urlString))
        postCollectionViewCell.thumbnailUrl.kf.setImage(with: URL(string: post[indexPath.item].thumbnailUrl))
        
        return postCollectionViewCell
    }
    
    
}
extension ViewController : UICollectionViewDelegate
{
    
}
extension ViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let spaceBetweenTheCell : CGFloat = (flowLayout.minimumInteritemSpacing ?? 0.0 ) + (flowLayout.sectionInset.left ?? 0.0 ) + (flowLayout.sectionInset.right ?? 0.0)
        
        let size = (postCollectionView.frame.width - spaceBetweenTheCell) / 2
        
        return CGSize(width: size, height: size)
    }
}
