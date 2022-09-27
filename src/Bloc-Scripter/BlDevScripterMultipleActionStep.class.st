Class {
	#name : #BlDevScripterMultipleActionStep,
	#superclass : #BlDevScripterCompositeStep,
	#traits : 'TBlDevScripterActionStep + (TBlDevScripterCheckStepCreation - {#addStep:})',
	#classTraits : 'TBlDevScripterActionStep classTrait + TBlDevScripterCheckStepCreation classTrait',
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMultipleActionStep >> state [
	^ super state isReady
		ifTrue: [ (self steps detectMax: [ :eachStep | eachStep state priority ]) state ]
		ifFalse: [ super state ]
]
