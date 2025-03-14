Class {
	#name : #BlElementIndexedId,
	#superclass : #BlElementId,
	#instVars : [
		'prefixId',
		'index'
	],
	#category : #'Bloc-Core-Support'
}

{ #category : #comparing }
BlElementIndexedId >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	
	(anObject isKindOf: BlElementId)
		ifFalse: [ ^ false ].
	
	"if anObject is of the same class it is faster to directly compare index and prefixId"
	self class = anObject class
		ifTrue: [ ^ index = anObject index and: [ prefixId = anObject prefixId ] ].
	
	"otherwise fallback to the symbol comparison, but watch out, #asSymbol may not be cheap!"
	^ self asSymbol = anObject asSymbol
]

{ #category : #converting }
BlElementIndexedId >> asSymbol [
	^ Symbol streamContents: [ :aStream | 
		aStream
			nextPutAll: self prefixId asSymbol;
			nextPut: $-;
			print: self index ]
]

{ #category : #accessing }
BlElementIndexedId >> index [
	<return: #Number>

	^ index
]

{ #category : #accessing }
BlElementIndexedId >> index: aNumber [
	index := aNumber
]

{ #category : #testing }
BlElementIndexedId >> isIndexed [
	^ true
]

{ #category : #accessing }
BlElementIndexedId >> prefixId [
	<return: #BlElementId>

	^ prefixId
]

{ #category : #accessing }
BlElementIndexedId >> prefixId: aBlElementId [
	prefixId := aBlElementId
]
