Class {
	#name : #BlSubRopeExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Rope'
}

{ #category : #'examples - attributes' }
BlSubRopeExamples >> clear_attributes_empty_0_to_0 [
	<gtExample>
	| anEmptyRope aRopeWithoutAttributes |
	
	anEmptyRope := self small_empty.
	aRopeWithoutAttributes := anEmptyRope clearAttributes: 0 to: 0.

	self assert: aRopeWithoutAttributes isEmpty.
	self assert: aRopeWithoutAttributes == anEmptyRope.

	^ aRopeWithoutAttributes
]

{ #category : #'as yet unclassified' }
BlSubRopeExamples >> readStreamSmall [
	<gtExample>
	| rope stream |

	rope := self small.
	stream := rope readStream.

	self assert: stream next equals: $H.
	self assert: (stream next: 3) asString equals: 'ell'.
	self assert: stream upToEnd asString equals: 'o'.
]

{ #category : #'instance creation' }
BlSubRopeExamples >> small [
	<gtExample>
	<label: 'Creates an instance of the rope of size smaller than combineLength with one attribute applied on the whole rope'>
	| aCollectionRope aRope |

	aCollectionRope := BlCollectionRope collection: 'EarthHelloWorld'.

	aRope := BlSubRope
		rope: aCollectionRope
		offset: 5
		length: 5.

	"attribute rope does not increase depth because it is just a plain wrapper"
	self assert: aRope depth equals: 1.
	self assert: aRope size equals: 5.
	self assert: aRope offset equals: 5.
	self assert: aRope rope == aCollectionRope.
	self assert: aRope isLeaf not.
	self assert: aRope size <= BlRope combineLength.
	
	^ aRope
]

{ #category : #'examples - accessing' }
BlSubRopeExamples >> small_at_each [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: (aRope at: 1) equals: $H.
	self assert: (aRope at: 2) equals: $e.
	self assert: (aRope at: 3) equals: $l.
	self assert: (aRope at: 4) equals: $l.
	self assert: (aRope at: 5) equals: $o.
	
	^ aRope
]

{ #category : #'examples - accessing' }
BlSubRopeExamples >> small_children [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope children equals: { aRope rope }.

	^ aRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamples >> small_delete_0_to_0 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 0 to: 0.

	self assert: aNewRope == aRope.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamples >> small_delete_0_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 0 to: 1.
	
	self assert: aNewRope size equals: 4.
	self assert: aNewRope collection equals: 'ello'.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamples >> small_delete_0_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 0 to: 5.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: ''.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamples >> small_delete_1_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 1 to: 1.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamples >> small_delete_1_to_3 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 1 to: 3.
	
	self assert: aNewRope size equals: 3.
	self assert: aNewRope collection equals: 'Hlo'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamples >> small_delete_1_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 1 to: 5.
	
	self assert: aNewRope size equals: 1.
	self assert: aNewRope collection equals: 'H'.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamples >> small_delete_4_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 4 to: 5.
	
	self assert: aNewRope size equals: 4.
	self assert: aNewRope collection equals: 'Hell'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamples >> small_delete_5_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 5 to: 5.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - accessing' }
BlSubRopeExamples >> small_depth [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope depth equals: 1.

	^ aRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamples >> small_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'Hello'.

	^ theIterated
]

{ #category : #'instance creation' }
BlSubRopeExamples >> small_empty [
	<gtExample>
	| aRope anEmpty |

	aRope := self small.
	anEmpty := aRope empty.

	self assert: anEmpty size equals: 0.
	self assert: anEmpty collection equals: ''.

	^ anEmpty
]

{ #category : #'examples - from to' }
BlSubRopeExamples >> small_from_0_to_0 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 0 to: 0.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: ''.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamples >> small_from_0_to_0_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 0 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #'examples - from to' }
BlSubRopeExamples >> small_from_0_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 0 to: 1.
	
	self assert: aNewRope size equals: 1.
	self assert: aNewRope offset equals: 5.
	self assert: aNewRope rope == aRope rope.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamples >> small_from_0_to_1_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 1 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'H'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlSubRopeExamples >> small_from_0_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 0 to: 5.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamples >> small_from_0_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'Hello'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlSubRopeExamples >> small_from_1_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 1 to: 1.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: ''.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamples >> small_from_1_to_1_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 1 to: 1 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #'examples - from to' }
BlSubRopeExamples >> small_from_1_to_2 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 1 to: 2.
	
	self assert: aNewRope size equals: 1.
	self assert: aNewRope offset equals: 6.
	self assert: aNewRope rope == aRope rope.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamples >> small_from_1_to_2_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 1 to: 2 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'e'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlSubRopeExamples >> small_from_1_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 1 to: 5.
	
	self assert: aNewRope size equals: 4.
	self assert: aNewRope offset equals: 6.
	self assert: aNewRope rope == aRope rope.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamples >> small_from_1_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 1 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'ello'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlSubRopeExamples >> small_from_3_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 3 to: 5.
	
	self assert: aNewRope size equals: 2.
	self assert: aNewRope offset equals: 8.
	self assert: aNewRope rope == aRope rope.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamples >> small_from_3_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 3 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'lo'.

	^ theIterated
]

{ #category : #'examples - testing' }
BlSubRopeExamples >> small_isEmpty [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope isEmpty not.

	^ aRope
]

{ #category : #'examples - testing' }
BlSubRopeExamples >> small_isLeaf [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope isLeaf not.

	^ aRope
]

{ #category : #'examples - testing' }
BlSubRopeExamples >> small_isNotEmpty [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope isNotEmpty.

	^ aRope
]

{ #category : #'examples - accessing' }
BlSubRopeExamples >> small_size [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope size equals: 5.

	^ aRope
]
