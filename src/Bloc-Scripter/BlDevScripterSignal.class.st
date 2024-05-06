Class {
	#name : #BlDevScripterSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'scripter'
	],
	#category : #'Bloc-Scripter-Signals'
}

{ #category : #accessing }
BlDevScripterSignal >> scripter [
	^ scripter
]

{ #category : #accessing }
BlDevScripterSignal >> scripter: anObject [
	scripter := anObject
]
