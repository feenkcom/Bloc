Class {
	#name : #BlDevScripterPulseTimeoutError,
	#superclass : #Error,
	#instVars : [
		'step',
		'duration',
		'isPulseRequested',
		'scripter',
		'isSpaceTaskQueueEmpty'
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
BlDevScripterPulseTimeoutError >> isSpaceTaskQueueEmpty [

	^ isSpaceTaskQueueEmpty
]

{ #category : #accessing }
BlDevScripterPulseTimeoutError >> isSpaceTaskQueueEmpty: anObject [

	isSpaceTaskQueueEmpty := anObject
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
