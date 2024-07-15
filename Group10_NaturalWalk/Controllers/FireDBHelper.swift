//
//  FireDBHelper.swift
//  Group7_NaturalWalk
//
//  Created by Darksun on 2024-07-07.
//
import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    
    @Published var sessionList = [Session]()
    @Published var purchaseList = [PurchaseTicket]()
    @Published var favoriteList = [Session]()
    @Published var userList = [UserProfile]()
    
    private let COLLECTION_NAME : String = "UsersData"
    private let COLLECTION_SESSIONS : String = "WalkSessions"
    private let FAVORITE_SESSIONS : String = "Favorite"
    private let PURCHASE_SESSIONS : String = "Purchase"
    private let USER_SESSIONS : String = "userdetails"
    private let SESSION_COLLECTION_NAME : String = "Sessions"
    private let FIELD_NAME : String = "sessionname"
    private let FIELD_DESCRIPTION : String = "description"
    private let FIELD_RATING : String = "rating"
    private let FIELD_PRICE : String = "price"
    private let FIELD_HOST : String = "host"
    private let FIELD_PHOTOS : String = "isFiction"
    private let FIELD_MOBILE : String = "mobileno"
    private let FIELD_FAVOURITE : String = "isFavourite"
    
    private  let initialSessions = [
        Session(name: "Forest Serenity Stroll", description: "Take a leisurely journey through the lush greenery of the forest, where towering trees sway gently in the breeze and birdsongs fill the air. As you walk along moss-covered paths, dappled sunlight filters through the canopy above, creating a magical atmosphere.", rating: 4, host: "City Tours Ltd.", price: 60.0, photos: ["Session-1(Img-1)", "Session-1(Img-2)","Session-1(Img-3)"], mobileNumber: 5878946521, isFavorite: false, parkLocation: "High Park"),
        
        Session(name: "Meadow Marvel Wander", description: "Meander through golden meadows dotted with wildflowers, where butterflies dance on the breeze and the sun's warm embrace illuminates the serene landscape. Feel the soft grass beneath your feet as you follow winding paths through fields of green, surrounded by the sights and sounds of nature in full bloom.", rating: 4, host: "Museum Inc.", price: 45.0, photos: ["Session-2(Img-1)", "Session-2(Img-2)","Session-2(Img-3)"], mobileNumber: 9148757412, isFavorite: false, parkLocation: "Rouge National Urban Park"),
        
        Session(name: "Mountain Majesty Trek", description: "Ascend to the heights of majestic mountains, where panoramic vistas await at every turn. Feel the crunch of gravel beneath your boots as you hike along winding trails, surrounded by towering peaks and rugged terrain. Pause to catch your breath and take in the breathtaking scenery stretching out before you, from snow-capped summits to lush alpine meadows.", rating: 4, host: "Forest Footsteps", price: 53.0, photos: ["Session-3(Img-1)", "Session-3(Img-2)","Session-3(Img-3)"], mobileNumber: 8517856321, isFavorite: false, parkLocation: "Don Valley Brick Works Park"),
        
        Session(name: "Valley Vista Venture", description: "Explore the valleys and foothills surrounding towering mountain peaks, where lush forests and rolling meadows offer a stark contrast to the rugged terrain above. Wander along peaceful pathways that wind through picturesque valleys, framed by towering cliffs and craggy rock formations.", rating: 4, host: "Harbor Cruises Inc.", price: 45.0, photos: ["Session-4(Img-1)", "Session-4(Img-2)","Session-4(Img-3)"], mobileNumber: 6417524518, isFavorite: false, parkLocation: "Tommy Thompson Park"),
        
        Session(name: "Summit Sunrise Expedition", description: "Rise with the dawn and embark on an early morning expedition to witness the sun's first light as it bathes the mountain peaks in a golden glow. Ascend through predawn darkness, guided by the soft glow of your headlamp and the anticipation of the spectacle to come. Reach the summit just as the first rays of sunlight crest the horizon, illuminating the landscape in a breathtaking display of color and light.", rating: 4, host: "Art Adventures", price: 35.0, photos: ["Session-5(Img-1)", "Session-5(Img-2)","Session-5(Img-3)"], mobileNumber: 4569870912, isFavorite: false, parkLocation: "Humber Bay Park"),
        
        Session(name: "Alpine Adventure Ascent", description: "Embark on an alpine adventure as you ascend towards towering peaks and jagged ridgelines. Traverse rocky terrain and meandering trails, surrounded by the crisp mountain air and panoramic views of snow-capped summits. Along the way, encounter hardy alpine flora and perhaps even glimpse elusive mountain wildlife.", rating: 5, host: "Wilderness Wanderers", price: 95.0, photos: ["Session-6(Img-1)", "Session-6(Img-2)","Session-6(Img-3)"], mobileNumber: 4587529631, isFavorite: false, parkLocation: "Sunnybrook Park"),
        
        Session(name: "Peak Pursuit Pathway", description: "Set your sights on the summit as you follow a challenging pathway leading to the pinnacle of a majestic mountain peak. Ascend through forests of pine and fir, catching glimpses of distant valleys below. Pause to rest at alpine lakes and meadows ablaze with wildflowers, drawing inspiration from the breathtaking scenery that surrounds you.", rating: 4, host: "Nature's Rhythm Ramble", price: 87.0, photos: ["Session-7(Img-1)", "Session-7(Img-2)","Session-7(Img-3)"], mobileNumber: 6508729876, isFavorite: false, parkLocation: "Cedarvale Ravine"),
        
        Session(name: "Mountain Meditation Meander", description: "Embark on a contemplative journey through the mountains, where the serene beauty of the landscape becomes a backdrop for inner reflection and mindfulness. Follow gentle trails that wind through tranquil forests and meadows, pausing along the way to meditate amidst the natural splendor.", rating: 4, host: "Woodland Whispers Walk", price: 62.0, photos: ["Session-8(Img-1)", "Session-8(Img-2)","Session-8(Img-3)"], mobileNumber: 3528747841 , isFavorite: false, parkLocation: "Crothers Woods"),
        
        
        Session(name: "Alpenglow Evening Excursion", description: "Set out on a magical evening hike to witness the ethereal beauty of alpenglow painting the mountain peaks in hues of pink and gold. As the sun begins to dip below the horizon, follow a winding trail through alpine forests and meadows, pausing to watch the sky ignite with color. Feel a sense of awe and wonder as the last rays of sunlight kiss the snow-capped summits, casting a warm glow that seems to illuminate the entire landscape.", rating: 4, host: "Wild Wonders Walkabout", price: 70.0, photos: ["Session-9(Img-1)", "Session-9(Img-2)","Session-9(Img-3)"], mobileNumber: 7899846982 , isFavorite: false, parkLocation: "Glen Stewart Ravine"),
        
        Session(  name: "Ridge Run Adventure", description: "Set out on a captivating adventure across hilly terrain, following the course of gushing waterfalls that sculpt the topography. Enjoy the tranquil sounds of water cascading over rocky ledges as you meander along paths that lead you across gushing streams and misty spray. Take a moment to appreciate the strength and splendour of every waterfall while also enjoying the cold mist that caresses your skin and the revitalizing energy it imparts to your soul.", rating: 4, host: "Scenic Serenity Stroll", price: 55.0, photos: ["Session-10(Img-1)", "Session-10(Img-2)","Session-10(Img-3)"], mobileNumber: 6488959852 , isFavorite: false, parkLocation: "Morningside Park")
        // Add more initial sessions here
        
    ]
    
    // singleton instance
    static var shared : FireDBHelper?
    private let db : Firestore
    
    init(db : Firestore){
        self.db = db
        insertSessionsList()
        getAllFavSession()
        
    }
    
    static func getInstance() -> FireDBHelper{
        if (shared == nil){
            shared = FireDBHelper(db : Firestore.firestore())
        }
        return shared!
    }
    
    func insertSessionsList() {
        // Step 1: Delete all existing documents
        self.db.collection(SESSION_COLLECTION_NAME).getDocuments { [weak self] (snapshot, error) in
            guard let self = self else { return }
            
            if let error = error {
                print(#function, "Error fetching documents: \(error)")
                return
            }
            
            guard let snapshot = snapshot else {
                print(#function, "No snapshot received")
                return
            }
            
            // Delete all existing documents
            for document in snapshot.documents {
                document.reference.delete { error in
                    if let error = error {
                        print(#function, "Error deleting document: \(error)")
                    }
                }
            }
            for session in self.initialSessions {
                do {
                    try self.db.collection(self.SESSION_COLLECTION_NAME)
                        .addDocument(from: session)
                } catch let error {
                    print(#function, "Unable to insert document to firestore: \(error)")
                }
            }
            print(#function, "Finished inserting new sessions")
            FireDBHelper.getInstance().getAllSession()
        }
    }
    
    func initializeFavoriteList() {
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        print("TEST " ,loggedInUserEmail )
        if (loggedInUserEmail.isEmpty){
            print(#function, "No logged in user")
        }else{
            
            self.db.collection(COLLECTION_NAME)
                .document(loggedInUserEmail)
                .collection(FAVORITE_SESSIONS).getDocuments { [weak self] (querySnapshot, error) in
                    guard let self = self else { return }
                    
                    if let error = error {
                        print("Error getting favorites: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let documents = querySnapshot?.documents else {
                        print("No favorites found")
                        return
                    }
                    
                    let fetchedFavorites = documents.compactMap { document -> Session? in
                        do {
                            var session = try document.data(as: Session.self)
                            session.id = document.documentID // Ensure the id is set
                            return session
                        } catch {
                            print("Error decoding session: \(error.localizedDescription)")
                            return nil
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.favoriteList = fetchedFavorites
                        print("Fetched \(self.favoriteList.count) favorites")
                    }
                }
        }
    }

    private func insertNewSessions() {
        for session in self.initialSessions {
            do {
                try self.db.collection(self.SESSION_COLLECTION_NAME)
                    .addDocument(from: session)
            } catch let error {
                print(#function, "Unable to insert document to firestore: \(error)")
            }
        }
        print(#function, "Finished inserting new sessions")
    }
    
    func fetchSessionName(name : String , completion: @escaping ([String]) -> Void) {
        let db = Firestore.firestore()
       
        db.collection(SESSION_COLLECTION_NAME).whereField("name", isEqualTo: name).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            var names = [String]()
                  for document in snapshot.documents {
                      if let name = document.get("name") as? String {
                          names.append(name)
                      }
                  }
            print("names    ", names)
            completion(names)
        }
    }
    
    func fetchUserData(name: String, completion: @escaping ([[String: Any]]) -> Void) {
        let db = Firestore.firestore()
       
        db.collection(SESSION_COLLECTION_NAME).whereField("name", isEqualTo: name).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            
            let documents = snapshot.documents.map { $0.data() }
            completion(documents)
        }
    }
    
    func deleteFav(parkingDelete: Session) {
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        if loggedInUserEmail.isEmpty {
            print(#function, "No logged in user")
            return
        }
        
        guard let documentId = parkingDelete.id else {
            print(#function, "Parking record ID is nil")
            return
        }
        
        try self.db.collection(COLLECTION_NAME)
            .document(loggedInUserEmail)
            .collection(FAVORITE_SESSIONS)
            .document(documentId)
            .delete { error in
                if let err = error {
                    print(#function, "Unable to delete document: \(err)")
                } else {
                    print(#function, "Successfully deleted document: \(documentId)")
                    // Remove the deleted record from the local array
                    if let index = self.favoriteList.firstIndex(where: { $0.id == documentId }) {
                        self.favoriteList.remove(at: index)
                    }
                }
            }
    }

    func insertUser(user : UserProfile){
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        print("TEST " ,loggedInUserEmail )
        if (loggedInUserEmail.isEmpty){
            print(#function, "No logged in user")
        }else{
                
            
                do {
                    try self.db.collection(COLLECTION_NAME)
                        .document(loggedInUserEmail)
                        .collection(USER_SESSIONS)
                        .addDocument(from: user)
                }
                catch let error{
                    print(#function, "Unable to insert document to firestore : \(error)")
                    
                }
                
            }
        getAllUserList()
            
        
    }
    
    func getAllUserList() {
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
    
        if loggedInUserEmail.isEmpty {
            print(#function, "No logged in user")
        } else {
            let db = Firestore.firestore()
            self.db.collection(COLLECTION_NAME)
                .document(loggedInUserEmail)
                .collection(USER_SESSIONS)
                .getDocuments 
                { snapshot, error in
                        if let error = error {
                            print("Error fetching parking records: \(error)")
                        }
                        else {
                            self.userList = snapshot?.documents.compactMap { document in
                                try? document.data(as: UserProfile.self)
                            } ?? []
                        }
                }
        }
    }
    
    func insertFavoriteSession(favorite : Session){
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        print("TEST " ,loggedInUserEmail )
        if (loggedInUserEmail.isEmpty){
            print(#function, "No logged in user")
        }
        else{
            do {
                try self.db.collection(COLLECTION_NAME)
                    .document(loggedInUserEmail)
                    .collection(FAVORITE_SESSIONS)
                    .addDocument(from: favorite)
            }
            catch let error{
                print(#function, "Unable to insert document to firestore : \(error)")
            }
        }
    }
    
    func insertPurchseList(ticket : PurchaseTicket){
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        print("TEST " ,loggedInUserEmail )
        if (loggedInUserEmail.isEmpty){
            print(#function, "No logged in user")
        }
        else{
            do {
                try self.db.collection(COLLECTION_NAME)
                    .document(loggedInUserEmail)
                    .collection(PURCHASE_SESSIONS)
                    .addDocument(from: ticket)
            }
            catch let error{
                print(#function, "Unable to insert document to firestore : \(error)")
            }
        }
    }
            
    func initializePurchaseList() {
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        print("TEST " ,loggedInUserEmail )
        if (loggedInUserEmail.isEmpty){
            print(#function, "No logged in user")
        }else{
            
            self.db.collection(COLLECTION_NAME)
                .document(loggedInUserEmail)
                .collection(PURCHASE_SESSIONS).getDocuments { [weak self] (querySnapshot, error) in
                    guard let self = self else { return }
                    
                    if let error = error {
                        print("Error getting favorites: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let documents = querySnapshot?.documents else {
                        print("No favorites found")
                        return
                    }
                    
                    let fetchedFavorites = documents.compactMap { document -> PurchaseTicket? in
                        do {
                            var session = try document.data(as: PurchaseTicket.self)
                            session.id = document.documentID // Ensure the id is set
                            return session
                        } catch {
                            print("Error decoding session: \(error.localizedDescription)")
                            return nil
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.purchaseList = fetchedFavorites
                        print("Fetched \(self.favoriteList.count) favorites")
                    }
                }
        }
    }
    
    func getAllPurchaseList() {
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
    
        if loggedInUserEmail.isEmpty {
            print(#function, "No logged in user")
        } else {
            let db = Firestore.firestore()
            db.collection(COLLECTION_NAME)
                .document(loggedInUserEmail)
                .collection(PURCHASE_SESSIONS)
                .getDocuments { snapshot, error in
                    if let error = error {
                        print("Error fetching parking records: \(error)")
                    } else {
                        self.purchaseList = snapshot?.documents.compactMap { document in
                            try? document.data(as: PurchaseTicket.self)
                        } ?? []
                    }
                }
        }
    }
    
    func removeFavorite(withName name: String, completion: @escaping (Bool) -> Void) {
        let userEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        if userEmail.isEmpty {
            print(#function, "No logged in user")
        } else {
            // First, remove from the local list
            if let index = self.favoriteList.firstIndex(where: { $0.name == name }) {
                self.favoriteList.remove(at: index)
            }
            
            // Then, remove from Firestore
            let userDocRef = db.collection(COLLECTION_NAME).document(userEmail)
            let favoritesRef = userDocRef.collection(FAVORITE_SESSIONS)
            
            favoritesRef.whereField("name", isEqualTo: name).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    completion(false)
                    return
                }
                
                guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                    print("No matching documents found")
                    completion(false)
                    return
                }
                
                let batch = self.db.batch()
                
                for document in documents {
                    batch.deleteDocument(document.reference)
                }
                
                batch.commit { error in
                    if let error = error {
                        print("Error removing document: \(error)")
                        completion(false)
                    } else {
                        print("Favorite successfully removed")
                        completion(true)
                    }
                }
            }
        }
    }
    
    func getAllFavSession() {
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
    
        if loggedInUserEmail.isEmpty {
            print(#function, "No logged in user")
        } else {
            let db = Firestore.firestore()
            db.collection(COLLECTION_NAME)
                .document(loggedInUserEmail)
                .collection(FAVORITE_SESSIONS)
                .getDocuments { snapshot, error in
                    if let error = error {
                        print("Error fetching parking records: \(error)")
                    } else {
                        self.favoriteList = snapshot?.documents.compactMap { document in
                            try? document.data(as: Session.self)
                        } ?? []
                        
                    }
                }
        }
    }
    
    func getAllSession() {
        
            let db = Firestore.firestore()
            db.collection(SESSION_COLLECTION_NAME)
                .getDocuments { snapshot, error in
                    if let error = error {
                        print("Error fetching parking records: \(error)")
                    } else {
                        self.sessionList = snapshot?.documents.compactMap { document in
                            try? document.data(as: Session.self)
                        } ?? []
                    }
                
        }
    }
    
    func deleteSession(sessionToDelete : Session){
       let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        do{
            self.db.collection(COLLECTION_NAME)
                .document(loggedInUserEmail)
                .collection(COLLECTION_SESSIONS).document(sessionToDelete.id!).delete{
                error in
                
                if let err = error {
                    print(#function, "Unable to delete document : \(err)")
                }else{
                    print(#function, "Successfully deleted document : \(String(describing: sessionToDelete.id)) (\(sessionToDelete.name)")
                }
            }
        }
    }
    
    func updateSession(sessionToUpdate : Session){
      let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        do{self.db.collection(COLLECTION_NAME)
                .document(loggedInUserEmail)
                .collection(COLLECTION_SESSIONS).document(sessionToUpdate.id!).updateData(
             [
                FIELD_NAME : sessionToUpdate.name,
                FIELD_DESCRIPTION : sessionToUpdate.description,
                FIELD_RATING : sessionToUpdate.rating,
                FIELD_PRICE : sessionToUpdate.price,
                FIELD_HOST : sessionToUpdate.host,
                FIELD_PHOTOS : sessionToUpdate.photos,
                FIELD_MOBILE : sessionToUpdate.mobileNumber ?? 0,
                FIELD_FAVOURITE : sessionToUpdate.isFavorite
             ]
                
             ){
                error in
                
                if let err = error {
                    print(#function, "Unable to delete document : \(err)")
                }else{
                    print(#function, "Successfully deleted document : \(String(describing: sessionToUpdate.id)) (\(sessionToUpdate.name)")
                }
            }
        }
        catch let error{
            print(#function, "Unable to delete the document from firestore : \(error)")
        }
    }
}

