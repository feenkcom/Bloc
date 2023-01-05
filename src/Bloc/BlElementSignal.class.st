Class {
	#name : #BlElementSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Basic-Support'
}

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
