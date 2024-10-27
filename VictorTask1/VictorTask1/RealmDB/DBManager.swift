//
//  DBManager.swift
//  VictorTask1
//
//  Created by Mironchik on 27.10.24.
//

extension DBManager {
    func getAllSurveyModel() -> [SurveyModel] {
        SurveyModel.getAll()
    }

    class func saveAllSurveyModel(models: [SurveyModel]) {
        SurveyModel.saveAll(models: models)
    }
}
