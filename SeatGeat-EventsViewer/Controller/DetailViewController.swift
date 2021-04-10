//
//  DetailViewController.swift
//  SeatGeat-EventsViewer
//
//  Created by David Barsamian on 4/10/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var headlineImage: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    
    var event: SGEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let favoriteButton = navigationItem.rightBarButtonItem {
            favoriteButton.action = #selector(favoriteItem)
        }
        
        if let event = event {
            if let datetimeLocal = event.datetimeLocal, let tzString = event.venue?.timezone, let timezone = TimeZone(identifier: tzString) {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                formatter.timeZone = timezone
                if let date = formatter.date(from: datetimeLocal) {
                    formatter.dateStyle = .long
                    formatter.timeStyle = .long
                    let dateString = formatter.string(from: date)
                    dateLabel.text = dateString
                }
            }
            if let cityString = event.venue?.city, let stateString = event.venue?.state {
                locationLabel.text = "\(cityString) \(stateString)"
            }
            if let imgUrlString = event.performers?.first?.image {
                headlineImage.sd_setImage(with: URL(string: imgUrlString), completed: nil)
            }
            if let titleString = event.title {
                titleLabel.text = titleString
            }
        }
        
        
    }
    
    @objc func favoriteItem() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
