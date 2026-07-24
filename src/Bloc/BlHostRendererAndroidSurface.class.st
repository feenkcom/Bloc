Class {
	#name : #BlHostRendererAndroidSurface,
	#superclass : #BlHostRendererSurface,
	#instVars : [
		'extent',
		'nativeWindow'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #accessing }
BlHostRendererAndroidSurface class >> priority [
	"Android should have higher priority than OpenGL"

	^ 5
]

{ #category : #testing }
BlHostRendererAndroidSurface class >> supportedBy: anObject [
	"Return true if a given object supports form surface, false otherwise"
	<return: #Boolean>

	^ anObject supportsAndroidSurface
]

{ #category : #initialization }
BlHostRendererAndroidSurface >> createSpaceRendererOn: anObject [
	<return: #BlHostSpaceRenderer>

	^ anObject createAndroidSpaceRenderer
]

{ #category : #initialization }
BlHostRendererAndroidSurface >> createSurfaceRendererOn: anObject [
	<return: #BlHostSurfaceRenderer>

	^ anObject createAndroidSurfaceRenderer
]

{ #category : #accessing }
BlHostRendererAndroidSurface >> extent [
	"Return an actual extent of the underlying surface.
	Note: #extent may be different from canvas or window extents"
	<return: #Point>

	^ extent
]

{ #category : #accessing }
BlHostRendererAndroidSurface >> extent: anObject [

	extent := anObject
]

{ #category : #'as yet unclassified' }
BlHostRendererAndroidSurface >> isValid [
	super isValid
		ifFalse: [ ^ false ].
		
	^ nativeWindow isNotNil and: [ nativeWindow isNull not ]
]

{ #category : #accessing }
BlHostRendererAndroidSurface >> nativeWindow [
	^ nativeWindow
]

{ #category : #accessing }
BlHostRendererAndroidSurface >> nativeWindow: anObject [
	nativeWindow := anObject
]
