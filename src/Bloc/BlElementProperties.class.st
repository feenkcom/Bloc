"
# Element properties
That can be propagated from the parent element to the children.
For example font size is by default inherited by the children

"
Class {
	#name : #BlElementProperties,
	#superclass : #Object,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #enumerating }
BlElementProperties >> do: aBlock [
	self properties do: aBlock
]

{ #category : #testing }
BlElementProperties >> hasPropertiesToPropagateToChildren [
	^ self subclassResponsibility
]

{ #category : #testing }
BlElementProperties >> isEmpty [
	self do: [ :eachProperty | ^ false ].
	^ true
]

{ #category : #testing }
BlElementProperties >> isNotEmpty [
	^ self isEmpty not
]

{ #category : #printing }
BlElementProperties >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' properties: ';
		print: self properties
]

{ #category : #accessing }
BlElementProperties >> properties [
	^ #()
]

{ #category : #accessing }
BlElementProperties >> size [
	^ self properties size
]
