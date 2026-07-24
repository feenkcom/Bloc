Class {
	#name : #BlThemeModified,
	#superclass : #Announcement,
	#instVars : [
		'theme'
	],
	#category : #'Bloc-Core-Theme'
}

{ #category : #accessing }
BlThemeModified >> theme [
	^ theme
]

{ #category : #accessing }
BlThemeModified >> theme: anObject [
	theme := anObject
]
