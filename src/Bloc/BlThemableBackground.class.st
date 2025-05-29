Class {
	#name : #BlThemableBackground,
	#superclass : #BlBackground,
	#instVars : [
		'backgroundComputation',
		'theme',
		'background',
		'backgroundSource'
	],
	#category : #'Bloc-Core-Background'
}

{ #category : #accessing }
BlThemableBackground class >> background: aBackgroundComputation source: aBackgroundSource forTheme: aTheme [
	"Background computation is block that accepts a theme as an argument and returns an object that can be used as a background.
	[ :aTheme | aTheme button defaultBackgroundColor ]"

	^ self new
		initializeBackground: aBackgroundComputation
		source: aBackgroundSource
		forTheme: aTheme
		yourself
]

{ #category : #comparing }
BlThemableBackground >> = anotherObject [
	self == anotherObject ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class) ifFalse: [ ^ false ].

	^ anotherObject theme = self theme
		and: [ anotherObject backgroundComputation = self backgroundComputation
			and: [ anotherObject backgroundSource = self backgroundSource
				and: [ anotherObject cachedBackground = self cachedBackground ] ] ]
]

{ #category : #accessing }
BlThemableBackground >> backgroundComputation [
	^ backgroundComputation
]

{ #category : #accessing }
BlThemableBackground >> backgroundSource [
	^ backgroundSource
]

{ #category : #accessing }
BlThemableBackground >> cachedBackground [
	^ background
]

{ #category : #'as yet unclassified' }
BlThemableBackground >> gtBackgroundSourceFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Source';
		priority: 5;
		object: [ backgroundComputation ];
		view: #gtSourceCodeFor:	
]

{ #category : #'as yet unclassified' }
BlThemableBackground >> gtViewBackgroundFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 50;
		stencil: [
			BlElement new
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ];
				padding: (BlInsets all: 50);
				addChild:(BlElement new
					size: 200@100;
					outskirts: (BlOutskirts inside);
					theme: theme;
					background: self) ]
]

{ #category : #comparing }
BlThemableBackground >> hash [
	^ ((self backgroundComputation hash bitXor: self cachedBackground hash) bitXor: self theme) bitXor: self backgroundSource
]

{ #category : #'as yet unclassified' }
BlThemableBackground >> initializeBackground: aBackgroundComputation forTheme: aTheme [
	self
		assert: [ background isNil ]
		description: [ 'Background must not be initialized' ].

	theme := aTheme.
	backgroundComputation := aBackgroundComputation.
	background := (aBackgroundComputation cull: aTheme) asBlBackground.
]

{ #category : #'as yet unclassified' }
BlThemableBackground >> initializeBackground: aBackgroundComputation source: aBackgroundSource forTheme: aTheme [
	self
		assert: [ background isNil ]
		description: [ 'Background must not be initialized' ].

	theme := aTheme.
	backgroundComputation := aBackgroundComputation.
	backgroundSource := aBackgroundSource.
	background := (aBackgroundComputation cull: aTheme) asBlBackground.
]

{ #category : #testing }
BlThemableBackground >> isOpaque [
	"Return true if the whole background is opaque"
	<return: #Boolean>
	
	^ background isOpaque
]

{ #category : #testing }
BlThemableBackground >> isTransparent [
	"Return true if the whole background is opaque"
	<return: #Boolean>
	
	^ background isTransparent
]

{ #category : #geometry }
BlThemableBackground >> matchExtent: anExtent [
	"Resize background to match given extent.
	Used to adapt image or gradient backgrounds to the element's extent"

	"themable backgrounds are basically unique instances, so we can't modify an internal state"
	self flag: #TODO.
]

{ #category : #'as yet unclassified' }
BlThemableBackground >> onAssignedTo: anElement [
	theme = anElement theme
		ifTrue: [ ^ self ].
	
	^ (backgroundSource cull: anElement theme)
]

{ #category : #accessing }
BlThemableBackground >> onThemeChanged: anElement [
	"When a theme of an element changes we try to create a new background based on a background computation.
	Note: we must not mutate an internal state of the background, instead we create a new instance"

	"the theme is the same, do nothing"
	theme = anElement theme
		ifTrue: [ ^ self ].
	
	anElement background: (backgroundSource cull: anElement theme)
]

{ #category : #accessing }
BlThemableBackground >> theme [
	^ theme
]
