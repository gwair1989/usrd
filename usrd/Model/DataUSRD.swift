

import Foundation

// MARK: - DataUSRD
struct DataUSRD: Codable {
    let data: [Datum]
    let count: Int
}

// MARK: - Datum
struct Datum: Codable {
    let corruptionAffected: Int
    let data: DatumData
    let declarationType, declarationYear: Int
    let id: String
    let options: Options
    let postCategory, postType, responsiblePosition, schemaVersion: Int
    let type, userDeclarantID: Int
    let date: String

    enum CodingKeys: String, CodingKey {
        case corruptionAffected = "corruption_affected"
        case data
        case declarationType = "declaration_type"
        case declarationYear = "declaration_year"
        case id, options
        case postCategory = "post_category"
        case postType = "post_type"
        case responsiblePosition = "responsible_position"
        case schemaVersion = "schema_version"
        case type
        case userDeclarantID = "user_declarant_id"
        case date
    }
}

// MARK: - DatumData
struct DatumData: Codable {
    let step1: Step1
    let step0: Step0

    enum CodingKeys: String, CodingKey {
        case step1 = "step_1"
        case step0 = "step_0"
    }
}

// MARK: - Step0
struct Step0: Codable {
    let data: Step0_Data
}

// MARK: - Step0_Data
struct Step0_Data: Codable {
    let declarationType, declarationPeriod: String
    let declarationYear: Int

    enum CodingKeys: String, CodingKey {
        case declarationType = "declaration_type"
        case declarationPeriod = "declaration_period"
        case declarationYear = "declaration_year"
    }
}

// MARK: - Step1
struct Step1: Codable {
    let data: Step1_Data
}

// MARK: - Step1_Data
struct Step1_Data: Codable {
    let birthday, cityType, workPost, country: String
    let postCategory, firstname, corruptionAffected, changedName: String
    let passport: String?
    let responsiblePosition, street, sameRegLivingAddress, workPlace: String
    let streetType, postType: String
    let unzr: String?
    let taxNumber, middlename: String
    let publicPerson: String?
    let lastname, housePartNumExtendedstatus, cityPath, postCode: String
    let apartmentsNum, region: String
    let unzrExtendedstatus: String?
    let housePartNum, houseNum: String
    let actualCityPath, actualCityType: String?

    enum CodingKeys: String, CodingKey {
        case birthday, cityType, workPost, country, postCategory, firstname, corruptionAffected, changedName, passport, responsiblePosition, street, sameRegLivingAddress, workPlace, streetType, postType, unzr, taxNumber, middlename
        case publicPerson = "public_person"
        case lastname
        case housePartNumExtendedstatus = "housePartNum_extendedstatus"
        case cityPath, postCode, apartmentsNum, region
        case unzrExtendedstatus = "unzr_extendedstatus"
        case housePartNum, houseNum
        case actualCityPath = "actual_cityPath"
        case actualCityType = "actual_cityType"
    }
}

// MARK: - Options
struct Options: Codable {
    let hasChangedVersion, basedOnFullCheck: Int

    enum CodingKeys: String, CodingKey {
        case hasChangedVersion = "has_changed_version"
        case basedOnFullCheck = "based_on_full_check"
    }
}
