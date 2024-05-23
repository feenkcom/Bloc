Class {
	#name : #BlRelativePositionLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'percent'
	],
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #initalization }
BlRelativePositionLayoutConstraints >> initialize [
	super initialize.
	self percent: 0@0
]

{ #category : #accessing }
BlRelativePositionLayoutConstraints >> percent [
	^ percent
]

{ #category : #accessing }
BlRelativePositionLayoutConstraints >> percent: aPoint [
	percent := aPoint
]
