
import SwiftUI

struct SearchView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject private var searchModel = SearchViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            Image(themeManager.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                     Button { dismiss() } label: {
                         HStack(spacing: 6) {
                             Image(systemName: "chevron.left")
                                 .font(.system(size: 16, weight: .semibold))
                             
                             Text("Home")
                                 .font(.system(size: 16, weight: .medium))
                         }
                         .foregroundColor(themeManager.primaryTextColor)
                         .padding(.horizontal, 12)
                         .padding(.vertical, 8)
                         .background(Color.white.opacity(0.08))
                         .clipShape(Capsule())
                     }


                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)

                        TextField("Search city...", text: $searchModel.searchText)
                            .foregroundColor(themeManager.primaryTextColor)
                            .tint(.blue)
                            .autocorrectionDisabled()
                    

                        if !searchModel.searchText.isEmpty {
                            Button {
                                searchModel.searchText = ""
                                searchModel.results = []
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(themeManager.primaryTextColor)
                            }
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .background(themeManager.cardBackgroundColor)
                    .cornerRadius(14)
                }
                .padding(.horizontal)
                .padding(.top, 60)
                .padding(.bottom, 16)
                SearchContentView(viewModel: searchModel)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .navigationBarHidden(true)
    }

}

#Preview {
    SearchView().environmentObject(ThemeManager())
}
