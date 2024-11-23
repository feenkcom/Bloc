Class {
	#name : #BlElementDisabledStateWish,
	#superclass : #BlElementStateWish,
	#instVars : [
		'enabled'
	],
	#category : #'Bloc-Core-State'
}

{ #category : #accessing }
BlElementDisabledStateWish >> enabled [
	^ enabled
]

{ #category : #accessing }
BlElementDisabledStateWish >> enabled: anObject [
	enabled := anObject
]
