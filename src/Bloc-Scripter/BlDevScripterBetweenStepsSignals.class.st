Class {
	#name : #BlDevScripterBetweenStepsSignals,
	#superclass : #Object,
	#instVars : [
		'previousStep'
	],
	#category : #'Bloc-Scripter-Scripter-Utilities'
}

{ #category : #printing }
BlDevScripterBetweenStepsSignals >> gtDisplayOn: aStream [
	self previousStep
		ifNil: [ aStream nextPutAll: 'Before any step signals' ]
		ifNotNil: [ :aStep | 
			aStream nextPutAll: 'After '.
			aStep gtDisplayOn: aStream ]
]

{ #category : #accessing }
BlDevScripterBetweenStepsSignals >> previousStep [
	^ previousStep
]

{ #category : #accessing }
BlDevScripterBetweenStepsSignals >> previousStep: anObject [
	previousStep := anObject
]
