Class {
	#name : #BlDevScripterStepExceptionSignal,
	#superclass : #BlDevScripterStepSignal,
	#instVars : [
		'exception'
	],
	#category : #'Bloc-Scripter-Signals'
}

{ #category : #accessing }
BlDevScripterStepExceptionSignal >> exception [
	^ exception
]

{ #category : #accessing }
BlDevScripterStepExceptionSignal >> exception: anObject [
	exception := anObject
]

{ #category : #accessing }
BlDevScripterStepExceptionSignal >> prepareForDelivery [
	super prepareForDelivery.
	
	exception ifNil: [ ^ self ].
	exception := exception copy.
	exception signalContext ifNotNil: [ exception freeze ].
]
