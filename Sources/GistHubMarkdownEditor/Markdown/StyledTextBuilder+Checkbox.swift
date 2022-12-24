import UIKit
import StyledTextKit

extension StyledTextBuilder {
    func addCheckbox(checked: Bool, range: NSRange, viewerCanUpdate: Bool) {
        guard let image = UIImage.checkbox(checked: checked, viewerCanUpdate: viewerCanUpdate) else {
            return
        }
        let attachment = NSTextAttachment()
        attachment.image = image
        // nudge bounds to align better with baseline text
        attachment.bounds = CGRect(x: 0, y: -2, width: image.size.width, height: image.size.height)

        guard let attachmentString = NSAttributedString(attachment: attachment).mutableCopy() as? NSMutableAttributedString else {
            return
        }
        attachmentString.addAttribute(
            MarkdownAttribute.checkbox,
            value: MarkdownCheckboxModel(checked: checked, originalMarkdownRange: range),
            range: attachmentString.string.nsrange
        )
        add(attributedText: attachmentString).add(text: " ")
    }
}

private extension UIImage {
    static func checkbox(checked: Bool, viewerCanUpdate: Bool) -> UIImage? {
        let icon = UIImage(
            named: checked ? "checked" : "unchecked",
            in: .module, compatibleWith: nil
        )?.withRenderingMode(.alwaysOriginal)
        return viewerCanUpdate ? icon : icon?.alpha(0.5)
    }

    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
        UIGraphicsEndImageContext()
        return newImage!
    }
}
