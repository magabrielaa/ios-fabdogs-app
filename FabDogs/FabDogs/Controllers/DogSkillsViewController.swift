//
//  DogSkillsViewController.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 5/12/23.
//

import UIKit
import SwiftUI

class DogSkillsViewController: UIViewController {
    
    var skill: Skills!
    var dogService: DogService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the title of the navigation bar
        self.navigationItem.title = "\(skill.name) Dogs"

        self.dogService = DogService()
        
        dogService.getDogs { [weak self] dogs, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching dogs:", error)
                return
            }
            
            guard let dogs = dogs else {
                print("No dogs found.")
                return
            }
            
            let filteredDogs = dogs.filter { $0.ability == self.skill.name }
            let imageUrls = filteredDogs.compactMap { $0.imageUrl }
            let dogSkillsView = DogSkillsView(imageUrls: imageUrls, skillName: skill.name, skillDescription: skill.description, dogs: filteredDogs)

            
            let hostingController = UIHostingController(rootView: dogSkillsView)
            self.addChild(hostingController)
            
            self.view.addSubview(hostingController.view)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                hostingController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                hostingController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
            
            hostingController.didMove(toParent: self)
        }
    }
}

struct DogSkillsView: View {
    var imageUrls: [String]
    var skillName: String
    var skillDescription: String
    var dogs: [Dog]
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    @State private var currentIndex = 0
    
    var numImages: Int {
        imageUrls.count
    }
    
    func previousImage() {
        withAnimation {
            currentIndex = currentIndex > 0 ? currentIndex - 1 : numImages - 1
        }
    }
    
    func nextImage() {
        withAnimation {
            currentIndex = currentIndex < numImages - 1 ? currentIndex + 1 : 0
        }
    }
    
    var controls: some View {
        HStack {
            Button {
                previousImage()
            } label: {
                Image(systemName: "chevron.left")
                    .scaleEffect(2.5)
            }
            Spacer()
                .frame(width: 100)
            Button {
                nextImage()
            } label: {
                Image(systemName: "chevron.right")
                    .scaleEffect(2.5)
            }
        }
        .accentColor(.teal)
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                
                Text(dogs[currentIndex].name)
                    .font(.system(size: 36))
                    .bold()
                    .foregroundColor(.teal)
                    .padding()

                TabView(selection: $currentIndex) {
                    ForEach(0..<imageUrls.count) { num in
                        RemoteImage(urlString: imageUrls[num])
                            .aspectRatio(contentMode: .fit)
                            .tag(num)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding()
                .frame(width: proxy.size.width, height: proxy.size.height / 2)
                .onAppear {
                    currentIndex = 0 // Set the initial index
                }
                .onReceive(timer) { _ in
                    nextImage()
                }
                
                controls
                    
                Text(skillDescription)
                    .font(.system(size: 22))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil) // Allow unlimited lines for long text
                    .padding(.top, 10) // Add 10 points of padding before the text
                    .padding()
            }
        }
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = .systemTeal
            UIPageControl.appearance().pageIndicatorTintColor = .lightGray
        }
    }
}

struct RemoteImage: View {
    let urlString: String
    
    var body: some View {
        if let url = URL(string: urlString), let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image(systemName: "0")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
