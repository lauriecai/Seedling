//
//  Plant+CoreDataProperties.swift
//  Seedling
//
//  Created by Laurie Cai on 2/15/24.
//
//

import Foundation
import CoreData

extension Plant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plant> {
        return NSFetchRequest<Plant>(entityName: "Plant")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
	@NSManaged public var variety: String?
	@NSManaged public var type: String?
	@NSManaged public var stage: String?
	
	@NSManaged public var sunlightRequirement: String?
	@NSManaged public var waterRequirement: String?
	@NSManaged public var temperatureRequirement: String?
	@NSManaged public var humidityRequirement: String?
	@NSManaged public var soilRequirement: String?
	@NSManaged public var fertilizerRequirement: String?
	@NSManaged public var additionalCareNotes: String?
	
	public var wrappedName: String {
		name ?? ""
	}
	
	public var wrappedVariety: String {
		variety ?? ""
	}
	
	public var wrappedFullNameLabel: String {
		if !wrappedVariety.isEmpty {
			return "\(wrappedName): \(wrappedVariety)"
		} else {
			return "\(wrappedName)"
		}
	}
	
	public var wrappedFullNameSentence: String {
		if !wrappedVariety.isEmpty {
			return "\(wrappedVariety) \(wrappedName)".lowercased()
		} else {
			return "\(wrappedName)".lowercased()
		}
	}

	public var wrappedType: String {
		type ?? ""
	}
	
	public var wrappedStage: String {
		stage ?? ""
	}
	
	public var wrappedSunlightRequirement: String {
		sunlightRequirement ?? ""
	}
	
	public var wrappedWaterRequirement: String {
		waterRequirement ?? ""
	}
	
	public var wrappedTemperatureRequirement: String {
		temperatureRequirement ?? ""
	}
	
	public var wrappedHumidityRequirement: String {
		humidityRequirement ?? ""
	}
	
	public var wrappedSoilRequirement: String {
		soilRequirement ?? ""
	}
	
	public var wrappedFertilizerRequirement: String {
		fertilizerRequirement ?? ""
	}
	
	public var wrappedAdditionalCareNotes: String {
		additionalCareNotes ?? ""
	}
	
	public var customHash: Int {
		var hasher = Hasher()
		hasher.combine(self.id)
		hasher.combine(self.wrappedName)
		hasher.combine(self.wrappedVariety)
		hasher.combine(self.stage)
		
		return hasher.finalize()
	}
}

// MARK: Generated accessors for notes
extension Plant {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

extension Plant : Identifiable {

}
