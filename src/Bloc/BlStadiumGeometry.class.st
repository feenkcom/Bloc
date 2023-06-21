"
A stadium is a geometric figure consisting of a rectangle with top and bottom lengths a whose ends are capped off with semicircles of radius r.

"
Class {
	#name : #BlStadiumGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'orientation'
	],
	#classVars : [
		'Auto',
		'Horizontal',
		'Vertical'
	],
	#category : #'Bloc-Basic'
}

{ #category : #initialization }
BlStadiumGeometry class >> initialize [
	Vertical := #vertical.
	Horizontal := #horizontal.
	Auto := #auto
]

{ #category : #'api - orientation' }
BlStadiumGeometry >> beAuto [
	self orientation: Auto
]

{ #category : #'api - orientation' }
BlStadiumGeometry >> beHorizontal [
	self orientation: Horizontal
]

{ #category : #'api - orientation' }
BlStadiumGeometry >> beVertical [
	self orientation: Vertical
]

{ #category : #initialization }
BlStadiumGeometry >> initialize [
	super initialize.
	
	orientation := Auto
]

{ #category : #geometry }
BlStadiumGeometry >> length [
	"Compute the field length of the stadium"
	<return: #Number>

	^ self lengthForOrienatation: self resolveOrientation
]

{ #category : #geometry }
BlStadiumGeometry >> lengthForOrienatation: anOrientation [
	"Compute the field length of the stadium"
	<return: #Number>

	anOrientation = Vertical
		ifTrue: [ ^ self extent y ].
		
	anOrientation = Horizontal
		ifTrue: [ ^ self extent x ].

	self error: 'Unsupported orientation: ', anOrientation printString
]

{ #category : #geometry }
BlStadiumGeometry >> matchExtent: aPoint [
	extent := aPoint
]

{ #category : #'api - orientation' }
BlStadiumGeometry >> orientation: anOrientation [
	orientation = anOrientation
		ifTrue: [ ^ self ].
		
	orientation := anOrientation.
	self releaseCache
]

{ #category : #geometry }
BlStadiumGeometry >> radius [
	"Compute the radius of the semicircles"
	<return: #Number>
	
	^ self radiusForOrientation: self resolveOrientation
]

{ #category : #geometry }
BlStadiumGeometry >> radiusForOrientation: anOrientation [
	"Compute the radius of the semicircles for a given specific orientation (vertical or horizontal)"
	<return: #Number>
	
	anOrientation = Vertical
		ifTrue: [ ^ self extent x / 2.0 ].
		
	anOrientation = Horizontal
		ifTrue: [ ^ self extent y / 2.0 ].

	self error: 'Unsupported orientation: ', anOrientation printString
]

{ #category : #'api - orientation' }
BlStadiumGeometry >> resolveOrientation [
	| anOrientation |
	
	anOrientation := orientation ifNil: [ Auto ].
	^ anOrientation = Auto
		ifTrue: [
			self extent x < self extent y
				ifTrue: [ Vertical ]
				ifFalse: [ Horizontal ] ]
		ifFalse: [ anOrientation ]
]
