import Cocoa

class ViewModel: NSObject {

    func setButtonToGeneratePassword(view: NSView) {
        let button = NSButton(frame: NSMakeRect((view.frame.width - 300)/2, 25, 300, 40))
        button.title = "Generate password"
        button.bezelStyle = NSBezelStyle.RegularSquareBezelStyle
        button.target = self
        button.action = "onGenerateButtonPressed"

        view.addSubview(button)
    }

    func setTextFieldInView(view: NSView) -> NSTextField {
        let textField = NSTextField(NSMakeRect((view.frame.width - 300)/2, self.window!.contentView.frame.height - 175, 300, 50))
        textField.placeholderString = "Tap generate password"
        textField.font = NSFont(name: "AvenirNext-Regular", size: 22)
        textField.alignment = NSTextAlignment.CenterTextAlignment
        textField.editable = false
        textField.selectable = true

        view.addSubview(textField)

        return textField
    }
}
