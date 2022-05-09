Class {
	#name : #BlRunTreeAbstractNode,
	#superclass : #Object,
	#instVars : [
		'length'
	],
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #'add / remove' }
BlRunTreeAbstractNode >> add: attributes from: start to: end [
	self subclassResponsibility
]

{ #category : #'add / remove' }
BlRunTreeAbstractNode >> append: attributes withOccurrences: anInteger [
	self subclassResponsibility
]

{ #category : #accessing }
BlRunTreeAbstractNode >> at: anIndex [
	self subclassResponsibility 
]

{ #category : #accessing }
BlRunTreeAbstractNode >> children [
	self subclassResponsibility
]

{ #category : #'add / remove' }
BlRunTreeAbstractNode >> clearAttributes: aFromIndex to: aToIndex if: aBlock [
	self subclassResponsibility
]

{ #category : #enumerating }
BlRunTreeAbstractNode >> collectInto: aCollection from: start to: end [
	self subclassResponsibility
]

{ #category : #copying }
BlRunTreeAbstractNode >> copyFrom: start to: end [
	self subclassResponsibility
]

{ #category : #accessing }
BlRunTreeAbstractNode >> delete: fromIndex to: toIndex [
	self subclassResponsibility
]

{ #category : #accessing }
BlRunTreeAbstractNode >> gtTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Tree';
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #accessing }
BlRunTreeAbstractNode >> height [
	self subclassResponsibility
]

{ #category : #initialization }
BlRunTreeAbstractNode >> initialize [
	length := 0
]

{ #category : #'add / remove' }
BlRunTreeAbstractNode >> insert: attributes atIndex: anInteger [
	self subclassResponsibility
]

{ #category : #accessing }
BlRunTreeAbstractNode >> isLeaf [
	^ false
]

{ #category : #accessing }
BlRunTreeAbstractNode >> length [

	^ length
]

{ #category : #accessing }
BlRunTreeAbstractNode >> length: anInteger [
	
	length := anInteger
]

{ #category : #accessing }
BlRunTreeAbstractNode >> paintTreeWith: view [
	| allNodes |
	allNodes := Dictionary new.
	self withOffset: 0 do: [ :off :node | allNodes at: node put: off ].
	(view nodes)
		shape:
				[ :each | 
					(BrVerticalPane new)
						when: BlClickEvent do: [ :event | event target phlow spawnObject: each ];
						zIndex: 10;
						border: (BlBorder paint: Color lightGray width: 1);
						background: (Color red alpha: each priority);
						fitContent;
						alignCenter;
						addChild:
								((BrLabel new)
										aptitude: BrGlamorousLabelAptitude;
										text: each length printString);
						addChild:
								((BrLabel new)
										aptitude:
												((BrGlamorousLabelAptitude new)
														fontSize: 8;
														foreground: Color lightGray);
										text: '(' , (allNodes at: each) printString , ',' , ((allNodes at: each) + each length - 1) printString , ')') ];
		with: (self withDeepCollect: #children).
	(view edges)
		shape: [ :each | BlLineElement new border: (BlBorder paint: Color lightGray width: 1) ];
		connectToAll: #children.
	view layout custom: GtGraphTreeLayout new
]

{ #category : #accessing }
BlRunTreeAbstractNode >> priority [
	"Random priorities used by the heap balancing code"
	self subclassResponsibility
]

{ #category : #'add / remove' }
BlRunTreeAbstractNode >> replaceAllWith: attributes from: start to: end [
	self subclassResponsibility
]

{ #category : #accessing }
BlRunTreeAbstractNode >> runEndAt: anIndex [
	self subclassResponsibility
]

{ #category : #enumerating }
BlRunTreeAbstractNode >> withOffset: anInteger do: aBlock [
	self subclassResponsibility 
]
