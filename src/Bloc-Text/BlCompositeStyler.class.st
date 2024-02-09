Class {
	#name : #BlCompositeStyler,
	#superclass : #BlTextStyler,
	#instVars : [
		'stylers'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #accessing }
BlCompositeStyler >> addStyler: aStyler [
	stylers add: aStyler
]

{ #category : #accessing }
BlCompositeStyler >> initialize [
	super initialize.
	
	stylers := OrderedCollection new
]

{ #category : #accessing }
BlCompositeStyler >> style: aText [
	self stylers do: [ :aStyler | aStyler style: aText ].
	^ aText
]

{ #category : #accessing }
BlCompositeStyler >> stylers [
	^ stylers
]

{ #category : #accessing }
BlCompositeStyler >> stylers: anObject [
	stylers := anObject
]
