Class {
	#name : #BlDevScripterPulseTimeoutError,
	#superclass : #Error,
	#instVars : [
		'step',
		'duration',
		'isPulseRequested',
		'tasks'
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
BlDevScripterPulseTimeoutError >> step [

	^ step
]

{ #category : #accessing }
BlDevScripterPulseTimeoutError >> step: anObject [

	step := anObject
]

{ #category : #accessing }
BlDevScripterPulseTimeoutError >> tasks [

	^ tasks
]

{ #category : #accessing }
BlDevScripterPulseTimeoutError >> tasks: anObject [

	tasks := anObject
]
