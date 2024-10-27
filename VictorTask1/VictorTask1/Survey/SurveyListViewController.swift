//
//  SurveyListViewController.swift
//  VictorTask1
//
//  Created by Mironchik on 26.10.24.
//


import UIKit
import ResearchKit.Private

class SurveyListViewController: UITableViewController, ORKTaskViewControllerDelegate {

    var waitStepViewController: ORKWaitStepViewController?
    var waitStepUpdateTimer: Timer?
    var waitStepProgress: CGFloat = 0.0

    
    var restorationDataByTaskID: [String:Data] = [:]
    
    
    
    enum TableViewCellIdentifier: String {
        case `default` = "Default"
    }
    
    
    
    var taskResultFinishedCompletionHandler: ((ORKResult) -> Void)?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            self.tableView.backgroundColor = UIColor.systemGroupedBackground
        }
    }
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return SurveyListRow.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SurveyListRow.sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SurveyListRow.sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.default.rawValue, for: indexPath)
        
        let taskListRow = SurveyListRow.sections[(indexPath as NSIndexPath).section].rows[(indexPath as NSIndexPath).row]
        
        cell.textLabel!.text = "\(taskListRow)"
        
        if #available(iOS 13.0, *) {
            cell.textLabel?.textColor = UIColor.label
        }
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let taskListRow = SurveyListRow.sections[(indexPath as NSIndexPath).section].rows[(indexPath as NSIndexPath).row]
        
        displayTaskViewController(taskListRow: taskListRow)

    }
    
    func displayTaskViewController(taskListRow: SurveyListRow) {
        
        let task = taskListRow.representedTask
        
        let taskViewController: ORKTaskViewController
        if let restorationData = restorationDataByTaskID[task.identifier] {
            
            
            taskViewController = ORKTaskViewController(task: task, restorationData: restorationData, delegate: self, error: nil)
        } else {
            
            
            taskViewController = ORKTaskViewController(task: task, ongoingResult: nil, defaultResultSource: nil, delegate: self)

            
            taskViewController.outputDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
        
        present(taskViewController, animated: true, completion: nil)
    }
    
    
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {

        taskResultFinishedCompletionHandler?(taskViewController.result)
        
        switch (reason) {
        case .saved:
            saveRestorationDataFor(taskViewController);
            break;
            
        case .discarded:
            resetRestorationDataFor(taskViewController);
            break;

        case .completed, .earlyTermination, .failed:
            
            resetRestorationDataFor(taskViewController);

            
            if taskViewController.result.identifier == String(describing: SurveyListRow.Identifier.tintColorTask) {
                updateForTintColorTaskResult(taskViewController.result)
            }

            break;

        default:
            break;
        }
        
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, stepViewControllerWillAppear stepViewController: ORKStepViewController) {
        
        if stepViewController.step?.identifier == "WaitStepIndeterminate" ||
            stepViewController.step?.identifier == "WaitStep" ||
            stepViewController.step?.identifier == "LoginWaitStep" {
            delay(5.0, closure: { () -> Void in
                if let stepViewController = stepViewController as? ORKWaitStepViewController {
                    stepViewController.goForward()
                }
            })
        } else if stepViewController.step?.identifier == "WaitStepDeterminate" {
            delay(1.0, closure: { () -> Void in
                if let stepViewController = stepViewController as? ORKWaitStepViewController {
                    self.waitStepViewController = stepViewController
                    self.waitStepProgress = 0.0
                    self.waitStepUpdateTimer = Timer(timeInterval: 0.1, target: self, selector: #selector(SurveyListViewController.updateProgressOfWaitStepViewController), userInfo: nil, repeats: true)
                    RunLoop.main.add(self.waitStepUpdateTimer!, forMode: RunLoop.Mode.common)
                }
            })
        }
    }
    func taskViewController(_ taskViewController: ORKTaskViewController, learnMoreButtonPressedWith learnMoreStep: ORKLearnMoreInstructionStep, for stepViewController: ORKStepViewController) {
        stepViewController.present(UINavigationController(rootViewController: ORKLearnMoreStepViewController(step: learnMoreStep)), animated: true) {
            
        }
    }
    
    func taskViewControllerSupportsSaveAndRestore(_ taskViewController: ORKTaskViewController) -> Bool {
        return true
    }
    
    func delay(_ delay: Double, closure: @escaping () -> Void ) {
        let delayTime = DispatchTime.now() + delay
        let dispatchWorkItem = DispatchWorkItem(block: closure)
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: dispatchWorkItem)
    }
    
    @objc
    func updateProgressOfWaitStepViewController() {
        if let waitStepViewController = waitStepViewController {
            waitStepProgress += 0.01
            DispatchQueue.main.async(execute: { () -> Void in
                waitStepViewController.setProgress(self.waitStepProgress, animated: true)
            })
            if waitStepProgress < 1.0 {
                return
            } else {
                self.waitStepUpdateTimer?.invalidate()
                waitStepViewController.goForward()
                self.waitStepViewController = nil
            }
        } else {
            self.waitStepUpdateTimer?.invalidate()
        }
    }
    
    func saveRestorationDataFor(_ taskViewController: ORKTaskViewController) {
        guard let taskID = taskViewController.task?.identifier else {
            return
        }
        
        restorationDataByTaskID[taskID] = taskViewController.restorationData
    }

    func resetRestorationDataFor(_ taskViewController: ORKTaskViewController) {
        guard let taskID = taskViewController.task?.identifier else {
            return
        }
        
        restorationDataByTaskID[taskID] = nil
    }


    func updateForTintColorTaskResult(_ taskResult: ORKTaskResult) {
        let stepIdentifier = String(describing: SurveyListRow.Identifier.tintColorStep)
        let stepResult = taskResult.stepResult(forStepIdentifier: stepIdentifier)

        let questionResultIdentifier = String(describing: SurveyListRow.Identifier.tintColorQuestion)
        let result = stepResult?.result(forIdentifier: questionResultIdentifier)
        guard let questionResult = result as? ORKChoiceQuestionResult else {
            fatalError("Expected tintColor task result to have a result of type ORKChoiceQuestionResult for identifier \(questionResultIdentifier)")
        }
        guard
            let colorName = questionResult.choiceAnswers?.first as? String,
            let color = UIColor.value(forKey: colorName) as? UIColor
        else {
            
            return
        }

        
        self.view.window?.tintColor = color
    }

}
