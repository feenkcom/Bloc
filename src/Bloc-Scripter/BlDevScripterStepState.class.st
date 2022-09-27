Class {
	#name : #BlDevScripterStepState,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Scripter-Scripter-States'
}

{ #category : #cleanup }
BlDevScripterStepState class >> cleanUp [
	self resetUniqueInstance
	
]

{ #category : #accessing }
BlDevScripterStepState class >> default [
	^ self uniqueInstance
]

{ #category : #accessing }
BlDevScripterStepState class >> executing [
	^ BlDevScripterStepExecutingState default
]

{ #category : #accessing }
BlDevScripterStepState class >> failure [
	^ BlDevScripterStepFailureState default
]

{ #category : #'gt - extensions' }
BlDevScripterStepState class >> gtScriptStepsFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Steps';
		priority: 20;
		items: [ (BlDevScripterStepState allSubclasses
				reject: #isAbstract
				thenCollect: #default) sort: [ :a :b | a priority < b priority ] ];
		column: ''
			stencil: [ :aState | 
				BlElement new
					size: 8 @ 8;
					background: aState color ]
			width: 8;
		column: 'Name'
			text: [ :aState | 
				| aName |
				aName := aState name asRopedText.
				aState class = self
					ifTrue: [ aName
							bold;
							append: (' (this is me)' asRopedText
									foreground: BrGlamorousColors disabledButtonTextColor) ].
				aName ];
		column: 'Priority' text: #priority
]

{ #category : #accessing }
BlDevScripterStepState class >> haltHere [
	^ BlDevScripterStepHaltState default
]

{ #category : #accessing }
BlDevScripterStepState class >> ready [
	^ BlDevScripterStepReadyState default
]

{ #category : #cleanup }
BlDevScripterStepState class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
BlDevScripterStepState class >> success [
	^ BlDevScripterStepSuccessState default
]

{ #category : #accessing }
BlDevScripterStepState class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
BlDevScripterStepState >> color [
	<return: #Color>
	^ self subclassResponsibility
]

{ #category : #testing }
BlDevScripterStepState >> isHalt [
	^ false
]

{ #category : #testing }
BlDevScripterStepState >> isReady [
	^ false
]

{ #category : #accessing }
BlDevScripterStepState >> name [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #accessing }
BlDevScripterStepState >> priority [
	^ 0
]

{ #category : #testing }
BlDevScripterStepState >> wasExecuted [
	<return: #Boolean>
	^ false
]
