Class {
	#name : #BlRunTreeExamples,
	#superclass : #Object,
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #accessing }
BlRunTreeExamples >> coalescingNodes [
	<gtExample>
	
	| tree |
	tree := BlRunTree new: 10 withAll: #foo.
	self assert: tree size equals: 10.
	tree
		set: #bar
		from: 2
		to: 4.
	tree
		set: #baz
		from: 6
		to: 10.
	#(foo bar bar bar foo baz baz baz baz baz) keysAndValuesDo: [ :i :each | self assert: (tree at: i) equals: each ].
	1 to: 10 do: [:i | tree set: #foo from: i to: i].
	1 to: 10 do: [:i | self assert: (tree at: i) equals: #foo].
	self assert: tree height equals: 1.
	^ tree
]

{ #category : #accessing }
BlRunTreeExamples >> copyFromTo [
	<gtExample>
	
	| tree copytree |
	tree := BlRunTree new: 10 withAll: #foo.
	tree
		set: #bar
		from: 2
		to: 4.
	tree
		set: #baz
		from: 6
		to: 10.
	copytree := tree copyFrom: 3 to: 7.
	self assert: copytree size equals: 5.
	#(bar bar foo baz baz) keysAndValuesDo: [ :i :each | self assert: (copytree at: i) equals: each ].
	^ copytree
]

{ #category : #accessing }
BlRunTreeExamples >> createRunTree [
	<gtExample>
	
	| tree |
	tree := BlRunTree new: 10 withAll: #foo.
	self assert: tree size equals: 10.
	1 to: 10 do: [:i | self assert: (tree at: i) equals: #foo].
	^tree
]

{ #category : #accessing }
BlRunTreeExamples >> otherWorstCase [
	<gtExample>
	
	| tree |
	tree := BlRunTree new: 10 withAll: #foo.
	self assert: tree size equals: 10.
	10 to: 2 by: -2 do: [:i | tree set: #bar from: i to: i].
	#(foo bar foo bar foo bar foo bar foo bar) keysAndValuesDo: [ :i :each | self assert: (tree at: i) equals: each ].
	^ tree
]

{ #category : #accessing }
BlRunTreeExamples >> replacingNodes [
	<gtExample>
	
	| tree |
	tree := BlRunTree new: 10 withAll: #foo.
	self assert: tree size equals: 10.
	tree
		set: #bar
		from: 2
		to: 4.
	tree
		set: #baz
		from: 6
		to: 10.
	#(foo bar bar bar foo baz baz baz baz baz) keysAndValuesDo: [ :i :each | self assert: (tree at: i) equals: each ].
	tree set: #foo from: 1 to: 10.
	1 to: 10 do: [:i | self assert: (tree at: i) equals: #foo].
	^ tree
]

{ #category : #accessing }
BlRunTreeExamples >> setRuns [
	<gtExample>
	
	| tree |
	tree := BlRunTree new: 10 withAll: #foo.
	self assert: tree size equals: 10.
	tree
		set: #bar
		from: 2
		to: 4.
	tree
		set: #baz
		from: 6
		to: 10.
	#(foo bar bar bar foo baz baz baz baz baz) keysAndValuesDo: [ :i :each | self assert: (tree at: i) equals: each ].
	^ tree
]

{ #category : #accessing }
BlRunTreeExamples >> splitRun [
	<gtExample>
	
	| tree |
	tree := BlRunTree new: 10 withAll: #foo.
	self assert: tree size equals: 10.
	tree
		set: #bar
		from: 1
		to: 5.
	tree
		set: #baz
		from: 6
		to: 8.
	#(bar bar bar bar bar baz baz baz foo foo) keysAndValuesDo: [ :i :each | self assert: (tree at: i) equals: each ].
	tree set: #quux from: 3 to: 8.
	#(bar bar quux quux quux quux quux quux foo foo) keysAndValuesDo: [ :i :each | self assert: (tree at: i) equals: each ].
	^ tree
]

{ #category : #accessing }
BlRunTreeExamples >> worstCase [
	<gtExample>
	
	| tree |
	tree := BlRunTree new: 10 withAll: #foo.
	self assert: tree size equals: 10.
	2 to: 10 by: 2 do: [:i | tree set: #bar from: i to: i].
	#(foo bar foo bar foo bar foo bar foo bar) keysAndValuesDo: [ :i :each | self assert: (tree at: i) equals: each ].
	^ tree
]
