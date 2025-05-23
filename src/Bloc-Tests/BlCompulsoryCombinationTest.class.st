"
This class contains tests

"
Class {
	#name : #BlCompulsoryCombinationTest,
	#superclass : #TestCase,
	#instVars : [
		'combination',
		'buffer'
	],
	#category : #'Bloc-Tests-KeyBinding'
}

{ #category : #initialization }
BlCompulsoryCombinationTest >> setUp [
	super setUp.
	
	combination := BlCompulsoryCombination new.
	buffer := BlMockedKeyboardBuffer new
]

{ #category : #tests }
BlCompulsoryCombinationTest >> testInitialize [
	<gtExample>
	<return: #BlCompulsoryCombinationTest>
	self setUp.

	self assert: combination combinations isEmpty
]

{ #category : #tests }
BlCompulsoryCombinationTest >> testKey [
	<gtExample>
	<return: #BlCompulsoryCombinationTest>
	self setUp.

	self assert: combination combinations isEmpty.

	combination key: BlKeyboardKey a.
	self
		assert: (combination combinations asArray collect: #key)
		equals: {BlKeyboardKey a}.

	combination key: BlKeyboardKey b.
	self
		assert: (combination combinations asArray collect: #key)
		equals: {BlKeyboardKey a.
				BlKeyboardKey b}.

	combination key: BlKeyboardKey c.
	self
		assert: (combination combinations asArray collect: #key)
		equals: {BlKeyboardKey a.
				BlKeyboardKey b.
				BlKeyboardKey c}
]

{ #category : #tests }
BlCompulsoryCombinationTest >> testMatch [
	<gtExample>
	<noTest>
	self setUp.
	
	buffer pressed: false key: BlKeyboardKey a.
	buffer pressed: true key: BlKeyboardKey b.
	buffer pressed: true key: BlKeyboardKey c.
	
	self assert: (combination match: buffer) equals: 0.

	combination key: BlKeyboardKey c.
	self assert: (combination match: buffer) equals: 1.
	
	combination key: BlKeyboardKey b.
	self assert: (combination match: buffer) equals: 2.
	
	combination key: BlKeyboardKey a.
	self assert: (combination match: buffer) equals: 2.
]

{ #category : #tests }
BlCompulsoryCombinationTest >> testMatches [
	<gtExample>
	<return: #BlCompulsoryCombinationTest>
	self setUp.

	buffer pressed: true key: BlKeyboardKey a.
	buffer pressed: false key: BlKeyboardKey b.
	buffer pressed: true key: BlKeyboardKey c.

	self assert: (combination matchesKeyBuffer: buffer) not.

	combination key: BlKeyboardKey a.
	self assert: (combination matchesKeyBuffer: buffer) not.

	combination key: BlKeyboardKey c.
	self assert: (combination matchesKeyBuffer: buffer).

	combination key: BlKeyboardKey b.
	self assert: (combination matchesKeyBuffer: buffer) not
]
