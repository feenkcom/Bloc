Class {
	#name : #BlElementSelectedState,
	#superclass : #BlElementUniqueState,
	#category : #'Bloc-Core-State'
}

{ #category : #enumerating }
BlElementSelectedState >> optionalEventHandlerDo: aBlock [
	aBlock value: BlElementSelectedStateEventHandler uniqueInstance
]

{ #category : #printing }
BlElementSelectedState >> printOn: aStream [
	aStream nextPutAll: 'selected'
]

{ #category : #accessing }
BlElementSelectedState >> priority [
	^ UserPriority
]
