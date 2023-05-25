//
//  SkillService.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 5/18/23.
//

import Foundation

class SkillService {
    func getSkills() -> [Skills] {
        return [
            Skills(named: "Detection",
                   shortDesc:"From cancer detection to finding drugs and explosives",
                   description: "Exceptional senses of smell from detecting cancer to sniffing suspicious packages at the airport or bedbugs in a local hotel.",
                   imageUrl: "https://daily.jstor.org/wp-content/uploads/2022/03/why_arent_there_more_dogs_at_the_doctors_office_alt_1050x700.jpg"),
            Skills(named: "Guide",
                   shortDesc:"Help the visually impaired by navigating around obstacles",
                   description: "Assistance dogs trained to lead blind or visually impaired people around obstacles. The human does the directing, based on skills acquired through previous mobility training.",
                   imageUrl: "https://cdn.britannica.com/33/148433-050-823658CC/Labrador-retriever-guide-dog.jpg?w=400&h=300&c=crop"),
            Skills(named: "Hearing",
                   shortDesc:"Assist the hard of hearing by alerting to important sounds",
                   description: "Help those with loss of hearing by alerting their handler to important sounds, such as doorbells, smoke alarms, ringing telephones, or alarm clocks",
                   imageUrl:"https://i0.wp.com/limpingchicken.com/wp-content/uploads/2014/10/Screen-shot-2014-10-20-at-13.45.45.png"),
            Skills(named: "Herding",
                   shortDesc:"Work with livestock such as sheep and cattle",
                   description: "Work with various types of livestock, such as sheep and cattle. Help by moving a large number of animals from one location to another.",
                   imageUrl:"https://www.akc.org/wp-content/uploads/2017/10/Australian-Shepherd_Adult_Herding.jpg"),
            Skills(named: "Search & Rescue",
                   shortDesc:"Find missing people after a natural disaster",
                   description: "Trained to find missing people after a natural or man-made disaster. The dogs detect human scent and have been known to find people under water, under snow, and under collapsed buildings.",
                   imageUrl:"https://www.akc.org/wp-content/uploads/2017/11/GettyImages-92279253__1_.jpg"),
            Skills(named: "Therapy",
                   shortDesc:"Provide affection, comfort and support to people",
                   description: "Provide comfort and affection to people in hospice, disaster areas, retirement homes, hospitals, nursing homes, schools, and more!",
                   imageUrl:"https://www.guidedogs.org/wp-content/uploads/2021/08/irwin-therapy-dog.jpg"),
            ]
    }
}
