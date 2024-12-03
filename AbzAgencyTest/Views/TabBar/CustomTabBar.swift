import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    private let selectedColor = AppColors.secondary
    private let unselectedColor = AppColors.black60
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .frame(height: 1)
                .background(AppColors.tabbarLineColor)
            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Spacer()
                    HStack {
                        Image(tab.iconName)
                        Text(tab.title)
                            .font(AppTypography.body1(wight: .bold))
                            
                    }
                    .foregroundColor(selectedTab == tab ? selectedColor : unselectedColor)
                    .onTapGesture {
                        withAnimation {
                            selectedTab = tab
                        }
                    }
                    Spacer()
                }
            }
            .padding(.vertical, 16)
            .background(AppColors.tabbarColor)
        }
        
    }
}
