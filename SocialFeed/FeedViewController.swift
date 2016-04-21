//
//  FeedViewController.swift
//  SocialFeed
//
//  Created by Matt Deuschle on 4/12/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var postTextField: CustomTextField!
    @IBOutlet var cameraImage: UIImageView!

    var imagePicker : UIImagePickerController!

    var posts = [Posts]()
    var imageSelected = false

    static var imageCache = NSCache()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        tableView.estimatedRowHeight = 414
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        DataService.ds.refPosts.observeEventType(.Value, withBlock:  { snapshot in
            print(snapshot.value)

            self.posts = []

            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {

                for snap in snapshots {

                    print("SNAP: \(snap)")

                    if let postDic = snap.value as? Dictionary<String,AnyObject> {

                        let key = snap.key
                        let post = Posts(postKey: key, dictionary: postDic)
                        self.posts.append(post)
                    }
                }

            }

            self.tableView.reloadData()
        })

    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return posts.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let post = posts[indexPath.row]

        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {

            cell.request?.cancel()

            var img: UIImage?

            if let url = post.imageUrl {

                img = FeedViewController.imageCache.objectForKey(url) as? UIImage
            }

            cell.configureCell(post, img: img)

            return cell
        } else {
            return PostCell()
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        let post = posts[indexPath.row]

        if post.imageUrl == nil {
            return 150
        } else {
            return tableView.estimatedRowHeight
        }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {

        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        cameraImage.image = image
        imageSelected = true

    }
    @IBAction func imagedSelectedTapped(sender: UITapGestureRecognizer) {

        presentViewController(imagePicker, animated: true, completion: nil)
    }
    @IBAction func postButtonTapped(sender: AnyObject) {

        if let txt = postTextField.text where txt != "" {

            if let img = cameraImage.image where imageSelected == true {

                let urlString = "https://post.imageshack.us/upload_api.php"
                let url = NSURL(string: urlString)!
                let imageData = UIImageJPEGRepresentation(img, 0.2)!
                let keyData = "12DJKPSU5fc3afbd01b1630cc718cae3043220f3".dataUsingEncoding(NSUTF8StringEncoding)!
                let keyJSON = "json".dataUsingEncoding(NSUTF8StringEncoding)!


                Alamofire.upload(.POST, url, multipartFormData: { multipartFormData in

                    multipartFormData.appendBodyPart(data: imageData, name: "fileupload", fileName: "image", mimeType: "image/jpg")
                    multipartFormData.appendBodyPart(data: keyData, name: "key")
                    multipartFormData.appendBodyPart(data: keyJSON, name: "format")

                    }) { encodingResult in

                        switch encodingResult {

                        case .Success(let upload, _, _):

                            upload.responseJSON(completionHandler: { response in

                                if let info = response.result.value as? Dictionary<String, AnyObject> {

                                    if let links = info["links"] as? Dictionary<String, AnyObject> {

                                        if let imgLink = links["image_link"] as? String {

                                            print("Link: \(imgLink)")
                                            self.postToFirebase(imgLink)
                                        }
                                    }
                                }
                            })

                        case .Failure(let error):
                            print(error)
                        }
                }
            } else {

                self.postToFirebase(nil)
            }
        }
    }

    func postToFirebase(imageURL: String?) {

        var post: Dictionary<String, AnyObject> = [
            "description": postTextField.text!,
            "likes": 0
        ]

        if imageURL != nil {

            post["imageUrl"] = imageURL!
        }

        let firebasePost = DataService.ds.refPosts.childByAutoId()
        firebasePost.setValue(post)

        postTextField.text = ""
        cameraImage.image = UIImage(named: "camera")
        imageSelected = false 

        tableView.reloadData()
    }
}











