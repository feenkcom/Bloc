Class {
	#name : #BlElementFocusedState,
	#superclass : #BlElementUniqueState,
	#category : #'Bloc-Core-State'
}

{ #category : #enumerating }
BlElementFocusedState >> optionalEventHandlerDo: aBlock [
	aBlock value: BlElementFocusedStateEventHandler uniqueInstance
]

{ #category : #printing }
BlElementFocusedState >> printOn: aStream [
	aStream nextPutAll: 'focused'
]

{ #category : #accessing }
BlElementFocusedState >> priority [
	^ 60
]
