import SwiftUI
import Foundation
import Combine

struct NumberTextField<V>: UIViewRepresentable where V: Numeric & LosslessStringConvertible {
    @Binding var value: V
    
    typealias UIViewType = UITextField

    func makeUIView(context: UIViewRepresentableContext<NumberTextField>) -> UITextField {
        let editField = UITextField()
        editField.delegate = context.coordinator
        return editField
    }

    func updateUIView(_ editField: UITextField, context: UIViewRepresentableContext<NumberTextField>) {
        editField.text = String(value)
    }

    func makeCoordinator() -> NumberTextField.Coordinator {
        Coordinator(value: $value)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var value: Binding<V>

        init(value: Binding<V>) {
            self.value = value
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {

            let text = textField.text as NSString?
            let newValue = text?.replacingCharacters(in: range, with: string)

            if let number = V(newValue ?? "0") {
                self.value.wrappedValue = number
                return true
            } else {
                if nil == newValue || newValue!.isEmpty {
                    self.value.wrappedValue = 0
                }
                return false
            }
        }

        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            if reason == .committed {
                textField.resignFirstResponder()
            }
        }
        
    }
}

struct TestTextFieldWithNumbers: View {
    @State private var value = 0
    var body: some View {
        VStack {
            Text("Current value: \(value)")
            Divider()
            TextField("", value: $value, formatter: NumberFormatter())
//                .keyboardType(UIKeyboardType.decimalPad)
            Divider()
            NumberTextField(value: $value)
                .frame(height: 32)
        }
    }
}

struct TestTextFieldWithNumbers_Previews: PreviewProvider {
    static var previews: some View {
        TestTextFieldWithNumbers()
    }
}
