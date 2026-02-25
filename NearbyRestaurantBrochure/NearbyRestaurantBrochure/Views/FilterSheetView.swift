import SwiftUI

struct FilterSheetView: View {
    
    @ObservedObject var viewModel: ShopListViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var tempRange: SearchRange
    @State private var tempCount: Int
    
    init(viewModel: ShopListViewModel) {
        self.viewModel = viewModel
        _tempRange = State(initialValue: viewModel.selectedRange)
        _tempCount = State(initialValue: viewModel.selectedCount.count)
        
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.orange
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 32) {
                
                // MARK: - Slider
                VStack(alignment: .leading) {
                    HStack {
                        Text("検索半径")
                            .font(.headline)
                        Spacer()
                        Text("\(tempRange.displayText)")
                            .foregroundStyle(.orange)
                    }
                    
                    Slider(
                        value: Binding(
                            get: { Double(tempRange.rawValue) },
                            set: { tempRange = SearchRange(rawValue: Int($0)) ?? .km1 }
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
                
                // MARK: - acquisitions number
                VStack(alignment: .leading) {
                    HStack {
                        Text("表示件数")
                            .font(.headline)
                        Spacer()
                        Text("\(tempCount)件")
                            .foregroundStyle(.orange)
                    }
                    Picker("取得件数", selection: $tempCount) {
                        Text("10").tag(10)
                        Text("20").tag(20)
                        Text("30").tag(30)
                        Text("40").tag(40)
                        Text("50").tag(50)
                        Text("100").tag(100)
                    }
                    .pickerStyle(.segmented)
                    .tint(.orange)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            
            Spacer()
            
            // MARK: - actionButton
            HStack(spacing: 16) {
                Button("リセット") {
                    tempRange = .km1
                    tempCount = 10
                }
                .font(.body.bold())
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .foregroundStyle(.orange)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                Button("絞り込む") {
                    dismiss()
                    viewModel.selectedRange = tempRange
                    viewModel.selectedCount.count = tempCount
                    Task {
                        await viewModel.fetchShops()
                    }
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
}
