"
I am an exporter of bloc elements to various output formats. See my subclasses for more info

"
Class {
	#name : #BlExporter,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'element',
		'scale',
		'background'
	],
	#category : #'Bloc-Exporter'
}

{ #category : #'instance creation' }
BlExporter class >> form [
	^ BlFormExporter new
]

{ #category : #'instance creation' }
BlExporter class >> jpg [
	^ BlJpgExporter new
]

{ #category : #'instance creation' }
BlExporter class >> pdf [
	^ BlPdfExporter new
]

{ #category : #'instance creation' }
BlExporter class >> png [
	^ BlPngExporter new
]

{ #category : #'instance creation' }
BlExporter class >> svg [
	^ BlSvgExporter new
]

{ #category : #accessing }
BlExporter >> background [
	^ background
]

{ #category : #'api - configuration' }
BlExporter >> background: aColorOrPaint [
	background := aColorOrPaint
]

{ #category : #private }
BlExporter >> computeBounds [
	<return: #BlBounds>
	| anElement aBoundsInLocal aBoundsInParent |
	
	anElement := self element.
	
	aBoundsInLocal := (anElement effectBounds: BlBounds new)
		merge: anElement boundsInLocal;
		merge: anElement visualBounds.

	aBoundsInParent := anElement localBoundsToParent: aBoundsInLocal copy.
	
	^ aBoundsInParent
]

{ #category : #'instance creation' }
BlExporter >> createCanvas: anExtent [
	"Create a suitable canvas of a given size used for the export"
	<return: #SpartaCanvas>
	
	^ self subclassResponsibility
]

{ #category : #private }
BlExporter >> doExport: aFinalizingBlock [
	| aCanvas aBoundsInParent anElement aResult |

	anElement := self element.
	anElement forceLayout.

	aBoundsInParent := self computeBounds.
	
	aCanvas := self createCanvas: (aBoundsInParent extent * self scale max: 1@1).

	aResult := self
		drawOn: aCanvas
		during: [
			aCanvas transform
				by: [ :aTransform | aTransform
					scaleBy: self scale asPoint;
					translateBy: (aBoundsInParent origin) negated ]
				during: [ anElement fullDrawOnSpartaCanvas: aCanvas ] ].

	^ aFinalizingBlock cull: aResult
]

{ #category : #protected }
BlExporter >> drawOn: aCanvas during: aBlock [
	"By default we don't do any specific canvas preparations"
	
	aCanvas fill
		path: aCanvas bounds;
		paint: self background;
		draw.
	
	aBlock cull: aCanvas.
	
	^ aCanvas
]

{ #category : #accessing }
BlExporter >> element [
	"Return an element to be exported"
	<return: #BlElement>
	
	^ element
]

{ #category : #'api - configuration' }
BlExporter >> element: aBlElement [
	"Specify an element to be exorted"
	self
		assert: [ aBlElement isNotNil ]
		description: [ 'Element must not be nil' ].
	
	element := aBlElement
]

{ #category : #'api - exporting' }
BlExporter >> export [
	"Start exporting process. Subclasses must implement me"
	
	self subclassResponsibility
]

{ #category : #initialization }
BlExporter >> initialize [
	super initialize.
	
	scale := 1.
	background := Color transparent
]

{ #category : #accessing }
BlExporter >> scale [
	<return: #Number>

	^ scale
]

{ #category : #'api - configuration' }
BlExporter >> scaled: aNumber [

	self
		assert: [ aNumber > 0 ]
		description: [ 'Scale must be positive' ].

	scale := aNumber
]
