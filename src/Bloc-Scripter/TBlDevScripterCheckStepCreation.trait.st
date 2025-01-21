"
I define very basic methods to create check steps using {{gtClass:BlDevScripterMultipleCheckStep}}.

"
Trait {
	#name : #TBlDevScripterCheckStepCreation,
	#category : #'Bloc-Scripter-Scripter'
}

{ #category : #adding }
TBlDevScripterCheckStepCreation >> addStep: aScripterTask [
	<return: #BlDevScripterStep>
	^ self explicitRequirement
]

{ #category : #'steps - subchecks' }
TBlDevScripterCheckStepCreation >> assert [
	"Builds a step to assert the state of the graphical scene"

	<scripterActionStep>
	^ BlDevScripterFutureCheckStep new parent: self
]

{ #category : #'steps - subchecks' }
TBlDevScripterCheckStepCreation >> assertStep: aBlock [
	| step |
	step := self assert.
	aBlock value: step.
	step play
]

{ #category : #'steps - subchecks' }
TBlDevScripterCheckStepCreation >> check [
	^ BlDevScripterFutureCheckStep new parent: self
]

{ #category : #'steps - subchecks' }
TBlDevScripterCheckStepCreation >> check: aLabel do: anOneArgBlock [
	^ self checks: aLabel do: anOneArgBlock
]

{ #category : #'steps - subchecks' }
TBlDevScripterCheckStepCreation >> checkStep: aBlock [
	| step |
	step := self check.
	aBlock value: step.
	step play
]

{ #category : #'steps - subchecks' }
TBlDevScripterCheckStepCreation >> checks [
	^ self addStep: (BlDevScripterMultipleCheckStep new referenceSender)
]

{ #category : #'steps - subchecks' }
TBlDevScripterCheckStepCreation >> checks: aLabel [
	^ self checks 
		label: aLabel;
		referenceSender
]

{ #category : #'steps - subchecks' }
TBlDevScripterCheckStepCreation >> checks: aLabel do: anOneArgBlock [
	| aStep |
	aStep := self checks: aLabel.
	aStep referenceSender.
	anOneArgBlock value: aStep.
	^ aStep
]

{ #category : #'steps - subchecks' }
TBlDevScripterCheckStepCreation >> fullyVisibleChildAt: anIndexBlock [
	| someIssues |
	^ self assert
		label: ('Assert element child at `{1}` is fully visible' format: {anIndexBlock});
		satisfies: [ :anElement | 
				someIssues := OrderedCollection new.
				anElement isVisibleInSpace
					ifFalse: [ someIssues add: ('Element is not visible in space: {1}' format: {anElement}) ].
				anElement allParents
					do: [ :aParent | 
						(anElement isVisibleFullyInParent: aParent)
							ifFalse: [ someIssues
									add: ('Element {1} is not visible in parent: {2}'
											format: {anElement.
													aParent}) ] ].
				someIssues isEmpty ]
			description: [ :anElement | 
				String
					streamContents: [ :aStream | 
						someIssues
							do: [ :eachString | 
								aStream
									nextPutAll: eachString;
									cr ] ] ]
]
