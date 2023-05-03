	//
	//  StorageManager.swift
	//  StandardApp
	//
	//  Created by brubru on 23.04.2023.
	//

import CoreData

enum StorageError: Error {
	case noFetch
}

protocol IStorageManager {
	func getAthletes(completion: (Result<[Athlete], StorageError>) -> Void)
	func createAthlet(name: String, gender: String, completion: (Athlete) -> Void)
	func deleteAthlete(_ athlete: Athlete)
	func updateAthlete(_ athlete: Athlete, newName: String)
	
	func createTimeResult(distance: String,
						  timeInfo: TimeInfo?,
						  discharge: Discharge?, completion: (TimeResult) -> Void)
	func saveTimeResult(athlete: Athlete, timeResult: TimeResult)
	func deleteTiemResult(athlete: Athlete, timeResult: TimeResult)
}

final class StorageManager {
	
		// MARK: - Core Data stack
	private let viewContext: NSManagedObjectContext
	
	private let persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Athlete")
		container.loadPersistentStores { _, error in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		}
		return container
	}()
	
	
	init() {
		viewContext = persistentContainer.viewContext
	}
	
		// MARK: - Core Data Saving support
	func saveContext() {
		if viewContext.hasChanges {
			do {
				try viewContext.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
}

extension StorageManager: IStorageManager {
		//MARK: - Athlete
		/// Сохраняет в CoreDate новое имя у объекта Athlete
		/// - Parameters:
		///   - athlete: Объект типа Athlete
		///   - newName: Новое имя объекта
	func updateAthlete(_ athlete: Athlete, newName: String) {
		athlete.nikName = newName
		saveContext()
	}

		/// Удаляет объект из CoreData
		/// - Parameter athlete: Объект типа Athlete
	func deleteAthlete(_ athlete: Athlete) {
		viewContext.delete(athlete)
		saveContext()
	}
	
		/// Загружает массив типа Athlete из Core Data
		/// - Parameter completion: блок замыкания, который возвращает загруженный массив
	func getAthletes(completion: (Result<[Athlete], StorageError>) -> Void) {
		let fetchRequest = Athlete.fetchRequest()
		
		do {
			let athletes = try viewContext.fetch(fetchRequest)
			completion(.success(athletes))
		} catch {
			completion(.failure(.noFetch))
		}
	}
	
		/// Создает объект Athlete и сохраняет его в CoreData
		/// - Parameters:
		///   - name: имя ателта
		///   - gender: половая принадлежность
		///   - completion: блок замыкания, возвращающий созданного атлета типа Athlete
	func createAthlet(name: String, gender: String, completion: (Athlete) -> Void) {
		let athlete = Athlete(context: viewContext)
		athlete.nikName = name
		athlete.gender = gender
		completion(athlete)
		saveContext()
	}
	
	// MARK: - TimeResult
	func createTimeResult(distance: String,
						  timeInfo: TimeInfo?,
						  discharge: Discharge?, completion: (TimeResult) -> Void) {
		
		let timeResult = TimeResult(context: viewContext)
		let rank = Rank(context: viewContext)
		let record = Record(context: viewContext)
		
		timeResult.distance = distance
		timeResult.date = Date()
		timeResult.userTime = timeInfo?.time ?? ""
		timeResult.userRank = timeInfo?.title ?? ""
		timeResult.imageRank = timeInfo?.imageRank ?? ""
		
		rank.msmk = discharge?.msmk.time ?? ""
		rank.ms = discharge?.ms.time ?? ""
		rank.kms = discharge?.kms.time ?? ""
		rank.firstRank = discharge?.firstRank.time ?? ""
		rank.secondRank = discharge?.secondRank.time ?? ""
		rank.thirdRank = discharge?.thirdRank.time ?? ""
		rank.firstJunior = discharge?.firstJunior.time ?? ""
		rank.secondJunior = discharge?.secondJunior.time ?? ""
		rank.thirdJunior = discharge?.thirdJunior.time ?? ""
		
		timeResult.allRank = rank
		
		record.fullName = discharge?.recordHolder.fullName ?? ""
		record.time = discharge?.recordHolder.time ?? ""
		record.recordDate = discharge?.recordHolder.recordDate ?? ""
		
		rank.recordHolder = record
		
		completion(timeResult)
	}
	
	func saveTimeResult(athlete: Athlete, timeResult: TimeResult) {
		athlete.addToTimeResults(timeResult)
		saveContext()
	}
	
	func deleteTiemResult(athlete: Athlete, timeResult: TimeResult) {
		athlete.removeFromTimeResults(timeResult)
		saveContext()
	}
}
