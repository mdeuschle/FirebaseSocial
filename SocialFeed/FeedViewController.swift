//
//  FeedViewController.swift
//  SocialFeed
//
//  Created by Matt Deuschle on 4/12/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        DataService.ds.refPosts.observeEventType(.Value, withBlock:  { snapshot in
            print(snapshot.value)
        })

    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 5
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        return tableView.dequeueReusableCellWithIdentifier("CellID") as! PostCell
    }



}
