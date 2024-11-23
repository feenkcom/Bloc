Class {
	#name : #BlElementUnresolvedProperties,
	#superclass : #BlElementMaybeResolvedProperties,
	#category : #'Bloc-Core-Properties'
}

{ #category : #actions }
BlElementUnresolvedProperties >> applyOnElement: anElement [
]

{ #category : #'adding / removing' }
BlElementUnresolvedProperties >> flushPropertiesToRemove [
]

{ #category : #testing }
BlElementUnresolvedProperties >> hasPropertiesToPropagateToChildren [
	^ false
]

{ #category : #accessing }
BlElementUnresolvedProperties >> propertyAt: aPropertyType ifFound: aFoundBlock ifNone: aNoneBlock [
	^ aNoneBlock value
]
