Class {
	#name : #BlElementSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Core-Support'
}

{ #category : #testing }
BlElementSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]

{ #category : #accessing }
BlElementSignal >> element [

	^ element
]

{ #category : #accessing }
BlElementSignal >> element: anObject [

	element := anObject
]

{ #category : #testing }
BlElementSignal >> hasParentSuchThat: aBlock [
	^ element
		withAllParentsDetect: aBlock
		ifFound: [ :aParent | true ]
		ifNone: [ false ]
]
