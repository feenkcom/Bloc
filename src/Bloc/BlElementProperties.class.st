"
# Element properties
That can be propagated from the parent element to the children.
For example font size is by default inherited by the children

"
Class {
	#name : #BlElementProperties,
	#superclass : #Object,
	#category : #'Bloc-Core-Properties'
}

{ #category : #enumerating }
BlElementProperties >> do: aBlock [
	self subclassResponsibility
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
