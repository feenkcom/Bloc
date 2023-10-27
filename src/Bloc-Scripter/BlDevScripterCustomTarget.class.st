Class {
	#name : #BlDevScripterCustomTarget,
	#superclass : #Object,
	#instVars : [
		'scripterStep'
	],
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #'instance creation' }
BlDevScripterCustomTarget class >> forStep: aScripterStep [
	^ self new 
		initializeForScripterStep: aScripterStep
]

{ #category : #initialization }
BlDevScripterCustomTarget >> initializeForScripterStep: aStep [
	scripterStep := aStep
]

{ #category : #accessing }
BlDevScripterCustomTarget >> scripterStep [
	^ scripterStep
]
