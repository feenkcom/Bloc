Class {
	#name : #BlLayoutFitContentLimitedResizer,
	#superclass : #BlLayoutResizer,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Layouts-Support'
}

{ #category : #cleanup }
BlLayoutFitContentLimitedResizer class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlLayoutFitContentLimitedResizer class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #controlling }
BlLayoutFitContentLimitedResizer >> ifFitContent: aBlock [
	^ aBlock cull: self
]

{ #category : #testing }
BlLayoutFitContentLimitedResizer >> isFitContent [
	^ true
]

{ #category : #testing }
BlLayoutFitContentLimitedResizer >> isFitContentLimited [
	^ true
]

{ #category : #'double dispatching' }
BlLayoutFitContentLimitedResizer >> measurementAtMostWith: aNumber [
	"Child wants to determine its own size. It can't be bigger than us."
	<return: #BlMeasurementSpec>

	^ BlMeasurementSpec new beAtMost: aNumber
]

{ #category : #'double dispatching' }
BlLayoutFitContentLimitedResizer >> measurementExactlyWith: aNumber [
	"Child wants to determine its own size. It can't be bigger than us."
	<return: #BlMeasurementSpec>

   ^ BlMeasurementSpec new beAtMost: aNumber
]

{ #category : #'double dispatching' }
BlLayoutFitContentLimitedResizer >> measurementShrinkWith: aNumber [
	"Child wants to be our size, but our size is not fixed. Constrain child to not be bigger than us."
	<return: #BlMeasurementSpec>

	^ self measurementAtMostWith: aNumber
]

{ #category : #'double dispatching' }
BlLayoutFitContentLimitedResizer >> measurementUnspecifiedWith: aNumber [
	"Child wants to determine its own size.... find out how big it should be"
	<return: #BlMeasurementSpec>

	^ BlMeasurementSpec unspecified: aNumber
]

{ #category : #printing }
BlLayoutFitContentLimitedResizer >> printOn: aStream [
	aStream nextPutAll: 'Fit content limited'
]
