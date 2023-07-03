import UIKit
import CoreData

class GalleryViewModel {
    private var selectedPhotos: [UIImage] = []
    
    var photos: [UIImage] = []
    
    func fetchPhotos() {
        let context = CoreDataManager.shared.viewContext
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest() 
        
        do {
            let fetchedPhotos = try context.fetch(fetchRequest)
            photos = fetchedPhotos.compactMap { fetchedPhoto in
                guard let base64ImageString = fetchedPhoto.path else { return nil }
                guard let imageData = Data(base64Encoded: base64ImageString) else { return nil }
                return UIImage(data: imageData)
            }
            print("Photo library count \(photos.count)")
        } catch {   
            print("Error fetching photos: \(error)")
        }
    }
    
    func numberOfPhotos() -> Int {
        return photos.count
    }
    
    func photo(at index: Int) -> UIImage {
        return photos[index]
    }
    
    func selectPhoto(image: UIImage) {
        selectedPhotos.append(image)
        
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            let base64ImageString = imageData.base64EncodedString()

            let context = CoreDataManager.shared.viewContext
            let photoEntity = Entity(context: context)
            
            photoEntity.path = base64ImageString

            CoreDataManager.shared.saveContext()
        }
        fetchPhotos()
    }
}
