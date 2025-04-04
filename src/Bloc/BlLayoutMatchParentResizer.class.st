Class {
	#name : #BlLayoutMatchParentResizer,
	#superclass : #BlLayoutResizer,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Layouts-Support'
}

{ #category : #cleanup }
BlLayoutMatchParentResizer class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlLayoutMatchParentResizer class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #controlling }
BlLayoutMatchParentResizer >> ifMatchParent: aBlock [
	^ aBlock cull: self
]

{ #category : #testing }
BlLayoutMatchParentResizer >> isMatchParent [
	^ true
]

{ #category : #'double dispatching' }
BlLayoutMatchParentResizer >> measurementAtMostWith: aNumber [
	"Child wants to be our size, but our size is not fixed. Constrain child to not be bigger than us."
	<return: #BlMeasurementSpec>

	^ BlMeasurementSpec new beAtMost: aNumber
]

{ #category : #'double dispatching' }
BlLayoutMatchParentResizer >> measurementExactlyWith: aNumber [
	"Parent has imposed an exact size on us, child wants to be our size. So be it."
	<return: #BlMeasurementSpec>

	^ BlMeasurementSpec new beExact: aNumber
]

{ #category : #'double dispatching' }
BlLayoutMatchParentResizer >> measurementShrinkWith: aNumber [
	"Child wants to be our size, but our size is not fixed. Constrain child to not be bigger than us."
	<return: #BlMeasurementSpec>

	^ self measurementAtMostWith: aNumber
]

{ #category : #'double dispatching' }
BlLayoutMatchParentResizer >> measurementUnspecifiedWith: aNumber [
	"Child wants to be our size... find out how big it should be"
	<return: #BlMeasurementSpec>

	^ BlMeasurementSpec unspecified: aNumber
]

{ #category : #printing }
BlLayoutMatchParentResizer >> printOn: aStream [
	aStream nextPutAll: 'Match parent'
]
