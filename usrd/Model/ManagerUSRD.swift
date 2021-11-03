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
    let urlPublicNazk = "https://public.nazk.gov.ua/documents/"
    let urlApi = "https://public-api.nazk.gov.ua/v2/documents/"
    var delegate: ManagerUSRDDelegate?
    
    
    func requestUSRD(lastname: String) {
        let urlString = "\(urlApi)list?query=\(lastname)"
        
        guard let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                    fatalError("[getRequest.addingPercentEncoding] bad url: \(urlString)")
                }
        fetchUSRD(urlString: encoded)
    }
    
    func requestUSRD(id: String) -> URLRequest?{
        let urlString = "\(urlPublicNazk)\(id)"
        if let apiURL = URL(string: urlString) {
            return URLRequest(url: apiURL)
        }
        return nil
    }
    
    func fetchUSRD(urlString:String) {
        guard let apiURL = URL(string: urlString) else { return }
        
        let urlSesion = URLSession(configuration: .default)
        let dataTask = urlSesion.dataTask(with: apiURL) { (data, urlResponse, error) in
            if error != nil { return }
            guard let receivedData = data else { return }
            guard let modelUSRD = self.hendlingJson(recData: receivedData) else { return }
            DispatchQueue.main.async {
                self.delegate?.getUSRDData(data: modelUSRD)
            }
        }
        dataTask.resume()
    }
    
    func hendlingJson(recData: Data) -> [ModelUSRD]? {
        var modelUSRDArray:[ModelUSRD] = []
        let decoder = JSONDecoder()
        do {
           let decodeData = try decoder.decode(DataUSRD.self, from: recData)
            for item in decodeData.data.indices{
                let modelUSRD = ModelUSRD(
                    count: decodeData.count,
                    corruptionAffected: decodeData.data[item].corruptionAffected,
                    declarationType: decodeData.data[item].declarationType,
                    declarationYear: decodeData.data[item].declarationYear,
                    id: decodeData.data[item].id,
                    postCategory: decodeData.data[item].postCategory,
                    postType: decodeData.data[item].postType,
                    responsiblePosition: decodeData.data[item].responsiblePosition,
                    schemaVersion: decodeData.data[item].schemaVersion,
                    type: decodeData.data[item].type,
                    userDeclarantID: decodeData.data[item].userDeclarantID,
                    date: decodeData.data[item].date,
                    declarationTypeString: decodeData.data[item].data.step0.data.declarationType,
                    declarationPeriodString: decodeData.data[item].data.step0.data.declarationPeriod,
                    declarationYearInt: decodeData.data[item].data.step0.data.declarationYear,
                    birthday: decodeData.data[item].data.step1.data.birthday,
                    cityType: decodeData.data[item].data.step1.data.cityType,
                    workPost: decodeData.data[item].data.step1.data.workPost,
                    country: decodeData.data[item].data.step1.data.country,
                    postCategoryString: decodeData.data[item].data.step1.data.postCategory,
                    firstnameString: decodeData.data[item].data.step1.data.firstname,
                    corruptionAffectedString: decodeData.data[item].data.step1.data.corruptionAffected,
                    changedName: decodeData.data[item].data.step1.data.changedName,
                    passport: decodeData.data[item].data.step1.data.passport,
                    responsiblePositionString: decodeData.data[item].data.step1.data.responsiblePosition,
                    street: decodeData.data[item].data.step1.data.street,
                    sameRegLivingAddress: decodeData.data[item].data.step1.data.sameRegLivingAddress,
                    workPlace: decodeData.data[item].data.step1.data.workPlace,
                    streetType: decodeData.data[item].data.step1.data.streetType,
                    postTypeString: decodeData.data[item].data.step1.data.postType,
                    unzr: decodeData.data[item].data.step1.data.unzr,
                    taxNumber: decodeData.data[item].data.step1.data.taxNumber,
                    middlename: decodeData.data[item].data.step1.data.middlename,
                    publicPerson: decodeData.data[item].data.step1.data.publicPerson,
                    lastname: decodeData.data[item].data.step1.data.lastname,
                    housePartNumExtendedstatus: decodeData.data[item].data.step1.data.housePartNumExtendedstatus,
                    cityPath: decodeData.data[item].data.step1.data.cityPath,
                    postCode: decodeData.data[item].data.step1.data.postCode,
                    apartmentsNum: decodeData.data[item].data.step1.data.apartmentsNum,
                    region: decodeData.data[item].data.step1.data.region,
                    unzrExtendedstatus: decodeData.data[item].data.step1.data.unzrExtendedstatus,
                    housePartNum: decodeData.data[item].data.step1.data.housePartNum,
                    houseNum: decodeData.data[item].data.step1.data.houseNum,
                    actualCityPath: decodeData.data[item].data.step1.data.actualCityPath,
                    actualCityType: decodeData.data[item].data.step1.data.actualCityType,
                    hasChangedVersion: decodeData.data[item].options.hasChangedVersion,
                    basedOnFullCheck: decodeData.data[item].options.basedOnFullCheck)
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
