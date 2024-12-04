import SwiftUI

struct UserListView: View {
    @EnvironmentObject private var usersViewModel: UsersViewModel

    var body: some View {
        VStack (spacing: 0) {
                CustomTopBar()
            if usersViewModel.users.isEmpty && !usersViewModel.isLoading {
                UserEmptyView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
            ScrollView {
                    LazyVStack {
                        // Show user list
                        ForEach(usersViewModel.users, id: \.id) { user in
                            UserRow(user: user)
                                .padding(.top, 24)
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onAppear {
                                    Task {
                                        // Проверяем, нужно ли загрузить следующую страницу
                                        if let lastUser = usersViewModel.users.last,
                                           usersViewModel.hasMoreUsers,
                                           user.id == lastUser.id,
                                           !usersViewModel.isLoading {
                                            await usersViewModel.loadUsers()
                                        }
                                    }
                                }
                        }

                        // Loading indicator
                        if usersViewModel.isLoading {
                            ProgressView()
                                .padding(.bottom, 24)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
        .task {
            // Load first page
            if usersViewModel.users.isEmpty && !usersViewModel.isLoading && usersViewModel.hasMoreUsers {
                await usersViewModel.loadUsers()
            }
        }
    }
}

struct UserRow: View {
    let user: User

    var body: some View {
        HStack (alignment: .top ,spacing: 16) {
            if let url = URL(string: user.photo) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image(.emptyUser)
                    .resizable()
                    .scaledToFit()
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            }
            
            VStack (alignment: .leading, spacing: 8) {
                VStack (alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(AppTypography.body2())
                        .foregroundStyle(AppColors.black87)
                    Text(user.position)
                        .font(AppTypography.body3())
                        .foregroundStyle(AppColors.black60)
                }
                VStack (alignment: .leading) {
                    Text(user.email)
                        .font(AppTypography.body3())
                        .foregroundStyle(AppColors.black87)
                    Text(user.phone)
                        .font(AppTypography.body3())
                        .foregroundStyle(AppColors.black87)
                }
                .padding(.bottom, 24)
                Divider()
                    .background(AppColors.line)
                    .frame(height: 1)
            }
        }
    }
}

#Preview {
    UserListView()
}
