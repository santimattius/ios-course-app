//
//  ContentView.swift
//  ios-course-app
//
//  Created by Santiago Mattiauda on 20/11/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var courses = [
        Course(name: "iOS Developer", description: "Master the Swift programming language, and create a portfolio of iOS apps for iPhone and iPad to showcase your skills!", image: "ios_dev", free: false, level: .beginner),
        Course(name: "Introduction to TensorFlow Lite", description: "Learn how to deploy deep learning models on mobile and embedded devices with TensorFlow Lite.", image: "intro_tensorflow_lite", free: true, level: .intermediate),
        Course(name: "Intro to iOS App Development with Swift", description: "Take the first step in becoming an iOS Developer by learning about Swift and writing your first app.", image: "intro_ios_app", free: true,  level: .intermediate),
        Course(name: "Introduction to Virtual Reality", description: "Take the first step in becoming an iOS Developer by learning about Swift and writing your first app.", image: "intro_vr", free: true, level: .beginner),
        Course(name: "Objective-C for Swift Developers", description: "Learn the distinguishing language features of Objective-C. Practice Objective-C syntax by writing classes, and writing and calling methods.", image: "objc_for_swift", free: true,  level: .intermediate),
        Course(name: "Core ML: Machine Learning for iOS", description: "Learn how to use Apple's Core ML framework to build iOS apps with intelligent new features.", image: "core_ml_ios", free: true,  level: .intermediate),
        Course(name: "Server-Side Swift", description: "In this course, built in collaboration with IBM and Hashicorp, you'll learn how to use Swift as a server-side language for building end-to-end applications.", image: "server_side_swift", free: true, level: .intermediate),
        Course(name: "How to Make an iOS App", description: "Learn the process of building an app, taking your ideas from drawing board to App Store!", image: "how_make_ios_app", free: true, level: .advanced),
        Course(name: "Data Structures & Algorithms in Swift", description: "Review and practice the skills technical interviewers expect you to know and learn how to explain your Swift solutions.", image: "structures_algotithms_swift", free: true, level: .intermediate),
        Course(name: "iOS Interview Prep", description: "Answer iOS and mobile development interview questions with confidence and poise.", image: "ios_interview_prep", free: true, level: .intermediate)
    ]
        
    @State private var selectedCourse: Course?
    
    @State private var showSettingsView: Bool = false
    
    @EnvironmentObject var settings: SettingsFactory
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach(courses
                    .filter(shouldShowCourse)
                    .sorted(by: self.settings.order.predicateSort())){ course in
                    ZStack{
                                                
                        CourseRoundImageRow(course:course)
                            .contextMenu{
                                
                                Button(action: {
                                    self.setCompleted(item: course)
                                }) {
                                    HStack{
                                        Text(course.completed ? "Incomplete" : "Completed")
                                        Image(systemName: "checkmark.circle")
                                    }
                                }
                                
                                Button(action: {
                                    self.setFavorite(item: course)
                                }) {
                                    HStack{
                                        Text( course.favorite ? "Remove from favorite" : "Add to favorite")
                                        Image(systemName: "heart")
                                    }
                                }
                                
                                Button(action: {
                                    self.delete(item: course)
                                }) {
                                    HStack{
                                        Text("Remove")
                                        Image(systemName: "trash")
                                    }
                                }
                        }
                        .onTapGesture {
                            self.selectedCourse = course
                        }
                        .actionSheet(item: self.$selectedCourse){ course in
                            ActionSheet(title: Text("Indicate your action to take"),
                                        message: nil,
                                        buttons: [
                                            .default(Text( course.favorite ? "Remove from favorite" : "Add to favorite"), action: {
                                                self.setFavorite(item: course)
                                            }),
                                            .default( Text(course.completed ? "Incomplete" : "Completed"), action: {
                                                self.setCompleted(item: course)
                                            }),
                                            .destructive(Text("Remove course"), action: {
                                                self.delete(item: course)
                                            }),
                                            //TODO: colocar aquí más opciones si se desea
                                            .cancel()
                            ])
                        }
                    }
                }.onDelete{ (indexSet) in
                    self.courses.remove(atOffsets: indexSet)
                }
            }
            .navigationBarTitle("Swift courses", displayMode: .automatic)
            .navigationBarItems(trailing:
                Button(action: {
                    self.showSettingsView = true
                }, label: {
                    
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .font(.title)
                        .foregroundColor(.blue)
                })
            )
            .sheet(isPresented: $showSettingsView){
                SettingsView().environmentObject(self.settings)
            }
            
            }
    }
    
    
    private func setFavorite(item course: Course){
        if let idx = self.courses.firstIndex(where: {$0.id == course.id}){
            self.courses[idx].favorite.toggle()
        }
    }
    
    private func setCompleted(item course:Course){
        if let idx = self.courses.firstIndex(where: {$0.id == course.id}){
            self.courses[idx].completed.toggle()
        }
    }
    
    private func delete(item course: Course){
        if let idx = self.courses.firstIndex(where: {$0.id == course.id}){
            self.courses.remove(at: idx)
        }
    }
    
    
    private func shouldShowCourse(course: Course) -> Bool {
        let checkCompleted = (self.settings.showFavoriteOnly && course.completed) || !self.settings.showFavoriteOnly
        let checkFree = (self.settings.showFreeOnly && course.free) || !self.settings.showFreeOnly
        let checkFavorite = (self.settings.showFavoriteOnly && course.favorite) || !self.settings.showFavoriteOnly
        
        return checkCompleted && checkFree && checkFavorite
    }
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SettingsFactory())
    }
}



struct CourseRoundImageRow: View {
    var course : Course
    var body: some View {
        HStack(alignment: .top) {
            Image(course.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Text(course.name)
                    .font(.system(.body, design:.rounded))
                    .bold()
                
                Text(course.description)
                    .font(.system(.subheadline, design: .rounded))
                .bold()
                .foregroundColor(.secondary)
                
                HStack{
                    if course.free{
                        Text("free")
                        .font(.system(.subheadline, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                        .padding(3)
                        .background(RoundedRectangle(cornerRadius: 2))
                        .foregroundColor(.cyan)
                    }
                    Text(course.level.description)
                    .font(.system(.subheadline, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .padding(3)
                    .background(RoundedRectangle(cornerRadius: 2))
                    .foregroundColor(course.level.color)
                    
                    Spacer()
                    
                    Image(systemName: course.favorite ? "heart.fill" : "suit.heart")
                        .foregroundColor(course.favorite ? .red : .gray)
                    Image(systemName: course.completed ? "checkmark.circle.fill" :  "checkmark.circle")
                        .foregroundColor(course.completed ? .green :.gray)
                }
            
            }
        }
    }
}
