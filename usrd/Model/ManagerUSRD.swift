//
//  ManagerUSRD.swift
//  usrd
//
//  Created by Aleksandr Khalupa on 11.08.2021.
//

import Foundation
protocol ManagerUSRDDelegate {
    func getUSRDData(data:[ModelUSRD])
    func getError(serverError:String)
}

class ManagerUSRD{
    
    let urlApi = "https://public-api.nazk.gov.ua/v2/documents/"
    var delegate: ManagerUSRDDelegate?
    
    
    func requestUSRD(lastname: String){
        let urlString = "\(urlApi)list?query=\(lastname)"
        fetchUSRD(urlString: urlString)
    }
    
    func fetchUSRD(urlString:String){
        print(urlString)
        
        guard let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                    fatalError("[getRequest.addingPercentEncoding] bad url: \(urlString)")
                }
        
        
        guard let apiURL = URL(string: encoded) else {return}
        print(apiURL)
        
        let urlSesion = URLSession(configuration: .default)
        let dataTask = urlSesion.dataTask(with: apiURL) { (data, urlResponse, error) in
            if error != nil {return}
            guard let receivedData = data else {return}
            guard let modelUSRD = self.hendlingJson(recData: receivedData) else{return}
            DispatchQueue.main.async {
                self.delegate?.getUSRDData(data: modelUSRD)
            }
        }
        dataTask.resume()
    }
    
    func hendlingJson(recData: Data) -> [ModelUSRD]?{
        var modelUSRDArray:[ModelUSRD] = []
        let decoder = JSONDecoder()
        do {
           let decodeData = try decoder.decode(DataUSRD.self, from: recData)
            
            for item in decodeData.data.indices{
                let modelUSRD = ModelUSRD(lastName: decodeData.data[item].data.step_1.data.lastname, firstName: decodeData.data[item].data.step_1.data.firstname, middleName: decodeData.data[item].data.step_1.data.middlename, workPlace: decodeData.data[item].data.step_1.data.workPlace, workPost: decodeData.data[item].data.step_1.data.workPost, declarationPeriod: decodeData.data[item].data.step_0.data.declaration_period, count: decodeData.count, id: decodeData.data[item].id)
                modelUSRDArray.append(modelUSRD)
            }
            return modelUSRDArray
        } catch  {
            DispatchQueue.main.async {
                self.delegate?.getError(serverError: error.localizedDescription)
            }
            return nil
        }
    }

    
}
