"
# Element id

Allows to assign id to {{gtClass:BlElement}}. This allows us query a tree of elements

"
Class {
	#name : #BlElementId,
	#superclass : #Object,
	#category : #'Bloc-Basic-Support'
}

{ #category : #'instance creation' }
BlElementId class >> named: aSymbol [
	^ BlElementNamedId new
		identifier: aSymbol asSymbol
]

{ #category : #'instance creation' }
BlElementId class >> noId [
	^ BlElementNoId uniqueInstance
]

{ #category : #converting }
BlElementId >> = anObject [
	"Comparing `self = anObject` must provide 
	same results as `self asSymbol = anObject asSymbol`. 
	See the #hash method comment."

	^ self subclassResponsibility
]

{ #category : #converting }
BlElementId >> asBlocElementId [
	^ self
]

{ #category : #converting }
BlElementId >> asSymbol [
	^ self subclassResponsibility
]

{ #category : #comparing }
BlElementId >> hash [
	"Hash must always be based on the symbol to support proper comparison between ids that are just
	constructed differently but have same symbolic id"

	^ self asSymbol hash
]

{ #category : #converting }
BlElementId >> indexed: anIndex [
	"Convert me to an indexed id with a given index"
	<return: #BlElementId>

	^ BlElementIndexedId new
		prefixId: self;
		index: anIndex
]

{ #category : #testing }
BlElementId >> isIndexed [
	^ false
]

{ #category : #printing }
BlElementId >> printOn: aStream [
	self class isAbstract
		ifTrue: [ aStream print: self ]
		ifFalse: [ aStream print: self asSymbol ]
]
