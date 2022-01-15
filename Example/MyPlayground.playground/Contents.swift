import Foundation

struct Address {
    var name: String
    var age: Int
    var phoneNumber: String
}

var endFlag: Bool = false
var addressList:[Address] = []
func dataPostProcessing(input: String) -> String{
    return input.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of:" ", with: "")
}

private func insertAddress(){
    print("연락처 정보를 입력해주세요 : ", terminator: " ")
    let rawInput = String(readLine() ?? "").components(separatedBy: "/")
    if rawInput.count == 1{
        print("아무것도 입력되지 않았습니다. 입력 형식을 확인해주세요.")
        return
    }
    var data = [String]()

    //공백제거
    for item in rawInput{
        let processingItem = dataPostProcessing(input: item)
        data.append(processingItem)
    }
    // input data validation func
    print(data)
    let newAddress = Address(name: data[0], age: Int(data[1])!, phoneNumber: data[2]) //validation 거친 값이므로 그냥 캐스팅
    addressList.append(newAddress)
}

private func showAllAddress(){
    addressList = addressList.sorted(by: {$0.name > $1.name})
    for address in addressList{
        print("- \(address.name) / \(address.age) / \(address.phoneNumber)")
    }
}
private func searchAddredd(){
    print("연락처에서 찾을 이름을 입력해주세요 : ", terminator: "")
    
    
}


while true{
    if endFlag{
        print("[프로그램 종료]")
        break
    }
    print("1) 연락처 추가 2) 연락처 목록보기 3) 연락처 검색 x) 종료")
    print("메뉴를 선택해주세요 :", terminator: " ")
    let menu = readLine()
    switch menu{
        case "1": // 연락처 추가
            insertAddress()
        case "2": // 연락처 목록보기
            //print("연락처 목록보기 구현")
            showAllAddress()
        case "3": // 연락처 검색
            searchAddredd()
        case "X", "x":
            endFlag = true
            
        default:
            print("선택이 잘못되었습니다 확인 후 다시 입력해주세요")
        
    }
    print("")
}
