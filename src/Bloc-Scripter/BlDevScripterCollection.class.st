Class {
	#name : #BlDevScripterCollection,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'Bloc-Scripter-Scripter-Utilities'
}

{ #category : #accessing }
BlDevScripterCollection >> at: anIndex [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlDevScripterCollection >> collection [
	^ collection
]

{ #category : #accessing }
BlDevScripterCollection >> collection: anObject [
	collection := anObject
]

{ #category : #enumerating }
BlDevScripterCollection >> detect: aBlock ifFound: foundBlock ifNone: exceptionBlock [
	^ self subclassResponsibility
]

{ #category : #enumerating }
BlDevScripterCollection >> detect: aBlock ifNone: exceptionBlock [
	^ self detect: aBlock ifFound: [ :anEvent | anEvent ] ifNone: exceptionBlock
]

{ #category : #enumerating }
BlDevScripterCollection >> detectEventOfClass: anEventClass ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self 
		detectEventOfClass: anEventClass 
		satisfying: [ :anEvent | true ] 
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #enumerating }
BlDevScripterCollection >> detectEventOfClass: anEventClass ifNone: aNoneBlock [
	^ self 
		detectEventOfClass: anEventClass 
		satisfying: [ :anEvent | true ] 
		ifFound: [ :anEvent | anEvent ]
		ifNone: aNoneBlock
]

{ #category : #enumerating }
BlDevScripterCollection >> detectEventOfClass: anEventClass satisfying: anOneArgBlock ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self 
		detect: [ :eachEvent | eachEvent class = anEventClass and: [ anOneArgBlock value: eachEvent ] ] 
		ifFound: aFoundBlock 
		ifNone: aNoneBlock
]

{ #category : #enumerating }
BlDevScripterCollection >> do: aBlock [
	self subclassResponsibility
]

{ #category : #accessing }
BlDevScripterCollection >> first [
	^ self at: 1
]

{ #category : #'gt-extension' }
BlDevScripterCollection >> gtGroupedEventsFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Grouped events';
		priority: 10;
		items: [ (self collection groupedBy: #class) associations
				sort: [ :a :b | a key name < b key name ] ];
		children: [ :anObject | (anObject isKindOf: Association) ifTrue: [ anObject value ] ifFalse: [ #() ] ];
		column: 'Item'
			text: [ :anObject | 
				(anObject isKindOf: Association)
					ifTrue: [ '{1} [{2} {3}]'
							format: {anObject key gtDisplayText.
									anObject value size.
									'item' asPluralBasedOn: anObject value size} ]
					ifFalse: [ anObject gtDisplayText ] ]
]

{ #category : #testing }
BlDevScripterCollection >> ifEmpty: aBlock [
	^ self collection ifEmpty: aBlock
]

{ #category : #testing }
BlDevScripterCollection >> ifNotEmpty: aBlock [
	^ self collection ifNotEmpty: aBlock
]

{ #category : #initialization }
BlDevScripterCollection >> initialize [
	super initialize.
	collection := OrderedCollection new.
]

{ #category : #testing }
BlDevScripterCollection >> isEmpty [
	^ self collection isEmpty
]

{ #category : #testing }
BlDevScripterCollection >> isNotEmpty [
	^ self collection isNotEmpty
]

{ #category : #removing }
BlDevScripterCollection >> removeAll [
	collection removeAll
]

{ #category : #enumerating }
BlDevScripterCollection >> select: aBlock [
	| newCollection |

	newCollection := OrderedCollection new.
	self do: [ :eachEvent | 
		(aBlock value: eachEvent) 
			ifTrue: [ newCollection add: eachEvent ] ].

	^ self class new collection: newCollection
]

{ #category : #accessing }
BlDevScripterCollection >> size [
	^ self collection size
]
