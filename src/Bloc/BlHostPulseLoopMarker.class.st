Class {
	#name : #BlHostPulseLoopMarker,
	#superclass : #ProcessLocalVariable,
	#category : #'Bloc-Universe - Host'
}

{ #category : #testing }
BlHostPulseLoopMarker class >> isUIProcess [
	^ self value ifNil: [ false ]
]

{ #category : #accessing }
BlHostPulseLoopMarker class >> markAsUIProcess [
	self value: true
]
