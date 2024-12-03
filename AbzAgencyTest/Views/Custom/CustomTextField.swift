import SwiftUI

struct GoogleStyleTextField: View {
    @Binding var text: String
    @Binding var errorText: String
    
    @State private var isFocused = false
    @State private var isError = false
    
    @FocusState private var isTextFieldFocused: Bool
    
    var supportText = ""
    var placeholderText = ""
    
    var body: some View {
        ZStack {
            ZStack(alignment: .leading) {
                TextField("", text: $text, onEditingChanged: { editing in
                    withAnimation {
                        isFocused = editing
                    }
                    
                })
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .font(AppTypography.body1())
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .frame(height: 56)
                .focused($isTextFieldFocused)
                .onChange(of: text){
                    if isError {
                        withAnimation {
                            errorText = ""
                        }
                    }
                }
                .onChange(of: errorText) {
                    withAnimation {
                        isError = !errorText.isEmpty
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(isError ? AppColors.error : (isFocused ? AppColors.secondary : AppColors.borderColor), lineWidth: 1)
                )
                
                Text(placeholderText)
                    .font(isFocused || !text.isEmpty ? AppTypography.body3() : AppTypography.body1())
                    .foregroundColor(isError ? AppColors.error : (isFocused && text.isEmpty ? AppColors.secondary : AppColors.black48))
                    .offset(y: isFocused || !text.isEmpty ? -16 : 0)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .onTapGesture {
                isTextFieldFocused = true
            }
            
            Text(isError ? errorText : supportText)
                .foregroundColor(isError ? AppColors.error : !supportText.isEmpty ? AppColors.black60 : Color.clear)
                .font(AppTypography.body3())
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding(.horizontal)
        }
        .frame(height: 76)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleStyleTextField(text: .constant("Hello, World!"), errorText: .constant("Error"))
    }
}
