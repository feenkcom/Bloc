Class {
	#name : #BlSteppedLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'relativeBounds',
		'mark'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #accessing }
BlSteppedLayoutConstraints >> mark [
	^ mark ifNil: [ mark := BlSteppedLayoutMark undefined ]
]

{ #category : #accessing }
BlSteppedLayoutConstraints >> mark: anObject [
	mark := anObject
]

{ #category : #accessing }
BlSteppedLayoutConstraints >> relativeBounds [
	^ relativeBounds
]

{ #category : #accessing }
BlSteppedLayoutConstraints >> relativeBounds: anObject [
	relativeBounds := anObject
]
