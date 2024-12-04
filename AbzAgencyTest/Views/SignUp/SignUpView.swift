import PhotosUI
import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var signUpViewModel: SignUpViewModel
    
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var showingImagePicker = false
    @State private var showActionSheet = false
    
    @FocusState private var isNameFocused: Bool
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPhoneFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            CustomTopBar(method: .post)
            ScrollView {
                VStack (spacing: 24) {
                    VStack(spacing: 12) {
                        CustomTextField(text: $signUpViewModel.name,
                                             errorText: $signUpViewModel.nameError,
                                             placeholderText: "Your name")
                            .focused($isNameFocused)
                        
                        CustomTextField(text: $signUpViewModel.email,
                                             errorText: $signUpViewModel.emailError,
                                             placeholderText: "Email")
                            .focused($isEmailFocused)
                            .keyboardType(.emailAddress)
                        
                        CustomTextField(text: $signUpViewModel.phone,
                                             errorText: $signUpViewModel.phoneError,
                                             supportText: "+38 (XXX) XXX - XX - XX",
                                             placeholderText: "Phone")
                            .focused($isPhoneFocused)
                            .keyboardType(.phonePad)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Select your position")
                            .font(AppTypography.body2())
                        
                        ForEach(signUpViewModel.positions, id: \.id) { position in
                            HStack {
                                Circle()
                                    .strokeBorder(signUpViewModel.selectedPosition?.id == position.id ? AppColors.secondary : AppColors.borderColor, lineWidth: signUpViewModel.selectedPosition?.id == position.id ? 4 : 1)
                                    .frame(width: 14, height: 14)
                                
                                Text(position.name)
                                    .font(AppTypography.body2())
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 12)
                                
                            }
                            .padding(.horizontal)
                            .onTapGesture {
                                signUpViewModel.selectedPosition = position
                                dismissKeyboard()
                            }
                        }
                        .padding(.top, 12)
                    }
                    .padding(.horizontal)
                    
                    // Choose photo view
                    PhotoUploadView(isPhotoUploaded: $signUpViewModel.isPhotoUploaded,
                                    showActionSheet: $showActionSheet,
                                    errorMessage: $signUpViewModel.photoError,
                                    imageName: $signUpViewModel.photoName,
                                    dismissKeyboard: dismissKeyboard)
                    
                    Button(action: {
                        dismissKeyboard()
                        Task {
                            await signUpViewModel.registerUser()
                        }
                    }) {
                        Text("Sign up")
                    }
                    .buttonStyle(MainButtonStyle(isDisabled: !signUpViewModel.isSignUpEnabled))
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                    .frame(maxHeight: .infinity)
                }
                .padding(.top, 32)
            }
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text("Choose how you want to add a photo"), buttons: [
                .default(Text("Camera"), action: {
                    sourceType = .camera
                    showingImagePicker = true
                }),
                .default(Text("Gallery"), action: {
                    sourceType = .photoLibrary
                    showingImagePicker = true
                }),
                .cancel()
            ])
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(sourceType: sourceType, selectedImage: $signUpViewModel.photo,
                        selectedImageName: $signUpViewModel.photoName)
            .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $signUpViewModel.isShowStateView, content: {
            SungUpState(viewModel:SignUpStateViewModel(userRequest: signUpViewModel.userRequest, isSuccess: signUpViewModel.isSuccess, message: signUpViewModel.message))
        })
        .onTapGesture {
            dismissKeyboard()
        }
        .onFocusChange(of: showingImagePicker) {
            signUpViewModel.validatePhoto()
        }
        .onFocusChange(of: isNameFocused) {
            signUpViewModel.validateName()
        }
        .onFocusChange(of: isEmailFocused) {
            signUpViewModel.validateEmail()
        }
        .onFocusChange(of: isPhoneFocused) {
            signUpViewModel.validatePhone()
        }
    }
    
    private func dismissKeyboard() {
        isNameFocused = false
        isEmailFocused = false
        isPhoneFocused = false
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    SignUpView()
}
