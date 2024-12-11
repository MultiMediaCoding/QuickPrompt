import SwiftUI

struct InputParametersListView: View {
    @Binding var inputParameters: [InputParameter]
    @FocusState private var focusedField: UUID?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach($inputParameters, id: \.id) { $inputParameter in
                    VStack {
                        HStack {
                            Text("Parametername:")
                                .font(.headline)
                            
                            TextField("Name", text: $inputParameter.parameterName)
                                .multilineTextAlignment(.trailing)
                                .focused($focusedField, equals: inputParameter.id)
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Beschreibung im Kontext:")
                            
                            TextField("Beschreibung", text: $inputParameter.parameterDescription)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Standartwert:")
                            
                            TextField("Etwas passendes ;)", text: $inputParameter.parameterDefaultValue)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    .textFieldStyle(.plain)
                    .padding()
                    .background(Color.backgroundGrey)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .font(.body)
                }
                
                Button {
                    withAnimation(.smooth) {
                        let newParameter = InputParameter(parameterName: "", parameterDescription: "", parameterDefaultValue: "", parameterValue: "")
                        inputParameters.append(newParameter)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            focusedField = newParameter.id // Focus on the newly added field
                        }
                    }
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .padding(8)
                        .frame(width: 25, height: 25)
                        .background(Color.backgroundGrey)
                        .cornerRadius(8)
                        .padding(.leading)
                        .padding(.bottom)
                }
                .buttonStyle(.plain)
            }
            .onAppear {
                if inputParameters.isEmpty {
                    let initialParameter = InputParameter(parameterName: "", parameterDescription: "", parameterDefaultValue: "", parameterValue: "")
                    inputParameters.append(initialParameter)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        focusedField = initialParameter.id // Focus on the initial field
                    }
                }
            }
        }
    }
}

#Preview {
    InputParametersListView(inputParameters: .constant([
        InputParameter(parameterName: "", parameterDescription: "", parameterDefaultValue: "", parameterValue: "")
    ]))
}
