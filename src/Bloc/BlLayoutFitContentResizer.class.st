Class {
	#name : #BlLayoutFitContentResizer,
	#superclass : #BlLayoutResizer,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Layouts-Support'
}

{ #category : #cleanup }
BlLayoutFitContentResizer class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlLayoutFitContentResizer class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #controlling }
BlLayoutFitContentResizer >> ifFitContent: aBlock [
	^ aBlock cull: self
]

{ #category : #testing }
BlLayoutFitContentResizer >> isFitContent [
	^ true
]

{ #category : #'double dispatching' }
BlLayoutFitContentResizer >> measurementAtMostWith: aNumber [
	"Child wants to determine its own size. It may be bigger than us."
	<return: #BlMeasurementSpec>

	^ BlMeasurementSpec unspecified
]

{ #category : #'double dispatching' }
BlLayoutFitContentResizer >> measurementExactlyWith: aNumber [
	"Child wants to determine its own size. It may be bigger than us."
	<return: #BlMeasurementSpec>

	^ BlMeasurementSpec unspecified
]

{ #category : #'double dispatching' }
BlLayoutFitContentResizer >> measurementShrinkWith: aNumber [
	"Child wants to determine its own size. Constrain child to not be bigger than us."
	<return: #BlMeasurementSpec>

	^ BlMeasurementSpec new beAtMost: aNumber
]

{ #category : #'double dispatching' }
BlLayoutFitContentResizer >> measurementUnspecifiedWith: aNumber [
	"Child wants to determine its own size.... find out how big it should be"
	<return: #BlMeasurementSpec>

	^ BlMeasurementSpec unspecified: aNumber
]

{ #category : #printing }
BlLayoutFitContentResizer >> printOn: aStream [
	aStream nextPutAll: 'Fit content'
]
