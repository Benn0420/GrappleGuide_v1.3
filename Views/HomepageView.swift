//
//  HomepageView.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-03-05.
//

import SwiftUI

struct HomepageView: View {
    @StateObject var Hvc = homepageViewController()
    
    var body: some View {
        GeometryReader { geometry in
            let framewidth = geometry.size.width * 0.9
            let frameheight = geometry.size.height * 0.8
            
            ZStack {
                Image("GrappleGuideBkrnd")
                    .resizable()
                    .cornerRadius(20)
                    .ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 20) {
                        ForEach(Hvc.categories, id: \.self) { category in
                            VStack(alignment: .center, spacing: 10) {
                                Text(category)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundStyle(Color.brown)
                                Divider()
                                    .background(Color.gray)
                                switch category {
                                case "POSITIONS":
                                    ForEach(Hvc.positions, id: \.self) { position in
                                        Button(action: {
                                            Hvc.libcategory(category: position)
                                            Hvc.isTechViewShown.toggle()
                                        }) {
                                            Text(position)
                                                .font(.system(size: 18))
                                                .foregroundStyle(.brown)
                                                .background(.white)
                                        }
                                    }
                                case "TAKEDOWNS":
                                    ForEach(Hvc.takedowns, id: \.self) { takedown in
                                        Button(action: {
                                            Hvc.libcategory(category: takedown)

                                        }) {
                                            Text(takedown)
                                                .font(.system(size: 18))
                                                .foregroundStyle(.brown)
                                                .background(.white)
                                        }
                                    }
                                case "SUBMISSIONS":
                                    ForEach(Hvc.submissions, id: \.self) { submission in
                                        Button(action: {
                                            Hvc.libcategory(category: submission)
                                        }) {
                                            Text(submission)
                                                .font(.system(size: 18))
                                                .foregroundStyle(.brown)
                                                .background(.white)
                                        }
                                    }
                                case "SWEEPS":
                                    ForEach(Hvc.sweeps, id: \.self) { sweep in
                                        Button(action: {
                                            Hvc.libcategory(category: sweep)
                                        }) {
                                            Text(sweep)
                                                .font(.system(size: 18))
                                                .foregroundStyle(.brown)
                                                .background(.white)
                                        }
                                    }
                                default:
                                    EmptyView()
                                }

                            }
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius:20))
                            .shadow(radius: 5)
                        }
                    }
                }
                .frame(width: framewidth, height: frameheight)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.horizontal, 0.05 * geometry.size.width)
                .padding(.vertical, 100)
            }
            if Hvc.isTechViewShown {
                TechView(dismissHandler: {
                    Hvc.isTechViewShown.toggle()
                }, techName: Hvc.selectedChoice, techDescription: Hvc.selectedDescription)
                .frame(width: 0.8 * geometry.size.width, height: 0.9 * geometry.size.height)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.horizontal, 0.1 * geometry.size.width)
                .padding(.vertical, 0.05 * geometry.size.height)
            }
        }
    }
}

#Preview {
    HomepageView()
}
