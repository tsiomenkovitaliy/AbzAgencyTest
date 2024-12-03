import PhotosUI
import SwiftUI

struct SignUpView: View {
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var showingImagePicker = false
    @State private var showActionSheet = false
    
    @FocusState private var isNameFocused: Bool
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPhoneFocused: Bool
    
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            CustomTopBar(method: .post)
            ScrollView {
                VStack (spacing: 24) {
                    VStack(spacing: 12) {
                        GoogleStyleTextField(text: $viewModel.name,
                                             errorText: $viewModel.nameError,
                                             placeholderText: "Your name")
                            .focused($isNameFocused)
                        
                        GoogleStyleTextField(text: $viewModel.email,
                                             errorText: $viewModel.emailError,
                                             placeholderText: "Email")
                            .focused($isEmailFocused)
                            .keyboardType(.emailAddress)
                        
                        GoogleStyleTextField(text: $viewModel.phone,
                                             errorText: $viewModel.phoneError,
                                             supportText: "+38 (XXX) XXX - XX - XX",
                                             placeholderText: "Phone")
                            .focused($isPhoneFocused)
                            .keyboardType(.phonePad)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Select your position")
                            .font(AppTypography.body1())
                        
                        ForEach(viewModel.positions, id: \.id) { position in
                            HStack {
                                Circle()
                                    .strokeBorder(viewModel.selectedPosition?.id == position.id ? AppColors.secondary : AppColors.borderColor, lineWidth: viewModel.selectedPosition?.id == position.id ? 4 : 1)
                                    .frame(width: 14, height: 14)
                                
                                Text(position.name)
                                    .font(AppTypography.body2())
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 12)
                                
                            }
                            .padding(.horizontal)
                            .onTapGesture {
                                viewModel.selectedPosition = position
                                dismissKeyboard()
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Choose photo view
                    PhotoUploadView(isPhotoUploaded: $viewModel.isPhotoUploaded,
                                    showActionSheet: $showActionSheet,
                                    errorMessage: $viewModel.photoError,
                                    imageName: $viewModel.photoName,
                                    dismissKeyboard: dismissKeyboard)
                    
                    Button(action: {
                        dismissKeyboard()
                        Task {
                            await viewModel.registerUser()
                        }
                    }) {
                        Text("Sign up")
                    }
                    .buttonStyle(MainButtonStyle(isDisabled: !viewModel.isSignUpEnabled))
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
            ImagePicker(sourceType: sourceType, selectedImage: $viewModel.photo,
                        selectedImageName: $viewModel.photoName)
            .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $viewModel.isShowStateView, content: {
            SungUpState(viewModel:SignUpStateViewModel(userRequest: viewModel.userRequest, isSuccess: viewModel.isSuccess, message: viewModel.message))
        })
        .onTapGesture {
            dismissKeyboard()
        }
        .onFocusChange(of: showingImagePicker) {
            viewModel.validatePhoto()
        }
        .onFocusChange(of: isNameFocused) {
            viewModel.validateName()
        }
        .onFocusChange(of: isEmailFocused) {
            viewModel.validateEmail()
        }
        .onFocusChange(of: isPhoneFocused) {
            viewModel.validatePhone()
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
