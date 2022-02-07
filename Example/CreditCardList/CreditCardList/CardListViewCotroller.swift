import UIKit
import Kingfisher
import FirebaseDatabase


class CardListViewController: UITableViewController{
    var creditCardList: [CreditCard] = []
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITableView Cell Register
        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        
        ref = Database.database().reference()
        ref.observe(.value){ snapshot in
            guard let value = snapshot.value as? [String: [String:Any]] else {
                return
            }
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let cardData = try JSONDecoder().decode([String: CreditCard].self, from : jsonData)
                let cardList = Array(cardData.values)
                
                self.creditCardList = cardList.sorted{
                    $0.rank < $1.rank
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }catch let error {
                print("ERROR JSON PARSING ERROR \(error.localizedDescription)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else { return UITableViewCell()}
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)위"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)위"
        
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImageView.kf.setImage(with: imageURL)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
//    override func tableView(_ tableView: UITableView, didselectRowAt indexPath: IndexPath) {
//        // 눌럿을때 상세화면 뷰로 이동
//
//    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "CardDetailViewController") as? CardDetailViewController else { return }
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)
        
//        option 1
        let cardId = creditCardList[indexPath.row].id
        ref.child("Item\(cardId)/isSelected").setValue(true)
        
        //option2 >> 우리가 특정path를 모를경우( 이 경우에는 "Item0" 같은거 ) 내부 아이디 값으로 검색해서 그 객체 자체를 받아올 수 있다.
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardId).observe(.value){ [weak self] snapshot in
//            guard let self = self,
//                  let value = snapshot.value as? [String: [String:Any]],
//                  let key = value.keys.first else { return }
//
//            self.ref.child("\(key)/isSelected").setValue(true)
//
//        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{ //많은 에디팅 스타일 중에서 삭제할 경우 동작을 지정
            //Option 1
            let cardId = creditCardList[indexPath.row].id
            ref.child("Item\(cardId)").removeValue()
            
//            //Option2
//            ref.queryOrdered(byChild: "id").queryEqual(toValue: cardId).observe(.value){[weak self] snapshot in
//                guard let self = self,
//                      let value = snapshot.value as? [String: [String:Any]],
//                      let key = value.keys.first else { return }
//
//                self.ref.child(key).removeValue()
//            }
        }
    }
}

