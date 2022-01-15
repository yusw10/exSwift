import Foundation

struct Address {
    var name: String
    var age: Int
    var phoneNumber: String
    
    func printing(){
        print("InputData:  \(self.age)세 \(self.name)(\(self.phoneNumber))")
    }
}
enum DataType{
    case name
    case age
    case phoneNumber
}

var endFlag: Bool = false
var validateErrorFlag = false
var addressList:[Address] = []
func dataPostProcessing(input: String) -> String{
    return input.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of:" ", with: "")
}

private func validate(input: String, type: DataType) -> Bool{
    let patterns = ["[가-힣]{2,4}","[1-9]{1}+[0-9]{0,2}", "^0([1-9]{1}[0-9]{0,1})-([0-9]{3,4})-([0,9]{4})"]
    switch type{
    case .name:
        let Test = NSPredicate(format:"SELF MATCHES %@", patterns[0])
        return Test.evaluate(with: input)
    case .age:
        let Test = NSPredicate(format:"SELF MATCHES %@", patterns[1])
        return Test.evaluate(with: input)
    case .phoneNumber:
        let Test = NSPredicate(format:"SELF MATCHES %@", patterns[2])
        return Test.evaluate(with: input)
    default:
        return false
    }
    
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
    for (index,item) in rawInput.enumerated(){
        let processingItem = dataPostProcessing(input: item)
        switch index{
        case 0:
            if !validate(input: processingItem, type: .name){
                print("Error Data : \(processingItem)")
                print("입력한 이름정보가 잘못되었습니다. 표시형식을 확인해 주세요.")
                validateErrorFlag = true
                return
            }
        case 1:
            if !validate(input: processingItem, type: .age){
                print("Error Data : \(processingItem)")
                print("입력한 나이정보가 잘못되었습니다. 표시형식을 확인해 주세요.")
                validateErrorFlag = true
                return
            }
            
        case 2:
            if !validate(input: processingItem, type: .phoneNumber){
                print("Error Data : \(processingItem)")
                print("입력한 휴대폰 정보가 잘못되었습니다. 표시형식을 확인해 주세요.")
                validateErrorFlag = true
                return
            }
            
        default:
            break
        }
        data.append(processingItem)
    }
    
    // input data validation func
    let newAddress = Address(name: data[0], age: Int(data[1])!, phoneNumber: data[2]) //validation 거친 값이므로 그냥 캐스팅
    print("입력한 정보는 \(newAddress.age)세 \(newAddress.name)(\(newAddress.phoneNumber))입니다.")
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
    var searchFlag = false
    let inputName = dataPostProcessing(input:  readLine()!)
    for address in addressList{
        if address.name.elementsEqual(inputName){
            print("- \(address.name) / \(address.age) / \(address.phoneNumber)")
            if !searchFlag{
                searchFlag = !searchFlag
            }
        }
    }
    
    if !searchFlag {
        print("연락처에 \(inputName)이 없습니다.")
    }
}


while true{
    if endFlag {
        print("[프로그램 종료]")
        break
    }else if validateErrorFlag{
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
