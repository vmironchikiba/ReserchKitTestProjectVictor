//
//  ResultTableViewProviders.swift
//  VictorTask1
//
//  Created by Mironchik on 26.10.24.
//

import UIKit
import ResearchKit
import MapKit
import Speech

protocol ResultProviderDelegate {
    func presentShareSheet(shareSheet: UIActivityViewController)
}


func resultTableViewProviderForResult(_ result: ORKResult?, delegate: ResultProviderDelegate?) -> UITableViewDataSource & UITableViewDelegate {
    guard let result = result else {
        return NoRecentResultTableViewProvider()
    }

    
    let providerType: ResultTableViewProvider.Type
    


    switch result {
    
    case is ORKBooleanQuestionResult:
        providerType = BooleanQuestionResultTableViewProvider.self
        
    case is ORKChoiceQuestionResult:
        providerType = ChoiceQuestionResultTableViewProvider.self
        
    case is ORKDateQuestionResult:
        providerType = DateQuestionResultTableViewProvider.self
        
    case is ORKLocationQuestionResult:
        providerType = LocationQuestionResultTableViewProvider.self
        
    case is ORKNumericQuestionResult:
        providerType = NumericQuestionResultTableViewProvider.self
        
    case is ORKScaleQuestionResult:
        providerType = ScaleQuestionResultTableViewProvider.self
        
    case is ORKSESQuestionResult:
        providerType = SESQuestionResultTableViewProvider.self
        
    case is ORKTextQuestionResult:
        providerType = TextQuestionResultTableViewProvider.self
        
    case is ORKTimeIntervalQuestionResult:
        providerType = TimeIntervalQuestionResultTableViewProvider.self
        
    case is ORKTimeOfDayQuestionResult:
        providerType = TimeOfDayQuestionResultTableViewProvider.self

    
    case is ORKConsentSignatureResult:
        providerType = ConsentSignatureResultTableViewProvider.self
        
    
    case is ORKAmslerGridResult:
        providerType = AmslerGridResultTableViewProvider.self
        
    case is ORKPasscodeResult:
        providerType = PasscodeResultTableViewProvider.self
        
    case is ORKFileResult:
        providerType = FileResultTableViewProvider.self
        
    case is ORKSpatialSpanMemoryResult:
        providerType = SpatialSpanMemoryResultTableViewProvider.self
        
    case is ORKSpeechRecognitionResult:
        providerType = SpeechRecognitionResultTableViewProvider.self
        
    case is ORKStroopResult:
        providerType = StroopResultTableViewProvider.self
        
    case is ORKSwiftStroopResult:
        providerType = SwiftStroopResultTableViewProvider.self
        
    case is ORKTappingIntervalResult:
        providerType = TappingIntervalResultTableViewProvider.self
    
    case is ORKToneAudiometryResult:
        providerType = ToneAudiometryResultTableViewProvider.self
        
    case is ORKReactionTimeResult:
        providerType = ReactionTimeViewProvider.self
        
    case is ORKRangeOfMotionResult:
        providerType = RangeOfMotionResultTableViewProvider.self

    case is ORKTowerOfHanoiResult:
        providerType = TowerOfHanoiResultTableViewProvider.self
        
    case is ORKPSATResult:
        providerType = PSATResultTableViewProvider.self
        
    case is ORKTimedWalkResult:
        providerType = TimedWalkResultTableViewProvider.self
        
    case is ORKHolePegTestResult:
        providerType = HolePegTestResultTableViewProvider.self
    
    case is ORKTrailmakingResult:
        providerType = TrailmakingResultTableViewProvider.self
        
    
    case is ORKTaskResult:
        providerType = TaskResultTableViewProvider.self


    case is ORKCollectionResult where !(result is ORKTaskResult):
        providerType = CollectionResultTableViewProvider.self
      
    case is ORKVideoInstructionStepResult:
        providerType = VideoInstructionStepResultTableViewProvider.self
        
    case is ORKWebViewStepResult:
        providerType = WebViewStepResultTableViewProvider.self
        
    case is ORKLandoltCResult:
        providerType = LandoltCStepResultProvider.self

    case is ORKEnvironmentSPLMeterResult:
        providerType = SPLMeterStepResultTableViewProvider.self
        
    case is ORKdBHLToneAudiometryResult:
        providerType = dBHLToneAudiometryResultTableViewProvider.self

    default:
        fatalError("No ResultTableViewProvider defined for \(type(of: result)).")
    }
    
    
    return providerType.init(result: result, delegate: delegate)
}


enum ResultRow {
    

    case text(String, detail: String, selectable: Bool)
    case textImage(String, image: UIImage?)
    case image(UIImage?)
    
    
    
    enum TableViewCellIdentifier: String {
        case `default` =          "Default"
        case noResultSet =      "NoResultSet"
        case noChildResults =   "NoChildResults"
        case textImage =        "TextImage"
        case image =            "Image"
    }
    
    
    
    
    init(text: String, detail: Any?, selectable: Bool = false) {

        let detailText: String
        
        if let detail = detail as? NSObject {
            detailText = String(describing: detail)
        } else {
            detailText = detail.map { String(describing: $0) } ?? "nil"
        }
        
        self = .text(text, detail: detailText, selectable: selectable)
    }
}

class NoRecentResultTableViewProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: ResultRow.TableViewCellIdentifier.noResultSet.rawValue, for: indexPath)
    }
}



class ResultTableViewProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    
    let result: ORKResult
    
    var delegate: ResultProviderDelegate?
    
    
    
    required init(result: ORKResult, delegate: ResultProviderDelegate?) {
        self.result = result
        self.delegate = delegate
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let resultRows = resultRowsForSection(section)

        
        if resultRows.isEmpty {
            return 1
        }
        
        return resultRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resultRows = resultRowsForSection((indexPath as NSIndexPath).section)
        
        
        if resultRows.isEmpty {
            let noChildResultsCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: ResultRow.TableViewCellIdentifier.noChildResults.rawValue, for: indexPath)
            
            if #available(iOS 13.0, *) {
                noChildResultsCell.textLabel?.textColor = UIColor.label
            }
            
            return noChildResultsCell
        }

        
        let resultRow = resultRows[(indexPath as NSIndexPath).row]
        
        switch resultRow {
            case let .text(text, detail: detailText, selectable):
                let cell = tableView.dequeueReusableCell(withIdentifier: ResultRow.TableViewCellIdentifier.default.rawValue, for: indexPath)

                cell.textLabel!.text = text
                cell.detailTextLabel!.text = detailText
                
                if #available(iOS 13.0, *) {
                    cell.textLabel?.textColor = UIColor.label
                    cell.detailTextLabel?.textColor = UIColor.secondaryLabel
                }
                

                cell.selectionStyle = selectable ? .default : .none
                cell.accessoryType = selectable ? .disclosureIndicator : .none
            
                return cell

            case let .textImage(text, image):
                let cell = tableView.dequeueReusableCell(withIdentifier: ResultRow.TableViewCellIdentifier.textImage.rawValue, for: indexPath) as! TextImageTableViewCell

                cell.leftTextLabel?.text = text
                cell.rightImageView?.image = image
                
                if #available(iOS 13.0, *) {
                    cell.leftTextLabel?.textColor = UIColor.label
                }

                return cell

            case let .image(image):
                let cell = tableView.dequeueReusableCell(withIdentifier: ResultRow.TableViewCellIdentifier.image.rawValue, for: indexPath) as! ImageTableViewCell

                cell.fullImageView?.image = image

                return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Result" : nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if indexPath.section == 0 && cell?.textLabel?.text == "fileURL" {
            
            let fileURL = NSURL(fileURLWithPath: (cell?.detailTextLabel!.text)!)
            let filesToShare = [fileURL]

            let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)

            if let resultProviderDelegate = delegate {
                resultProviderDelegate.presentShareSheet(shareSheet: activityViewController)
            }
        }
        
    }
    
    
    
    func resultRowsForSection(_ section: Int) -> [ResultRow] {
        
        guard section == 0 else { return [] }
        var rows = [
            
            ResultRow(text: "type", detail: type(of: result)),

            ResultRow(text: "identifier", detail: result.identifier),
            
            
            ResultRow(text: "start", detail: result.startDate),
            
            
            ResultRow(text: "end", detail: result.endDate)
        ]
        if let questionResult = result as? ORKQuestionResult {
            rows.append(
                ResultRow(text: "noAnswerType", detail: questionResult.noAnswerType)
            )
        }
        return rows
    }
}


class BooleanQuestionResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let boolResult = result as! ORKBooleanQuestionResult
        
        var boolResultDetailText: String?
        if let booleanAnswer = boolResult.booleanAnswer {
            boolResultDetailText = booleanAnswer.boolValue ? "true" : "false"
        }
        
        return super.resultRowsForSection(section) + [
            ResultRow(text: "bool", detail: boolResultDetailText)
        ]
    }
}


class ChoiceQuestionResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let choiceResult = result as! ORKChoiceQuestionResult
        
        return super.resultRowsForSection(section) + [
            ResultRow(text: "choices", detail: choiceResult.choiceAnswers)
        ]
    }
}



class DateQuestionResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let questionResult = result as! ORKDateQuestionResult
        
        return super.resultRowsForSection(section) + [
            
            ResultRow(text: "dateAnswer", detail: questionResult.dateAnswer),
            
            
            ResultRow(text: "calendar", detail: questionResult.calendar),
            
            
            ResultRow(text: "timeZone", detail: questionResult.timeZone)
        ]
    }
}


class LocationQuestionResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let questionResult = result as! ORKLocationQuestionResult
        let location = questionResult.locationAnswer
        let address = CNPostalAddressFormatter.string(from: (location?.postalAddress)!, style: .mailingAddress)
        let rows = super.resultRowsForSection(section) + [
            
            ResultRow(text: "latitude", detail: location?.coordinate.latitude),
            ResultRow(text: "longitude", detail: location?.coordinate.longitude),
            ResultRow(text: "address", detail: address)
        ]
        
        return rows
    }
}


class NumericQuestionResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let questionResult = result as! ORKNumericQuestionResult
        
        return super.resultRowsForSection(section) + [
            
            ResultRow(text: "numericAnswer", detail: questionResult.numericAnswer),
            
            
            ResultRow(text: "unit", detail: questionResult.unit),
            
            
            ResultRow(text: "displayUnit", detail: questionResult.displayUnit)
        ]
    }
}


class SESQuestionResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let rungQuestionResult = result as! ORKSESQuestionResult
        
        return super.resultRowsForSection(section) + [
            
            ResultRow(text: "rungPicked", detail: rungQuestionResult.rungPicked)
        ]
    }
}


class ScaleQuestionResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let scaleQuestionResult = result as! ORKScaleQuestionResult
        
        return super.resultRowsForSection(section) + [
            
            ResultRow(text: "scaleAnswer", detail: scaleQuestionResult.scaleAnswer)
        ]
    }
}


class TextQuestionResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let questionResult = result as! ORKTextQuestionResult
        
        return super.resultRowsForSection(section) + [
            
            ResultRow(text: "textAnswer", detail: questionResult.textAnswer)
        ]
    }
}


class TimeIntervalQuestionResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let questionResult = result as! ORKTimeIntervalQuestionResult
        
        return super.resultRowsForSection(section) + [
            
            ResultRow(text: "intervalAnswer", detail: questionResult.intervalAnswer)
        ]
    }
}


class TimeOfDayQuestionResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let questionResult = result as! ORKTimeOfDayQuestionResult
        
        
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.unitsStyle = .full
        let dateComponentsAnswerText = dateComponentsFormatter.string(from: questionResult.dateComponentsAnswer!)

        return super.resultRowsForSection(section) + [
            
            ResultRow(text: "dateComponentsAnswer", detail: dateComponentsAnswerText)
        ]
    }
}


class ConsentSignatureResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let signatureResult = result as! ORKConsentSignatureResult
        let signature = signatureResult.signature!
        
        return super.resultRowsForSection(section) + [

            ResultRow(text: "identifier", detail: signature.identifier),

            ResultRow(text: "title", detail: signature.title),
            
            
            ResultRow(text: "givenName", detail: signature.givenName),
            
            
            ResultRow(text: "familyName", detail: signature.familyName),
            
            
            ResultRow(text: "date", detail: signature.signatureDate),
            
            
            .textImage("signature", image: signature.signatureImage)
        ]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        let lastRow = self.tableView(tableView, numberOfRowsInSection: (indexPath as NSIndexPath).section) - 1
        
        if (indexPath as NSIndexPath).row == lastRow {
            return 200
        }
        
        return UITableView.automaticDimension
    }
}


class AmslerGridResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let amslerGridResult = result as! ORKAmslerGridResult
        let image = amslerGridResult.image!
        let eyeSide: String = amslerGridResult.eyeSide.rawValue == 0 ? "Not Specified": amslerGridResult.eyeSide.rawValue == 1 ? "Left": "Right"
        
        return super.resultRowsForSection(section) + [
            
            ResultRow(text: "Eye Side", detail: eyeSide),
            .textImage("image", image: image)
        ]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        let lastRow = self.tableView(tableView, numberOfRowsInSection: (indexPath as NSIndexPath).section) - 1
        
        if (indexPath as NSIndexPath).row == lastRow {
            return 300
        }
        
        return UITableView.automaticDimension
    }
}


class PasscodeResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let passcodeResult = result as! ORKPasscodeResult
        
        var passcodeResultDetailText: String?
        passcodeResultDetailText = passcodeResult.isPasscodeSaved ? "true" : "false"
        
        return super.resultRowsForSection(section) + [
            ResultRow(text: "passcodeSaved", detail: passcodeResultDetailText)
        ]
    }
}


class FileResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let questionResult = result as! ORKFileResult
        
        let rows = super.resultRowsForSection(section) + [
            
            ResultRow(text: "contentType", detail: questionResult.contentType),
            
            
            ResultRow(text: "fileURL", detail: questionResult.fileURL)
        ]

        if let fileURL = questionResult.fileURL, let contentType = questionResult.contentType, contentType.hasPrefix("image/"), !contentType.hasSuffix(".dng") {
            
            if let image = UIImage(contentsOfFile: fileURL.path) {
                return rows + [
                    
                    .image(image)
                ]
            }
        }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        let resultRows = resultRowsForSection((indexPath as NSIndexPath).section)
        
        if !resultRows.isEmpty {
            switch resultRows[(indexPath as NSIndexPath).row] {
            case .image(.some(let image)):
                
                let imageAspectRatio = image.size.width / image.size.height
                
                return tableView.frame.size.width / imageAspectRatio
                
            default:
                break
            }
        }
        
        return UITableView.automaticDimension
    }
}


class SpatialSpanMemoryResultTableViewProvider: ResultTableViewProvider {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return super.tableView(tableView, titleForHeaderInSection: 0)
        }
        
        return "Game Records"
    }
    
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let questionResult = result as! ORKSpatialSpanMemoryResult
        
        let rows = super.resultRowsForSection(section)
        
        if section == 0 {
            return rows + [
                
                ResultRow(text: "score", detail: questionResult.score),
                
                
                ResultRow(text: "numberOfGames", detail: questionResult.numberOfGames),
                
                
                ResultRow(text: "numberOfFailures", detail: questionResult.numberOfFailures)
            ]
        }
        
        return rows + questionResult.gameRecords!.map { gameRecord in
            
            return ResultRow(text: "game", detail: gameRecord.score)
        }
    }
}


class SpeechRecognitionResultTableViewProvider: ResultTableViewProvider {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let speechRecognitionResult = result as! ORKSpeechRecognitionResult
        if let segments = speechRecognitionResult.transcription?.segments {
            return segments.count + 1
        } else {
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
         if section == 0 {
            return super.tableView(tableView, titleForHeaderInSection: 0)
        }
            
        let speechRecognitionResult = result as! ORKSpeechRecognitionResult
        if speechRecognitionResult.transcription?.segments != nil {
            return "Transcritption " + String(section)
        } else {
            return "Error"
        }
    }
    
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let speechRecognitionResult = result as! ORKSpeechRecognitionResult
        
        let rows = super.resultRowsForSection(section)
        
        if section == 0 {
            return rows
        }
        
        if let segments = speechRecognitionResult.transcription?.segments {
            let segement = segments[section - 1]
            return [
                ResultRow(text: "substring", detail: segement.substring),
                ResultRow(text: "confidence", detail: segement.confidence),
                ResultRow(text: "timestamp", detail: segement.timestamp),
                ResultRow(text: "duration", detail: segement.duration)
            ]
        } else {
            return [ResultRow(text: "error", detail: "speech recognition failed or cancelled")]
        }
    }
}


class StroopResultTableViewProvider: ResultTableViewProvider {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return super.tableView(tableView, titleForHeaderInSection: 0)
        }
    
        return "Samples"
    }
    
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let stroopResult = result as! ORKStroopResult
        
        let rows = super.resultRowsForSection(section)
        
        if section == 0 {
            return rows
        }
        return [
            ResultRow(text: "Color", detail: stroopResult.color),
            ResultRow(text: "Text", detail: stroopResult.text),
            ResultRow(text: "Color Selected", detail: stroopResult.colorSelected)
        ]
    }
}


class SwiftStroopResultTableViewProvider: ResultTableViewProvider {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return super.tableView(tableView, titleForHeaderInSection: 0)
        }
        
        return "Samples"
    }
    
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let stroopResult = result as! ResearchKit.ORKSwiftStroopResult
        
        let rows = super.resultRowsForSection(section)
        
        if section == 0 {
            return rows
        }
        return [
            ResultRow(text: "Color", detail: stroopResult.color),
            ResultRow(text: "Text", detail: stroopResult.text),
            ResultRow(text: "Color Selected", detail: stroopResult.colorSelected)
        ]
    }
}


class TappingIntervalResultTableViewProvider: ResultTableViewProvider {
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return super.tableView(tableView, titleForHeaderInSection: 0)
        }
        
        return "Samples"
    }
    
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let questionResult = result as! ORKTappingIntervalResult
        
        let rows = super.resultRowsForSection(section)
        
        if section == 0 {
            return rows + [
                
                ResultRow(text: "stepViewSize", detail: questionResult.stepViewSize),

                
                ResultRow(text: "buttonRect1", detail: questionResult.buttonRect1),
                
                
                ResultRow(text: "buttonRect2", detail: questionResult.buttonRect2)
            ]
        }
        
        
        return rows + questionResult.samples!.map { tappingSample in
            
            
            let buttonText = tappingSample.buttonIdentifier == .none ? "None" : "button \(tappingSample.buttonIdentifier.rawValue)"
            
            let text = String(format: "%.3f", tappingSample.timestamp)
            let detail = "\(buttonText) \(tappingSample.location)"
            
            return ResultRow(text: text, detail: detail)
        }
    }
}


class ToneAudiometryResultTableViewProvider: ResultTableViewProvider {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return super.tableView(tableView, titleForHeaderInSection: 0)
        }
        
        return "Samples"
    }
    
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let toneAudiometryResult = result as! ORKToneAudiometryResult
        let rows = super.resultRowsForSection(section)
        
        if section == 0 {
            return rows + [
                
                ResultRow(text: "outputVolume", detail: toneAudiometryResult.outputVolume)
            ]
        }
        
        
        return rows + toneAudiometryResult.samples!.map { toneSample in
            let text: String
            let detail: String
            
            let channelName = toneSample.channel == .left ? "Left" : "Right"
            let correct = toneSample.channelSelected == toneSample.channel ? "Correct" : "Incorrect"
            
            text = "\(toneSample.frequency) \(channelName)"
            detail = "\(toneSample.amplitude) \(correct)"
            
            return ResultRow(text: text, detail: detail)
        }
    }
}


class ReactionTimeViewProvider: ResultTableViewProvider {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return super.tableView(tableView, titleForHeaderInSection: 0)
        }
        
        return "File Results"
    }
    
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let reactionTimeResult = result as! ORKReactionTimeResult
        
        let rows = super.resultRowsForSection(section)
        
        if section == 0 {
            return rows + [
                ResultRow(text: "timestamp", detail: reactionTimeResult.timestamp)
            ]
        }
        
        let fileResultDetail = reactionTimeResult.fileResult.fileURL!.absoluteString
        
        return rows + [
            ResultRow(text: "File Result", detail: fileResultDetail)
        ]
    }
}


class RangeOfMotionResultTableViewProvider: ResultTableViewProvider {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let rangeOfMotionResult = result as! ORKRangeOfMotionResult
        let rows = super.resultRowsForSection(section)
        return rows + [
            ResultRow(text: "start", detail: rangeOfMotionResult.start),
            ResultRow(text: "finish", detail: rangeOfMotionResult.finish),
            ResultRow(text: "minimum", detail: rangeOfMotionResult.minimum),
            ResultRow(text: "maximum", detail: rangeOfMotionResult.maximum),
            ResultRow(text: "range", detail: rangeOfMotionResult.range)
        ]
    }
}


class TowerOfHanoiResultTableViewProvider: ResultTableViewProvider {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let towerOfHanoiResult = result as! ORKTowerOfHanoiResult
        return towerOfHanoiResult.moves != nil ? (towerOfHanoiResult.moves!.count + 1) : 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return super.tableView(tableView, titleForHeaderInSection: 0)
        }
        
        return "Move \(section )"
    }
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let towerOfHanoiResult = result as! ORKTowerOfHanoiResult
        let rows = super.resultRowsForSection(section)
        if section == 0 {
            return rows + [
                ResultRow(text: "solved", detail: towerOfHanoiResult.puzzleWasSolved ? "true" : "false"),
                ResultRow(text: "moves", detail: "\(towerOfHanoiResult.moves?.count ?? 0 )")]
        }
        
        let move = towerOfHanoiResult.moves![section - 1]
        return rows + [
            ResultRow(text: "donor tower", detail: "\(move.donorTowerIndex)"),
            ResultRow(text: "recipient tower", detail: "\(move.recipientTowerIndex)"),
            ResultRow(text: "timestamp", detail: "\(move.timestamp)")]
    }
}


class TrailmakingResultTableViewProvider: ResultTableViewProvider {

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return super.tableView(tableView, titleForHeaderInSection: 0)
    }
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let rows = super.resultRowsForSection(section)
        return rows
    }
}


class PSATResultTableViewProvider: ResultTableViewProvider {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return super.tableView(tableView, titleForHeaderInSection: 0)
        }
        
        return "Answers"
    }
    
    
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let PSATResult = result as! ORKPSATResult
        
        var rows = super.resultRowsForSection(section)
        
        if section == 0 {
            var presentation = ""
            let presentationMode = PSATResult.presentationMode
            if presentationMode == .auditory {
                presentation = "PASAT"
            } else if presentationMode == .visual {
                presentation = "PVSAT"
            } else if presentationMode.contains(.auditory) && presentationMode.contains(.visual) {
                presentation = "PAVSAT"
            } else {
                presentation = "Unknown"
            }
            
            
            rows.append(ResultRow(text: "presentation", detail: presentation))
            
            
            rows.append(ResultRow(text: "ISI", detail: PSATResult.interStimulusInterval))
            
            
            rows.append(ResultRow(text: "stimulus", detail: PSATResult.stimulusDuration))
            
            
            rows.append(ResultRow(text: "length", detail: PSATResult.length))
            
            
            rows.append(ResultRow(text: "total correct", detail: PSATResult.totalCorrect))
            
            
            rows.append(ResultRow(text: "total dyad", detail: PSATResult.totalDyad))
            
            
            rows.append(ResultRow(text: "total time", detail: PSATResult.totalTime))
            
            
            rows.append(ResultRow(text: "initial digit", detail: PSATResult.initialDigit))
            
            return rows
        }
        
        
        return rows + PSATResult.samples!.map { sample in
            let PSATSample = sample
            
            let text = String(format: "%@", PSATSample.isCorrect ? "correct" : "error")
            let detail = "\(PSATSample.answer) (digit: \(PSATSample.digit), time: \(PSATSample.time))"
            
            return ResultRow(text: text, detail: detail)
        }
    }
}


class TimedWalkResultTableViewProvider: ResultTableViewProvider {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return super.tableView(tableView, titleForHeaderInSection: 0)
    }
    
    
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let timedWalkResult = result as! ORKTimedWalkResult
        
        let rows = super.resultRowsForSection(section)
        
        return rows + [
            
            ResultRow(text: "distance (m)", detail: timedWalkResult.distanceInMeters),
            
            
            ResultRow(text: "time limit (s)", detail: timedWalkResult.timeLimit),
            
            
            ResultRow(text: "duration (s)", detail: timedWalkResult.duration)
        ]
    }
}


class HolePegTestResultTableViewProvider: ResultTableViewProvider {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return super.tableView(tableView, titleForHeaderInSection: 0)
        }
        
        return "Moves"
    }
    
    
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let holePegTestResult = result as! ORKHolePegTestResult
        
        var rows = super.resultRowsForSection(section)
        
        if section == 0 {
            var side = ""
            let movingDirection = holePegTestResult.movingDirection
            if movingDirection == .left {
                side = "left > right"
            } else if movingDirection == .right {
                side = "right > left"
            }
            
            
            rows.append(ResultRow(text: "direction", detail: side))
            
            
            rows.append(ResultRow(text: "dominant hand", detail: holePegTestResult.isDominantHandTested))
            
            
            rows.append(ResultRow(text: "number of pegs", detail: holePegTestResult.numberOfPegs))
            
            
            rows.append(ResultRow(text: "threshold", detail: holePegTestResult.threshold))
            
            
            if result.identifier.range(of: "place") != nil {
                rows.append(ResultRow(text: "rotated", detail: holePegTestResult.isRotated))
            }
            
            
            rows.append(ResultRow(text: "total successes", detail: holePegTestResult.totalSuccesses))
            
            
            rows.append(ResultRow(text: "total failures", detail: holePegTestResult.totalFailures))
            
            
            rows.append(ResultRow(text: "total time", detail: holePegTestResult.totalTime))
            
            
            rows.append(ResultRow(text: "total distance", detail: holePegTestResult.totalDistance))
            
            return rows
        }
        
        
        return rows + holePegTestResult.samples!.map { sample in
            let holePegTestSample = sample as! ORKHolePegTestSample
            
            let text = "time (s): \(holePegTestSample.time))"
            let detail = "distance (pt): \(holePegTestSample.distance)"
            
            return ResultRow(text: text, detail: detail)
        }
    }
}


class TaskResultTableViewProvider: CollectionResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let taskResult = result as! ORKTaskResult
        
        let rows = super.resultRowsForSection(section)
        
        if section == 0 && (taskResult.results?.count)! > 0 {
            return rows + [
                ResultRow(text: "taskRunUUID", detail: taskResult.taskRunUUID.uuidString),
                ResultRow(text: "outputDirectory", detail: taskResult.outputDirectory)
            ]
        }
        
        return rows
    }
}


class CollectionResultTableViewProvider: ResultTableViewProvider {
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return super.tableView(tableView, titleForHeaderInSection: 0)
        }
        
        return "Child Results"
    }
    
    
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: IndexPath) -> Bool {
        return (indexPath as NSIndexPath).section == 1
    }
    
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let collectionResult = result as! ORKCollectionResult
        
        let rows = super.resultRowsForSection(section)
        
        
        if section == 1 {
            return rows + collectionResult.results!.map { childResult in
                let childResultClassName = "\(type(of: childResult))"

                return ResultRow(text: childResultClassName, detail: childResult.identifier, selectable: true)
            }
        }
        
        return rows
    }
}


class VideoInstructionStepResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let videoInstructionStepResult = result as! ORKVideoInstructionStepResult
        
        let rows = super.resultRowsForSection(section)
        
        if section == 0 {
            return rows + [
                ResultRow(text: "playbackStoppedTime", detail: videoInstructionStepResult.playbackStoppedTime),
                ResultRow(text: "playbackCompleted", detail: videoInstructionStepResult.playbackCompleted)
            ]
        }
        
        return rows
    }
}






class WebViewStepResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let webViewStepResult = result as! ORKWebViewStepResult
        
        let rows = super.resultRowsForSection(section)
        
        if section == 0 {
            return rows + [
                ResultRow(text: "result", detail: webViewStepResult.result)
            ]
        }
        
        return rows
    }
}

class LandoltCStepResultProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let landoltCResult = result as! ORKLandoltCResult

        let rows = super.resultRowsForSection(section)
        
        if section == 0 {
            return rows + [
                ResultRow(text: "outcome", detail: landoltCResult.outcome),
                ResultRow(text: "letterAngle", detail: landoltCResult.letterAngle),
                ResultRow(text: "sliderAngle", detail: landoltCResult.sliderAngle),
                ResultRow(text: "score", detail: landoltCResult.score)
            ]
        }
        
        return rows
    }
}


class dBHLToneAudiometryResultTableViewProvider: ResultTableViewProvider {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return super.tableView(tableView, titleForHeaderInSection: 0)
        }
        
        return "Samples"
    }
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let dBHLToneAudiometryResult = result as! ORKdBHLToneAudiometryResult
        
        let rows = super.resultRowsForSection(section)
        
        if section == 0 {
            return rows + [
                ResultRow(text: "outputVolume", detail: dBHLToneAudiometryResult.outputVolume),
                ResultRow(text: "tonePlaybackDuration", detail: dBHLToneAudiometryResult.tonePlaybackDuration),
                ResultRow(text: "postStimulusDelay", detail: dBHLToneAudiometryResult.postStimulusDelay),
                ResultRow(text: "headphoneType", detail: dBHLToneAudiometryResult.headphoneType)
            ]
        } else if section == 1 {
            guard let samples = dBHLToneAudiometryResult.samples else { return rows }
            
            let sortedSamples = samples.sorted { $0.frequency < $1.frequency }
            return rows + sortedSamples.map { sample in
                return ResultRow(text: "freq: \(String(format: "%.1f",sample.frequency))", detail: "threshold: \(String(format: "%.2f", sample.calculatedThreshold)), channel: \(sample.channel == .left ? "left" : "right")", selectable: false)
            }
        }
        
        return rows
    }
}


class SPLMeterStepResultTableViewProvider: ResultTableViewProvider {
    
    
    override func resultRowsForSection(_ section: Int) -> [ResultRow] {
        let splMeterResult = result as! ORKEnvironmentSPLMeterResult
        
        let rows = super.resultRowsForSection(section)
        
        if section == 0 {
            return rows + [
                ResultRow(text: "sensitivityOffset", detail: splMeterResult.sensitivityOffset),
                ResultRow(text: "recordedSPLMeterSamples", detail: splMeterResult.recordedSPLMeterSamples)
            ]
        }
        
        return rows
    }
}
