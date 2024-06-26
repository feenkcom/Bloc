Class {
	#name : #BlDevScripterElementIdEventTarget,
	#superclass : #BlScripterElementTarget,
	#instVars : [
		'elementId',
		'index'
	],
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #testing }
BlDevScripterElementIdEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ anObject isString and: [ anObject isSymbol not ]
]

{ #category : #'instance creation' }
BlDevScripterElementIdEventTarget class >> newFromInput: anObject [
	^ self new name: anObject
]

{ #category : #accessing }
BlDevScripterElementIdEventTarget >> elementId [
	<return: #BlElementId>

	^ elementId
]

{ #category : #accessing }
BlDevScripterElementIdEventTarget >> elementId: aBlElementId [
	elementId := aBlElementId asBlocElementId
]

{ #category : #searching }
BlDevScripterElementIdEventTarget >> findTargetIn: anElement [
	<return: #BlElement>
	| aCounter anIndexedId |

	aCounter := 0.
	anIndexedId := self elementId indexed: self index.
	
	anElement allChildrenBreadthFirstDo: [ :aChild |
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
BlDevScripterElementIdEventTarget >> identifier [
	^ self elementId asSymbol
]

{ #category : #accessing }
BlDevScripterElementIdEventTarget >> index [
	^ index
]

{ #category : #accessing }
BlDevScripterElementIdEventTarget >> index: anObject [
	index := anObject
]

{ #category : #initialization }
BlDevScripterElementIdEventTarget >> initialize [
	super initialize.
	
	index := 1
]

{ #category : #printing }
BlDevScripterElementIdEventTarget >> printOn: aStream [
	self elementId ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Element id: ';
		print: self identifier
]
