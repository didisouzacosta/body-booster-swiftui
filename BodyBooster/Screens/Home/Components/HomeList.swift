//
//  HomeList.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import SwiftUI

struct HomeList: View {
    
    typealias Action = (Training) -> Void
    
    let trainings: DataState<[Training], Error>
    let action: Action
    
    var body: some View {
        List {
            Section {
                VStack {
                    WelcomeCard { phrase in }
                    WaterCard { print("Beber água") }
                }
            }
            .minimalSection()
            
            DataStateView(state: trainings) { trainings in
                Group {
                    let sections = factorySections(from: trainings)
                    
                    ForEach(sections) { section in
                        Section(content: {
                            ForEach(section.trainings) { training in
                                TouchableButton(content: {
                                    HomeListItem(training: training)
                                }) {
                                    action(training)
                                }
                            }
                        }, header: {
                            Text(section.title)
                                .font(.system(size: 16, weight: .bold))
                                .padding(.horizontal)
                        })
                        .minimalSection()
                    }
                }
            }
        }
        .minimalList()
    }
    
    // MARK: - Private Methods
    
    private func factorySections(from trainings: [Training]) -> [SectionData] {
        let weekday = Date().weekDay()
        let trainingsForToday = trainings.filter { $0.weekDays.contains(weekday) }
        let otherTrainings = trainings.filter { !$0.weekDays.contains(weekday) }
        
        return [
            SectionData(
                title: "Treinos de hoje",
                trainings: trainingsForToday
            ),
            SectionData(
                title: "Outros treinos",
                trainings: otherTrainings
            )
        ].filter { !$0.trainings.isEmpty }
    }
}

extension HomeList {
    
    struct SectionData: Identifiable {
        let id = UUID()
        let title: String
        let trainings: [Training]
    }
    
}

#Preview("State: Loaded") {
    HomeList(
        trainings: .loaded(fakeTrainings),
        action: { _ in }
    )
}

#Preview("State: Loading") {
    HomeList(
        trainings: .loading,
        action: { _ in }
    )
}
