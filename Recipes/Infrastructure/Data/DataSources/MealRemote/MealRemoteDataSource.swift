//
//  MealRemoteDataSource.swift
//  Recipes
//
//  Created by Ivan Semenov on 20.07.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class MealRemoteDataSource {
    
    private var favoriteMealDtos = [MealDTO]()
    
    private let mealsCollectionName = "meals"
    private let favoritesCollectionName = "favorites"
    
    private let database = Firestore.firestore()
    
}

extension MealRemoteDataSource: MealRemoteDataSourceProtocol {
    
    func deleteMeal(_ meal: Meal, uid: String) {
        guard
            let mealIndex = favoriteMealDtos.firstIndex(where: { $0.id == meal.id }),
            let documentRef = favoriteMealDtos[mealIndex].documentRef
        else { return }
        
        documentRef.delete()
    }
    
    func saveMeal(_ meal: Meal, uid: String) {
        guard !favoriteMealDtos.contains(where: { $0.id == meal.id }) else { return }
        
        var mealDto = MealDTO(id: meal.id,
                              name: meal.name,
                              category: meal.category,
                              area: meal.area,
                              instructions: meal.instructions,
                              thumbnailLink: meal.thumbnailLink,
                              youtubeLink: meal.youtubeLink,
                              tags: meal.tags,
                              ingredients: meal.ingredients.map { .init(measure: $0.measure, ingredient: $0.ingredient) })
        
        let collectionRef = database.collection(favoritesCollectionName).document(uid).collection(mealsCollectionName)
        do {
            let docRef = try collectionRef.addDocument(from: mealDto)
            mealDto.documentRef = docRef
            favoriteMealDtos.append(mealDto)
        } catch {
            print(error)
        }
    }
    
    func fetchMeal(_ uid: String, completion: @escaping (Result<[Meal], Error>) -> Void) {
        let collectionRef = database.collection(favoritesCollectionName).document(uid).collection(mealsCollectionName)
        
        collectionRef.getDocuments { [weak self] snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard
                let self = self,
                let documents = snapshot?.documents
            else { return }
            
            favoriteMealDtos = documents.compactMap { doc in
                var mealDto = try? doc.data(as: MealDTO.self)
                mealDto?.documentRef = doc.reference
                return mealDto
            }
            
            completion(.success(favoriteMealDtos.map { $0.toMeal() }))
        }
        
    }
    
}
