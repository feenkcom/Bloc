"
This class contains tests

"
Class {
	#name : #BlElementTest,
	#superclass : #TestCase,
	#instVars : [
		'space',
		'host'
	],
	#category : #'Bloc-Tests-Basic'
}

{ #category : #initialization }
BlElementTest >> element [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		size: 50 @ 50;
		yourself
]

{ #category : #initialization }
BlElementTest >> invisible [
	<gtExample>
	<return: #BlElement>
	^ self element visibility: BlVisibility hidden
]

{ #category : #initialization }
BlElementTest >> setUp [
	super setUp.
	
	space := BlSpace new.
	host := BlMockedHost new.

	space host: host.
	host createHostSpaceFor: space.
]

{ #category : #initialization }
BlElementTest >> tearDown [
	super tearDown.

	host destroyHostSpaceFor: space.
	space host: nil.
	host := nil.
	space := nil
]

{ #category : #default }
BlElementTest >> testDefault [
	| element |
	
	element := self element.
	
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element geometry extent equals: 0@0
]

{ #category : #'focus testing' }
BlElementTest >> testHasFocus [
	| element child |
	
	element := self element.
	child := self element.
	
	element addChild: child.
	space root addChild: element.
	self assert: element hasFocus not.
	self assert: child hasFocus not.

	element focused: true.
	self assert: element hasFocus.
	self assert: child hasFocus not.
	
	element focused: false.
	child focused: true.
	
	self assert: element hasFocus.
	self assert: child hasFocus.
]

{ #category : #'focus testing' }
BlElementTest >> testHasFocusable [
	| element child |

	element := self element.
	child := self element.
	element addChild: child.
	
	self assert: element hasFocusable.
	self assert: child hasFocusable.
	
	element visibility: BlVisibility hidden.
	self assert: element hasFocusable.
	self assert: child hasFocusable.
	
	child visibility: BlVisibility hidden.
	self assert: element hasFocusable not.
	self assert: child hasFocusable not.
	
	element visibility: BlVisibility visible.
	self assert: element hasFocusable.
	self assert: child hasFocusable not.
	
	child visibility: BlVisibility visible.
	self assert: element hasFocusable.
	self assert: child hasFocusable
]

{ #category : #'focus testing' }
BlElementTest >> testIsFocusable [
	| element |

	element := self element.
	self assert: element isFocusable.
	
	element visibility: BlVisibility gone.
	self assert: element isFocusable not.
	
	element visibility: BlVisibility hidden.
	self assert: element isFocusable not.
	
	element visibility: BlVisibility visible.
	self assert: element isFocusable.
	
	element visibility: BlVisibility visible.
	self assert: element isFocusable.
	
	element preventMouseEvents.
	self assert: element isFocusable not.
	
	element allowMouseEvents.
	self assert: element isFocusable.
]

{ #category : #'focus testing' }
BlElementTest >> testIsFocused [
	| element |
	
	element := self element.
	
	space root addChild: element.
	self assert: element isFocused not.

	element focused: true.
	self assert: element isFocused
]

{ #category : #'focus requesting' }
BlElementTest >> testRequestFocus [
	| element child another elementEvents childEvents anotherEvents |
	
	elementEvents := OrderedCollection new.
	childEvents := OrderedCollection new.
	anotherEvents := OrderedCollection new.
	
	element := self element.
	element addEventHandlerOn: BlFocusEvent do: [ :anEvent | elementEvents add: anEvent ].
	element addEventHandlerOn: BlBlurEvent do: [ :anEvent | elementEvents add: anEvent ].
	child := self element.
	child addEventHandlerOn: BlFocusEvent do: [ :anEvent | childEvents add: anEvent ].
	child addEventHandlerOn: BlBlurEvent do: [ :anEvent | childEvents add: anEvent ].
	another := self element.
	another addEventHandlerOn: BlFocusEvent do: [ :anEvent | anotherEvents add: anEvent ].
	another addEventHandlerOn: BlBlurEvent do: [ :anEvent | anotherEvents add: anEvent ].

	another addChild: child.
	space root addChildren: { element . another }.
	
	self assert: element isFocused not.
	self assert: child isFocused not.
	self assert: another isFocused not.
	self assert: elementEvents size equals: 0.
	self assert: anotherEvents size equals: 0.
	self assert: childEvents size equals: 0.

	element requestFocus.
	self assert: element isFocused.
	self assert: child isFocused not.
	self assert: another isFocused not.
	self assert: elementEvents size equals: 1.
	self assert: elementEvents first isFocus.
	self assert: elementEvents first target == element.
	self assert: anotherEvents size equals: 0.
	self assert: childEvents size equals: 0.
	elementEvents removeAll.
	
	another requestFocus.
	self assert: element isFocused not.
	self assert: child isFocused not.
	self assert: another isFocused.
	self assert: elementEvents size equals: 1.
	self assert: elementEvents first isBlur.
	self assert: elementEvents first target == element.
	self assert: anotherEvents size equals: 1.
	self assert: anotherEvents first isFocus.
	self assert: anotherEvents first target == another.
	self assert: childEvents size equals: 0.
	elementEvents removeAll.
	anotherEvents removeAll.
	
	child requestFocus.
	self assert: element isFocused not.
	self assert: child isFocused.
	self assert: another isFocused not.
	self assert: elementEvents size equals: 0.
	self assert: anotherEvents size equals: 1.
	self assert: anotherEvents first isBlur.
	self assert: anotherEvents first target == another.
	self assert: childEvents size equals: 1.
	self assert: childEvents first isFocus.
	self assert: childEvents first target == child.
]

{ #category : #initialization }
BlElementTest >> visible [
	<gtExample>
	<return: #BlElement>
	^ self element
]
