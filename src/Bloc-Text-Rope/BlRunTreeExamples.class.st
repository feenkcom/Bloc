Class {
	#name : #BlRunTreeExamples,
	#superclass : #Object,
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #accessing }
BlRunTreeExamples >> addRuns [
	<gtExample>
	
	| tree |
	tree := BlRunTree new: 10 withAll: {#foo}.
	tree
		add: {#bar}
		from: 1
		to: 3.
	tree
		add: {#baz}
		from: 5
		to: 9.
	self
		tree: tree
		equals: #(#(foo) #(foo bar) #(foo bar) #(foo bar) #(foo) #(foo baz) #(foo baz) #(foo baz) #(foo baz) #(foo baz)).
	^ tree
]

{ #category : #accessing }
BlRunTreeExamples >> appendRun [
	<gtExample>
	
	| tree |
	tree := BlRunTree new: 10 withAll: #foo.
	self assert: tree size equals: 10.
	tree
		replaceAllWith: #bar
		from: 1
		to: 5.
	tree
		replaceAllWith: #baz
		from: 6
		to: 8.
	self tree: tree equals: #(foo bar bar bar bar bar baz baz baz foo).
	tree
		replaceAllWith: #quux
		from: 3
		to: 8.
	self tree: tree equals: #(foo bar bar quux quux quux quux quux quux foo).
	tree append: #meta withOccurrences: 3.
	self tree: tree equals: #(foo bar bar quux quux quux quux quux quux foo meta meta meta).
	^ tree
]

{ #category : #accessing }
BlRunTreeExamples >> clearRuns [
	<gtExample>
	
	| tree |
	tree := self addRuns.
	tree
		clearAttributes: 1
		to: 7
		if: [ :att | att = #foo ].
	self tree: tree equals: #(#(foo) #(bar) #(bar) #(bar) #() #(baz) #(baz) #(baz) #(foo baz) #(foo baz)).
	^ tree
]

{ #category : #accessing }
BlRunTreeExamples >> collectFromTo [
	<gtExample>
	
	| tree collect |
	tree := self createRunTree.
	tree
		replaceAllWith: #bar
		from: 2
		to: 4.
	tree
		replaceAllWith: #baz
		from: 6
		to: 10.
	collect := tree collectFrom: 3 to: 7.
	self assert: collect size equals: 5.
	self assert: #(bar bar foo baz baz) equals: collect asArray.
	^ collect
]

{ #category : #accessing }
BlRunTreeExamples >> copyFromTo [
	<gtExample>
	
	| tree copytree |
	tree := self createRunTree.
	tree
		replaceAllWith: #bar
		from: 2
		to: 4.
	tree
		replaceAllWith: #baz
		from: 6
		to: 10.
	copytree := tree copyFrom: 3 to: 7.
	self assert: copytree size equals: 5.
	self tree: copytree equals: #(bar bar foo baz baz).
	^ copytree
]

{ #category : #accessing }
BlRunTreeExamples >> createRunTree [
	<gtExample>
	
	| tree |
	tree := BlRunTree new: 10 withAll: #foo.
	self tree: tree equals: (Array new: 10 withAll: #foo).
	^ tree
]

{ #category : #accessing }
BlRunTreeExamples >> immutabilityTests [

	<gtExample>
	| tree1 tree2 |
	tree1 := self createRunTree.
	tree2 := tree1 copy.
	tree1 replaceAllWith: #bar from: 1 to: 3.
	tree1 replaceAllWith: #baz from: 5 to: 9.
	self tree: tree1 equals: #( foo bar bar bar foo baz baz baz baz baz ).
	self tree: tree2 equals: (Array new: 10 withAll: #foo).
	tree2 := tree1 copy.
	tree1 replaceAllWith: #foo from: 5 to: 5.
	self tree: tree1 equals: #( foo bar bar bar foo foo baz baz baz baz ).
	self tree: tree2 equals: #( foo bar bar bar foo baz baz baz baz baz ).
	^tree1
]

{ #category : #accessing }
BlRunTreeExamples >> insertRun [
	<gtExample>
	
	| tree |
	tree := self createRunTree.
	tree
		replaceAllWith: #bar
		from: 1
		to: 5.
	tree
		replaceAllWith: #baz
		from: 6
		to: 8.
	self tree: tree equals: #(foo bar bar bar bar bar baz baz baz foo).
	tree
		replaceAllWith: #quux
		from: 3
		to: 8.
	self tree: tree equals: #(foo bar bar quux quux quux quux quux quux foo).
	tree insertAttributes: #(baz baz foo) atIndex: 4.
	self tree: tree equals: #(foo bar bar quux baz baz foo quux quux quux quux quux foo).
	^ tree
]

{ #category : #accessing }
BlRunTreeExamples >> otherWorstCase [
	<gtExample>
	
	| tree |
	tree := self createRunTree.
	9
		to: 1
		by: -2
		do:
			[ :i | 
			tree
				replaceAllWith: #bar
				from: i
				to: i ].
	self tree: tree equals: #(foo bar foo bar foo bar foo bar foo bar).
	^ tree
]

{ #category : #accessing }
BlRunTreeExamples >> replaceRuns [
	<gtExample>
	
	| tree |
	tree := BlRunTree new: 10 withAll: {#foo}.
	self assert: tree size equals: 10.
	tree
		replaceAllWith: {#bar}
		from: 1
		to: 3.
	tree
		replaceAllWith: {#baz}
		from: 5
		to: 9.
	self tree: tree equals: (#(foo bar bar bar foo baz baz baz baz baz) collect: [ :each | {each} ]).
	^ tree
]

{ #category : #accessing }
BlRunTreeExamples >> replacingNodes [
	<gtExample>
	
	| tree |
	tree := self createRunTree.
	tree
		replaceAllWith: #bar
		from: 1
		to: 3.
	tree
		replaceAllWith: #baz
		from: 5
		to: 9.
	self tree: tree equals: #(foo bar bar bar foo baz baz baz baz baz).
	tree
		replaceAllWith: #foo
		from: 0
		to: 9.
	self tree: tree equals: (Array new: 10 withAll: #foo).
	^ tree
]

{ #category : #accessing }
BlRunTreeExamples >> runEndAt [
	<gtExample>
	
	| tree |
	tree := self splitRun.
	#(1 1 7 7 7 7 7 7 9 9) keysAndValuesDo: [:i :end | self assert: (tree runEndAt: i-1) equals: end].
	^tree
]

{ #category : #accessing }
BlRunTreeExamples >> splitRun [
	<gtExample>
	
	| tree |
	tree := self createRunTree.
	tree
		replaceAllWith: #bar
		from: 0
		to: 4.
	tree
		replaceAllWith: #baz
		from: 5
		to: 7.
	self tree: tree equals: #(bar bar bar bar bar baz baz baz foo foo).
	tree
		replaceAllWith: #quux
		from: 2
		to: 7.
	self tree: tree equals: #(bar bar quux quux quux quux quux quux foo foo).
	^ tree
]

{ #category : #accessing }
BlRunTreeExamples >> tree: aTree equals: anArray [
	self assert: aTree size equals: anArray size.
	anArray keysAndValuesDo: [ :i :each | self assert: (aTree at: i-1) equals: each ]
]

{ #category : #accessing }
BlRunTreeExamples >> worstCase [
	<gtExample>
	
	| tree |
	tree := self createRunTree.
	1
		to: 9
		by: 2
		do:
			[ :i | 
			tree
				replaceAllWith: #bar
				from: i
				to: i ].
	self tree: tree equals: #(foo bar foo bar foo bar foo bar foo bar).
	^ tree
]
