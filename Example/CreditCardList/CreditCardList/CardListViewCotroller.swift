import UIKit
import Kingfisher
import FirebaseDatabase
import FirebaseFirestoreSwift
import FirebaseFirestore

class CardListViewController: UITableViewController{
    var creditCardList: [CreditCard] = []
//    var ref: DatabaseReference!   // Firebase RealTime database code
    var db =  Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITableView Cell Register
        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        
//        ref = Database.database().reference() // Firebase Realtime Database code
//        ref.observe(.value){ snapshot in
//            guard let value = snapshot.value as? [String: [String:Any]] else {
//                return
//            }
//            do{
//                let jsonData = try JSONSerialization.data(withJSONObject: value)
//                let cardData = try JSONDecoder().decode([String: CreditCard].self, from : jsonData)
//                let cardList = Array(cardData.values)
//
//                self.creditCardList = cardList.sorted{
//                    $0.rank < $1.rank
//                }
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//
//            }catch let error {
//                print("ERROR JSON PARSING ERROR \(error.localizedDescription)")
//            }
//        }
        
        // Firestore to reading code
        db.collection("creditCardList").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else{
                print("ERROR Firestore fetching document")
                return
            }
            self.creditCardList = documents.compactMap{ doc -> CreditCard? in
                do {
                    let jsonData  = try JSONSerialization.data(withJSONObject: doc.data() , options: [])
                    let credicCard = try JSONDecoder().decode(CreditCard.self, from: jsonData)
                    return credicCard
                }catch let error {
                    print("ERROR compactMap \(error)")
                    return nil
                }
                
            }.sorted{
                $0.rank < $1.rank
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
       
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else { return UITableViewCell()}
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)???"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)???"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)???"
        
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImageView.kf.setImage(with: imageURL)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
//    override func tableView(_ tableView: UITableView, didselectRowAt indexPath: IndexPath) {
//        // ???????????? ???????????? ?????? ??????
//
//    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "CardDetailViewController") as? CardDetailViewController else { return }
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)
        
        //Realtime data base Writing code
//        option 1 >> Firebase Realtime database code
//        let cardId = creditCardList[indexPath.row].id
//        ref.child("Item\(cardId)/isSelected").setValue(true)
        
        //option2 >> ????????? ??????path??? ????????????( ??? ???????????? "Item0" ????????? ) ?????? ????????? ????????? ???????????? ??? ?????? ????????? ????????? ??? ??????.
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardId).observe(.value){ [weak self] snapshot in
//            guard let self = self,
//                  let value = snapshot.value as? [String: [String:Any]],
//                  let key = value.keys.first else { return }
//
//            self.ref.child("\(key)/isSelected").setValue(true)
//
//        }
        
        //FireStroe writing
        //1. ????????? ??? ??????
        let cardID = creditCardList[indexPath.row].id
//        db.collection("creditCardList").document("card\(cardID)").updateData(["isSelected": true])
        //2. ????????? ????????????
        db.collection("creditCardList").whereField("id", isEqualTo: cardID).getDocuments{
            snapshot, _ in
            guard let document = snapshot?.documents.first else {
                print("ERORR FIRESTORE MATCHING ERROR")
                return
            }
            document.reference.updateData(["isSelected": true])
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{ //?????? ????????? ????????? ????????? ????????? ?????? ????????? ??????
            //Option 1 >> Firebase Realtime data base code
//            let cardId = creditCardList[indexPath.row].id
//            ref.child("Item\(cardId)").removeValue()
            
//            //Option2
//            ref.queryOrdered(byChild: "id").queryEqual(toValue: cardId).observe(.value){[weak self] snapshot in
//                guard let self = self,
//                      let value = snapshot.value as? [String: [String:Any]],
//                      let key = value.keys.first else { return }
//
//                self.ref.child(key).removeValue()
//            }
            
            //Firebase Store ??????
            //1. ????????? ??? ???
            let cardID = creditCardList[indexPath.row].id
            //db.collection("creditCardList").document("card\(cardID)").delete()
            //2. ????????? ?????? ???
            db.collection("creditCardList").whereField("id", isEqualTo: cardID).getDocuments{
                snapshot, _ in
                guard let document = snapshot?.documents.first else {
                    print("ERROR DOCUMENT DELETING ")
                    return
                }
                document.reference.delete()
            }
        }
    }
}

