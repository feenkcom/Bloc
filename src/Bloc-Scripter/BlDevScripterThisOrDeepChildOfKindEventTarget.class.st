Class {
	#name : #BlDevScripterThisOrDeepChildOfKindEventTarget,
	#superclass : #BlScripterElementTarget,
	#instVars : [
		'elementClass'
	],
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #accessing }
BlDevScripterThisOrDeepChildOfKindEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ anObject isClass
]

{ #category : #accessing }
BlDevScripterThisOrDeepChildOfKindEventTarget class >> newFromInput: anObject [
	^ self new elementClass: anObject
]

{ #category : #accessing }
BlDevScripterThisOrDeepChildOfKindEventTarget >> elementClass [
	^ elementClass
]

{ #category : #accessing }
BlDevScripterThisOrDeepChildOfKindEventTarget >> elementClass: aClass [
	self
		assert: [ aClass notNil ]
		description: [ 'Element class must not be nil' ].

	self 
		assert: [ self class environment includesKey: aClass name ]
		description: [ 'Element class named {1} does not exist in the environment' format: { aClass name } ].

	self 
		assert: [ (self class environment at: aClass name) = aClass ]
		description: [ 'Element class in the environment named {1} does not correspond to the given class' format: { aClass name } ].

	self 
		assert: [ aClass == BlElement or: [ 
			aClass inheritsFrom: BlElement ] ]
		description: [ 'Element class must be subclass of BlElement' ].

	elementClass := aClass
]

{ #category : #accessing }
BlDevScripterThisOrDeepChildOfKindEventTarget >> findTargetIn: anElement [
	<return: #BlElement>

	(anElement isKindOf: self elementClass) 
		ifTrue: [ ^ anElement ].
	
	^ anElement 
		allChildrenBreadthFirstDetect: [ :eachChild | 
			eachChild isKindOf: self elementClass ]
		ifFound: [ :aTargetElement | aTargetElement ]
		ifNone: [ AssertionFailure signal: 'Cannot find target element of kind ', self elementClass printString ]
]

{ #category : #accessing }
BlDevScripterThisOrDeepChildOfKindEventTarget >> identifier [
	^ self elementClass ifNil: [ self ]
]
