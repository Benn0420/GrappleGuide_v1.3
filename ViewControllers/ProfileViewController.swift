//
//  ProfileViewController.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-03-07.
//

import Foundation
import SwiftUI
import Firebase
import UIKit

class profileViewController: ObservableObject {
    
    @Published var realname: String = ""
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var birthDate: String = ""
    @Published var trainingAge: String = ""
    @Published var profileImage: UIImage? = nil
    @Published var backgroundColor = Color.white
    @Published var UIbackgroundColor = UIColor.white
    
    private let db = Firestore.firestore()
    
    init() {
        fetchUserData()
    }
    
    func fetchUserData() {
        print("Initiating fetching of user data...")
        if let user = Auth.auth().currentUser {
            print("Fetching user data for user: \(user.uid)")
            let userRef = db.collection("users").document(user.uid)
            userRef.getDocument { document, error in
                print("Getting document..")
                if let error = error {
                    print("Error fetching user document: \(error.localizedDescription)")
                    return
                }
                
                if let document = document, document.exists {
                    print("Fetched document: \(document)")
                    let userData = document.data()
                    print("User data fetched successfully: \(String(describing: userData))")
                    
                    if let realnameData = userData?["realName"],
                       let realname  = realnameData as? String {
                        print("Realname Data Type: ", type(of: realnameData))
                        print("Realname Value: ", realname)
                        self.realname = realname
                    } else {
                        print("Failed to retrieve real name data.")
                    }

                    if let usernameData = userData?["displayName"],
                    let username = usernameData as? String {
                        print("Username Data Type:", type(of: usernameData))
                        print("Username Value:", username)
                        self.username = username
                    } else {
                        print("Failed to retrieve username data.")
                    }

                    if let emailData = userData?["email"],
                    let email = emailData as? String {
                        print("Email Data Type:", type(of: emailData))
                        print("Email Value:", email)
                        self.email = email
                    } else {
                        print("Failed to retrieve email data.")
                    }

                    if let birthDateTimestampData = userData?["birthDate"],
                    let birthDateTimestamp = birthDateTimestampData as? Timestamp {
                        print("Birth Date Timestamp Data Type:", type(of: birthDateTimestampData))
                        print("Birth Date Timestamp Value:", birthDateTimestamp)
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateStyle = .medium
                        dateFormatter.timeStyle = .none
                        let formattedBirthDate = dateFormatter.string(from: birthDateTimestamp.dateValue())
                        print("Formatted birthdate: ", formattedBirthDate)
                        self.birthDate = formattedBirthDate
                    } else {
                        print("Failed to retrieve birth date timestamp data.")
                    }

                    if let trainingAgeData = userData?["experience"],
                    let trainingAge = trainingAgeData as? String {
                        print("Training Age Data Type:", type(of: trainingAgeData))
                        print("Training Age Value:", trainingAge)
                        self.trainingAge = trainingAge
                    } else {
                        print("Failed to retrieve training age data.")
                    }

                    if let backgroundColorData = userData?["favouriteColor"],
                    let backgroundColor = backgroundColorData as? String {
                        print("Background Color Data Type:", type(of: backgroundColorData))
                        print("Background Color Value:", backgroundColor)
                        self.UIbackgroundColor = UIColor(hex: backgroundColor) ?? .white
                        self.backgroundColor = self.UIbackgroundColor.toColor()
                    } else {
                        print("Failed to retrieve background color data.")
                    }

                    if let imageDataData = userData?["profileImageData"] as? Data {
                        print("Image Data Type: ", type(of: imageDataData))
                        print("Image Data Size: ", imageDataData.count)
                        
                        if let profileImage = UIImage(data: imageDataData) {
                            print("Successfully created profile image")
                            self.profileImage = profileImage
                        } else {
                            print("Failed to create profile image from data")
                        }
                    } else if let imageDataString = userData?["profileImageData"] as? String {
                        print("Image Data String Value:", imageDataString)

                        if let imageData = Data(base64Encoded: imageDataString) {
                            print("Successfully converted image data.")
                            if let profileImage = UIImage(data: imageData) {
                                print("Successfully created profile image.")
                                self.profileImage = profileImage
                            } else {
                                print("Failed to create profile image from data.")
                            }
                        } else {
                            print("Failed to convert base64 image data.")
                        }
                    } else {
                        print("Failed to retrieve profile image data.")
                    }
                } else {
                    print("User document does not exist")
                }
            }
        }
    }
}
