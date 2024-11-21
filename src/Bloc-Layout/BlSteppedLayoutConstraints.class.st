Class {
	#name : #BlSteppedLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'relativeBounds'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #accessing }
BlSteppedLayoutConstraints >> relativeBounds [
	^ relativeBounds
]

{ #category : #accessing }
BlSteppedLayoutConstraints >> relativeBounds: anObject [
	relativeBounds := anObject
]
