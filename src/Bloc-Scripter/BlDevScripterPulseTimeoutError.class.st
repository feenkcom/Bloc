Class {
	#name : #BlDevScripterPulseTimeoutError,
	#superclass : #Error,
	#instVars : [
		'step',
		'duration',
		'isPulseRequested',
		'scripter',
		'isSpaceTaskQueueWithTasks'
	],
	#category : #'Bloc-Scripter-Scripter-Exceptions'
}

{ #category : #accessing }
BlDevScripterPulseTimeoutError >> duration [

	^ duration
]

{ #category : #accessing }
BlDevScripterPulseTimeoutError >> duration: anObject [

	duration := anObject
]

{ #category : #accessing }
BlDevScripterPulseTimeoutError >> isPulseRequested [

	^ isPulseRequested
]

{ #category : #accessing }
BlDevScripterPulseTimeoutError >> isPulseRequested: anObject [

	isPulseRequested := anObject
]

{ #category : #accessing }
BlDevScripterPulseTimeoutError >> isSpaceTaskQueueWithTasks [

	^ isSpaceTaskQueueWithTasks
]

{ #category : #accessing }
BlDevScripterPulseTimeoutError >> isSpaceTaskQueueWithTasks: aBoolean [

	isSpaceTaskQueueWithTasks := aBoolean
]

{ #category : #accessing }
BlDevScripterPulseTimeoutError >> scripter [

	^ scripter
]

{ #category : #accessing }
BlDevScripterPulseTimeoutError >> scripter: anObject [

	scripter := anObject
]

{ #category : #accessing }
BlDevScripterPulseTimeoutError >> step [

	^ step
]

{ #category : #accessing }
BlDevScripterPulseTimeoutError >> step: anObject [

	step := anObject
]
