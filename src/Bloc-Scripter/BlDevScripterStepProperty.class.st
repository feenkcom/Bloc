Class {
	#name : #BlDevScripterStepProperty,
	#superclass : #Object,
	#category : #'Bloc-Scripter-Scripter-Properties'
}

{ #category : #accessing }
BlDevScripterStepProperty >> description [
	^ self gtDisplayText
]

{ #category : #testing }
BlDevScripterStepProperty >> isReference [
	<return: #Boolean>
	^ false
]

{ #category : #testing }
BlDevScripterStepProperty >> isScreenshot [
	^ false
]

{ #category : #testing }
BlDevScripterStepProperty >> isStepExecution [
	<return: #Boolean>
	^ false
]
