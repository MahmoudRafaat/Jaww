
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
                HStack(spacing: 12) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(themeManager.primaryTextColor)
                            .padding(10)
                            .background(Color.white.opacity(0.08))
                            .clipShape(Circle())
                    }

                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)

                        TextField("Search city...", text: $searchModel.searchText)
                            .foregroundColor(.white)
                            .tint(.blue)
                            .autocorrectionDisabled()
                    

                        if !searchModel.searchText.isEmpty {
                            Button {
                                searchModel.searchText = ""
                                searchModel.results = []
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .background(Color(red: 0.12, green: 0.14, blue: 0.17))
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
