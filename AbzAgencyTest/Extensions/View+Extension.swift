import SwiftUI

extension View {
    func onFocusChange<T: Equatable>(
        of value: T,
        perform validation: @escaping () -> Void
    ) -> some View {
        self.onChange(of: value) {
            if !isActive(value) {
                validation()
            }
        }
    }
    
    func onFocusChange(
            of focusState: FocusState<Bool>,
            perform validation: @escaping () -> Void
        ) -> some View {
            self.onChange(of: focusState.wrappedValue) {
                if !focusState.wrappedValue {
                    validation()
                }
            }
        }
    
    /// Проверяет, является ли значение активным.
    private func isActive<T>(_ value: T) -> Bool {
        if let boolValue = value as? Bool {
            return boolValue
        }
        return false
    }
}
