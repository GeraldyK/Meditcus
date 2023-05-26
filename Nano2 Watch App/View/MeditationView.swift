//
//  MeditationView.swift
//  Nano2 Watch App
//
//  Created by Geraldy Kumara on 20/05/23.
//

import SwiftUI
import HealthKit

struct MeditationView: View {
    
    private var healthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")
    
    @State private var startTime: Date?
    @State private var elapsedTime: TimeInterval = 0.0
    @State private var value: Int = 0
    @State var isTrack: Bool = false
    @State private var pulse: CGFloat = 0.0
    
    var body: some View {
        VStack(alignment: .center){
            ZStack{
                Circle()
                    .fill(ringColor())
                    .frame(width: 105, height: 105)
                VStack{
                    Text("\(value)")
                        .font(.system(size: 36, weight: .bold))
                        .onChange(of: value) { newValue in
                            if value >= 90 {
                                playSound(sound: "AudioNano2", type: "wav")
                            }
                        }
                    Text("BPM")
                        .font(.system(size: 14, weight: .semibold))
                }
            }
            
            Text(elapsedTime.asTimeString())
                .font(.system(size: 16))
                .padding([.top, .bottom], 5)
            
            if !isTrack {
                Button{
                    startTimer()
                } label: {
                    ButtonView(title: "Track", width: 155)
                }
                .frame(width: 155, height: 30)
                .cornerRadius(8)
                .padding(.bottom, -20)
            } else {
                Button{
                    resetTimer()
                } label: {
                    ButtonView(title: "Reset", width: 155)
                }
                .frame(width: 155, height: 30)
                .cornerRadius(8)
                .padding(.bottom, -20)
            }
            Spacer()
        }
        .navigationTitle("Meditcus")
        .padding()
        .onAppear(perform: start)
        
    }
    
    func start() {
        autorizeHealthKit()
        startHeartRateQuery(quantityTypeIdentifier: .heartRate)
    }
    
    func autorizeHealthKit() {
        let healthKitTypes: Set = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
        
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
    }
    
    private func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
            query, samples, deletedObjects, queryAnchor, error in
            
            guard let samples = samples as? [HKQuantitySample] else {
                return
            }
            
            self.process(samples, type: quantityTypeIdentifier)
            
        }
        
        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        
        query.updateHandler = updateHandler
        
        healthStore.execute(query)
    }
    
    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
        var lastHeartRate = 0.0
        
        for sample in samples {
            if type == .heartRate {
                lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
            }
            
            self.value = Int(lastHeartRate)
        }
    }
    
    func ringColor() -> Color {
        switch value {
        case 0 ..< 84:
            return Color("GreenCircle")
        case 84 ..< 90:
            return Color("YellowCircle")
        default:
            return Color("RedCircle")
        }
    }
    
    func startTimer() {
        startTime = Date()
        isTrack = true
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if let startTime = startTime {
                elapsedTime = Date().timeIntervalSince(startTime)
            }
        }
    }
    
    func resetTimer() {
        startTime = nil
        elapsedTime = 0.0
        isTrack = false
    }
}

extension TimeInterval {
    func asTimeString() -> String {
        let minutes = (Int(self) % 3600) / 60
        let seconds = Int(self) % 60
        let hours = Int(self) / 3600
        
        return String(format: "%02d : %02d : %02d", hours, minutes, seconds)
    }
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView()
    }
}
