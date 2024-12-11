//
//  InputParametersListView.swift
//  QuickPrompt
//
//  Created by Hans Poreda on 08.12.24.
//

import SwiftUI

struct InputParametersListView: View {
    @Binding var inputParameters: [InputParameter]
    var body: some View {
        VStack(alignment: .leading) {
            ForEach($inputParameters, id: \.id) { $inputParameter in
                VStack {
                    HStack {
                        Text("Parametername:")
                            .font(.headline)
                                  
                        TextField("Name", text: $inputParameter.parameterName)
                            .multilineTextAlignment(.trailing)
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
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .padding(.horizontal)
                .font(.body)
            }
            
            Button {
                withAnimation(.smooth) {
                    inputParameters.append(InputParameter(parameterName: "", parameterDescription: "", parameterDefaultValue: "", parameterValue: ""))
                }
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .padding(8)
                    .frame(width: 25, height: 25)
                    .background(.backgroundGrey)
                    .cornerRadius(8)
                    .padding(.leading)
                    .padding(.bottom)
            }
            .buttonStyle(.plain)

        }
    }
}

#Preview {
    InputParametersListView(inputParameters: .constant([
        InputParameter(parameterName: "", parameterDescription: "", parameterDefaultValue: "", parameterValue: "")
    ]))
}
