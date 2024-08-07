Class {
	#name : #BlDevScripterCompositeStep,
	#superclass : #BlDevScripterStep,
	#traits : 'TBlDevScripterCompositeStepTarget + TBlDevScripterTarget',
	#classTraits : 'TBlDevScripterCompositeStepTarget classTrait + TBlDevScripterTarget classTrait',
	#instVars : [
		'steps'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #adding }
BlDevScripterCompositeStep >> addStep: aStep [
	steps add: aStep.
	scripter ifNotNil: [ :aScripter | aStep scripter: aScripter ].
	^ aStep
]

{ #category : #accessing }
BlDevScripterCompositeStep >> defaultLabel [
	^ 'Steps'
]

{ #category : #initialization }
BlDevScripterCompositeStep >> initialize [
	super initialize.
	
	steps := OrderedCollection new
]

{ #category : #testing }
BlDevScripterCompositeStep >> isStepWithTarget [
	"Composition does not have its own target. It returns target of a last sub-step."

	^ false
]

{ #category : #accessing }
BlDevScripterCompositeStep >> label: aString [
	self steps 
		ifEmpty: [ super label: aString ] 
		ifNotEmpty: [ self steps last label: aString ]
]

{ #category : #actions }
BlDevScripterCompositeStep >> playOn: aScripter [
	"self steps do: [ :eachTask | eachTask playIndicatingStateOn: aScripter ]"
]

{ #category : #actions }
BlDevScripterCompositeStep >> playOnExecutor: anExecutor [
	self steps do: [ :eachStep | 
		anExecutor executeStep: eachStep.
		eachStep privatePulseUntilReady ]
]

{ #category : #'targets - accessing and updating' }
BlDevScripterCompositeStep >> previousTarget [
	<return: #BlScripterElementTarget>
	self 
		assert: [ self steps size > 1 ]
		description: [ 'Two steps must be defined before accessing previous target' ].
	^ (self steps at: self steps size - 1) target
]

{ #category : #accessing }
BlDevScripterCompositeStep >> realTarget [
	<return: #BlDevScripterTarget>
	^ BlDevScripterTarget null
]

{ #category : #accessing }
BlDevScripterCompositeStep >> state [
	^ super state isReady
		ifTrue: [ self steps
				ifNotEmpty: [ (self steps detectMax: [ :eachStep | eachStep state priority ]) state ]
				ifEmpty: [ super state ] ]
		ifFalse: [ super state ]
]

{ #category : #accessing }
BlDevScripterCompositeStep >> steps [
	^ steps
]

{ #category : #accessing }
BlDevScripterCompositeStep >> subLabel: aString [
	self
		assert: [ self steps isNotEmpty ] 
		description: [ 'Composite step must have sub-steps in order to set a sub-label' ].
	self steps last label: aString
]

{ #category : #'targets - accessing and updating' }
BlDevScripterCompositeStep >> target [
	"We access the target of the last sub-step.
	It simplifies API as we can send a target definition message to me. 
	We can write: 
		aStep
			elementSatisfies: [ :anElement | anElement text asString = 'feenk' ];
			onElementOfClass: BlTextElement.
	Instead of 
		(aStep elementSatisfies: [ :anElement | anElement text asString = 'feenk' ])
			onElementOfClass: BlTextElement."
	<return: #BlScripterElementTarget>
	self 
		assert: [ self steps isNotEmpty ]
		description: [ 'One step must be defined before accessing its target' ].
	^ self steps last target
]

{ #category : #'targets - accessing and updating' }
BlDevScripterCompositeStep >> target: aScripterEventTarget [
	"We access the target of the last sub-step.
	See #target message for the detailed explanation."
	self 
		assert: [ self steps isNotEmpty ]
		description: [ 'One step must be defined before defining its target' ].
	self steps last target: aScripterEventTarget
]
