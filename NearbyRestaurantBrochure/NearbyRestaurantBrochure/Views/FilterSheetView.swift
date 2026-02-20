import SwiftUI

struct FilterSheetView: View {
    
    @ObservedObject var viewModel: ShopListViewModel
    @State private var selection: Int = 10
    
    init(viewModel: ShopListViewModel) {
        self.viewModel = viewModel
        // 選択されていない時の文字色
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        // 選択時の文字色
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        // 選択時の背景色
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.orange
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 32) {
                
                //MARK: -Slider
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("検索半径")
                            .font(.headline)
                        Spacer()
                        Text("\(viewModel.selectedRange.displayText)")
                            .font(.headline)
                            .foregroundStyle(.orange)
                    }
                    
                    Slider(
                        value: Binding(
                            get: { Double(viewModel.selectedRange.rawValue) },
                            set: { viewModel.selectedRange = SearchRange(rawValue: Int($0)) ?? .km1 }
                        ),
                        in: 1...5,
                        step: 1
                    )
                    .tint(.orange)
                    
                    HStack {
                        ForEach(SearchRange.allCases) { range in
                            Text(range.displayText)
                                .font(.caption2)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                
                //MARK: - acquisitions number
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("取得件数")
                            .font(.headline)
                        Spacer()
                        Text("\(selection)件")
                            .font(.headline)
                            .foregroundStyle(.orange)
                    }
                    
                    Picker("取得件数", selection: $selection) {
                        Text("10件").tag(10)
                        Text("20件").tag(20)
                        Text("30件").tag(30)
                        Text("40件").tag(40)
                        Text("50件").tag(50)
                    }
                    .pickerStyle(.segmented)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
        }
        Spacer()
        //MARK: -　actionButton
        HStack(spacing: 16) {
            Button("リセット") {
                viewModel.selectedRange = .km1
                selection = 10
            }
            .font(.body.bold())
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .foregroundStyle(.orange)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Button("絞り込む") {
                // API再実行はここで
            }
            .font(.body.bold())
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .foregroundStyle(.white)
            .background(Color.orange)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .orange.opacity(0.3), radius: 5, x: 0, y: 3)
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 24)
    }
}

