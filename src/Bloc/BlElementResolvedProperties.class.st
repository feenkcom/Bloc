Class {
	#name : #BlElementResolvedProperties,
	#superclass : #BlElementMaybeResolvedProperties,
	#instVars : [
		'properties'
	],
	#category : #'Bloc-Core-Properties'
}

{ #category : #actions }
BlElementResolvedProperties >> applyOnElement: anElement [
	properties do: [ :eachPropertyWithStatus | eachPropertyWithStatus maybeCleanUpOnElement: anElement ].
	properties do: [ :eachPropertyWithStatus | eachPropertyWithStatus maybeApplyOnElement: anElement ]
]

{ #category : #enumerating }
BlElementResolvedProperties >> do: aBlock [
	properties do: aBlock
]

{ #category : #'adding / removing' }
BlElementResolvedProperties >> flushPropertiesToRemove [
	properties := properties reject: [ :eachPropertyWithStatus | eachPropertyWithStatus isToBeRemoved ]
]

{ #category : #testing }
BlElementResolvedProperties >> hasPropertiesToPropagateToChildren [
	"Please note, that properties is a dictionary of properties with status, they have a better
	check of propagation to children"

	^ properties anySatisfy: [ :eachProperty | eachProperty canPropagateToChildren ]
]

{ #category : #initialization }
BlElementResolvedProperties >> initialize [
	super initialize.
	
	properties := Dictionary new
]

{ #category : #accessing }
BlElementResolvedProperties >> mergedWithProperties: aBlElementResolvedProperties [
	| theProperties |

	theProperties := self propertiesToPropagateToChildren privateProperties copy
		addAll: aBlElementResolvedProperties privateProperties;
		yourself.

	^ BlElementResolvedProperties new properties: theProperties
]

{ #category : #accessing }
BlElementResolvedProperties >> mergedWithPropertiesWithStatus: aBlElementResolvedProperties [
	| theProperties |

	theProperties := Dictionary new.
	self propertiesToPropagateToChildren privateProperties associationsDo: [ :eachAssociation |
		theProperties
			at: eachAssociation key
			put: (BlElementPropertyWithStatus new property: eachAssociation value property) ].

	theProperties addAll: aBlElementResolvedProperties privateProperties.

	^ BlElementResolvedProperties new properties: theProperties
]

{ #category : #copying }
BlElementResolvedProperties >> postCopy [
	properties := properties copy
]

{ #category : #private }
BlElementResolvedProperties >> privateProperties [
	<return: #Dictionary>

	^ properties
]

{ #category : #private }
BlElementResolvedProperties >> properties: aDictionaryOfProperties [
	properties := aDictionaryOfProperties
]

{ #category : #accessing }
BlElementResolvedProperties >> propertiesToPropagateToChildren [
	<return: #BlElementPropagatableProperties>

	"only properties that are not to be removed should be propagated to children"
	^ BlElementPropagatableProperties new properties: (properties
		select: [ :eachPropertyWithStatus | eachPropertyWithStatus canPropagateToChildren ]
		thenCollect: [ :eachPropertyWithStatus | eachPropertyWithStatus property ])
]

{ #category : #accessing }
BlElementResolvedProperties >> propertyAt: aPropertyType ifFound: aFoundBlock ifNone: aNoneBlock [
	^ properties
		at: aPropertyType
		ifPresent: aFoundBlock
		ifAbsent: aNoneBlock
]
