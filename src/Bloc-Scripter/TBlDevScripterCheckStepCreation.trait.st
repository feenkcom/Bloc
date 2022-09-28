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
TBlDevScripterCheckStepCreation >> check [
	^ BlDevScripterFutureCheckStep new parent: self
]

{ #category : #'steps - subchecks' }
TBlDevScripterCheckStepCreation >> check: aLabel do: anOneArgBlock [
	^ self checks: aLabel do: anOneArgBlock
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
