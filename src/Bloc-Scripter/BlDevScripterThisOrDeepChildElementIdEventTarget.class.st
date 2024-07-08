Class {
	#name : #BlDevScripterThisOrDeepChildElementIdEventTarget,
	#superclass : #BlScripterElementTarget,
	#instVars : [
		'elementId',
		'index'
	],
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #testing }
BlDevScripterThisOrDeepChildElementIdEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ anObject isString and: [ anObject isSymbol not ]
]

{ #category : #'instance creation' }
BlDevScripterThisOrDeepChildElementIdEventTarget class >> newFromInput: anObject [
	^ self new name: anObject
]

{ #category : #accessing }
BlDevScripterThisOrDeepChildElementIdEventTarget >> elementId [
	<return: #BlElementId>

	^ elementId
]

{ #category : #accessing }
BlDevScripterThisOrDeepChildElementIdEventTarget >> elementId: aBlElementId [
	elementId := aBlElementId asBlocElementId
]

{ #category : #searching }
BlDevScripterThisOrDeepChildElementIdEventTarget >> findTargetIn: anElement [
	<return: #BlElement>
	| aCounter anIndexedId |

	aCounter := 0.
	anIndexedId := self elementId indexed: self index.
	
	anElement withAllChildrenBreadthFirstDo: [ :aChild |
		"We search an indexed element ID"
		aChild id = anIndexedId ifTrue: [ ^ aChild ].
	
		"...or nth occurrence of the element ID"
		aChild id = elementId
			ifTrue: [
				aCounter := aCounter + 1.
				aCounter = index
					ifTrue: [ ^ aChild ] ] ].

	AssertionFailure signal: 'Could not find ', index asString, 'th element with id ', self elementId asSymbol
]

{ #category : #accessing }
BlDevScripterThisOrDeepChildElementIdEventTarget >> identifier [
	^ self elementId asSymbol
]

{ #category : #accessing }
BlDevScripterThisOrDeepChildElementIdEventTarget >> index [
	^ index
]

{ #category : #accessing }
BlDevScripterThisOrDeepChildElementIdEventTarget >> index: anObject [
	index := anObject
]

{ #category : #initialization }
BlDevScripterThisOrDeepChildElementIdEventTarget >> initialize [
	super initialize.
	
	index := 1
]

{ #category : #printing }
BlDevScripterThisOrDeepChildElementIdEventTarget >> printOn: aStream [
	self elementId ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Element id: ';
		print: self identifier
]
