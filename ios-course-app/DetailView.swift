//
//  DetailView.swift
//  ios-course-app
//
//  Created by Santiago Mattiauda on 20/11/21.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var course: Course
    
    var body: some View {
        ScrollView{
            VStack{
                Image(course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //.frame(height:300)
                    //.clipped()
                
                Text(course.name)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
                    .frame(width:300)
                    .lineLimit(3)
                
                Spacer()
            }
        }
        //.navigationBarTitle("", displayMode: .inline)
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
        Button(action: {
            //Navegar a la pantalla previa
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "arrow.left.circle.fill")
                .font(.title)
                .foregroundColor(.white)
        })
        )
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let course = Course(name: "iOS Developer", description: "Master the Swift programming language, and create a portfolio of iOS apps for iPhone and iPad to showcase your skills!", image: "", free: false)
        DetailView(course: course)
    }
}
