Class {
	#name : #BlSpaceSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'spaceId'
	],
	#category : #'Bloc-Space - Support'
}

{ #category : #accessing }
BlSpaceSignal >> space [
	^ BlSpace
		spaceWithId: spaceId
		do: [ :aSpace | aSpace ]
]

{ #category : #accessing }
BlSpaceSignal >> space: aSpace [
	spaceId := aSpace id
]
