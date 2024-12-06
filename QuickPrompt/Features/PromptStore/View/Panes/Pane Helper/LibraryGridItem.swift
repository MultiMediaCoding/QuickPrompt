//
//  LiberaryGridItem.swift
//  QuickPrompt
//
//  Created by Lovis Steinmayer on 06.12.24.
//

import SwiftUI

struct LibraryGridItem: View {
    
    @StateObject var menuBarViewModel = MenuBarViewModel()
    @State private var isHovered: Bool = false
    @State private var isHoverTimerActive: Bool = false
    
    let prompt: Prompt
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Rectangle()
                .fill(.quinary)
                .frame(height: 150)
                .overlay(
                    VStack(alignment: .leading, spacing: 5) {
                        Image(systemName: promptSymbols[prompt.category.rawValue] ?? "text.alignleft")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.accentColor)
                            .padding(.bottom, 7)
                        
                        
                        Text(prompt.category.rawValue)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 3)
                            .background(Color.accentColor.opacity(0.1))
                            .foregroundStyle(Color.accentColor)
                            .clipShape(Capsule())
                            .font(.caption)
                        
                        Text(prompt.title)
                            .foregroundColor(.primary)
                            .font(.headline)
                        
                        Text(prompt.text)
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                    .padding()
                )
                .cornerRadius(10)
            
            if isHovered {
                Button {
                    menuBarViewModel.copyPrompt(prompt)
                } label: {
                    GroupedBox {
                        Image(systemName: menuBarViewModel.copiedPrompt == prompt ? "rectangle.on.rectangle.fill" : "rectangle.on.rectangle")
                            .font(.subheadline)
                            .contentTransition(.symbolEffect(.replace))
                            .padding(-2)
                    }
                    .padding(7)
                }
                .buttonStyle(.plain)
            }
        }
        .onHover { hovering in
            if hovering {
                startHoverTimer()
            } else {
                stopHoverTimer()
            }
        }
    }
    
    private func startHoverTimer() {
        stopHoverTimer()
        isHoverTimerActive = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if isHoverTimerActive {
                withAnimation(.smooth) {
                    isHovered = true
                }
            }
        }
    }
    
    private func stopHoverTimer() {
        isHoverTimerActive = false
        withAnimation(.smooth) {
            isHovered = false
        }
    }
}
