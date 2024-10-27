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
    
    case is ORKConsentSignatureResult:
        providerType = ConsentSignatureResultTableViewProvider.self
        
    
    case is ORKAmslerGridResult:
        providerType = AmslerGridResultTableViewProvider.self
        
    case is ORKPasscodeResult:
        providerType = PasscodeResultTableViewProvider.self
        
    case is ORKFileResult:
        providerType = FileResultTableViewProvider.self

    case is ORKTaskResult:
        providerType = TaskResultTableViewProvider.self
    case is ORKCollectionResult where !(result is ORKTaskResult):
        providerType = CollectionResultTableViewProvider.self

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
