//
//  ModelUSRD.swift
//  usrd
//
//  Created by Aleksandr Khalupa on 11.08.2021.
//

import Foundation

struct ModelUSRD {
    let count: Int
    
    let corruptionAffected: Int
    let declarationType, declarationYear: Int
    let id: String
    let postCategory, postType, responsiblePosition, schemaVersion: Int
    let type, userDeclarantID: Int
    let date: String
    
    let declarationTypeString, declarationPeriodString: String
    let declarationYearInt: Int
    
    let birthday, cityType, workPost, country: String
    let postCategoryString, firstnameString, corruptionAffectedString, changedName: String
    let passport: String?
    let responsiblePositionString, street, sameRegLivingAddress, workPlace: String
    let streetType, postTypeString: String
    let unzr: String?
    let taxNumber, middlename: String
    let publicPerson: String?
    let lastname, housePartNumExtendedstatus, cityPath, postCode: String
    let apartmentsNum, region: String
    let unzrExtendedstatus: String?
    let housePartNum, houseNum: String
    let actualCityPath, actualCityType: String?
    
    let hasChangedVersion, basedOnFullCheck: Int
}
