Class {
	#name : #BlScaledForm,
	#superclass : #Form,
	#instVars : [
		'form',
		'scaleFactor'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #'instance creation' }
BlScaledForm class >> form: aForm scaleFactor: aNumber [
	^ self basicNew
		setExtent: aForm extent
		depth: aForm nativeDepth
		bits: aForm bits;
		scaleFactor: aNumber
]

{ #category : #converting }
BlScaledForm >> asElement [
	^ BlElement new
		size: (self extent / self scaleFactor) asFloatPoint;
		addChild: (super asElement transformDo: [ :t | t topLeftOrigin scaleBy: 1.0 / self scaleFactor ]);
		yourself
]

{ #category : #accessing }
BlScaledForm >> scaleFactor [
	^ scaleFactor ifNil: [ 1.0 ]
]

{ #category : #accessing }
BlScaledForm >> scaleFactor: aNumber [
	scaleFactor := aNumber
]
