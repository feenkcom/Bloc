Class {
	#name : #BlEmUnit,
	#superclass : #BlUnit,
	#category : #'Bloc-Core-Units'
}

{ #category : #printing }
BlEmUnit >> printOn: aStream [
	aStream nextPutAll: 'em'
]

{ #category : #accessing }
BlEmUnit >> resolveLengthForValue: aCurrentValueOrBlock parent: aParentValueOrBlock global: aGlobalValueOrBlock [
	<return: #Number>

	^ aParentValueOrBlock value * aCurrentValueOrBlock value
]
