Class {
	#name : #BlDevScripterMultipleCheckStep,
	#superclass : #BlDevScripterCompositeStep,
	#traits : 'TBlDevScripterCheckStep + (TBlDevScripterCheckStepCreation - {#addStep:})',
	#classTraits : 'TBlDevScripterCheckStep classTrait + TBlDevScripterCheckStepCreation classTrait',
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMultipleCheckStep >> defaultLabel [
	^ 'Assertions'
]

{ #category : #accessing }
BlDevScripterMultipleCheckStep >> stepIcon [
	<return: #BlElement or: nil>
	^ BrGlamorousVectorIcons accept
]
