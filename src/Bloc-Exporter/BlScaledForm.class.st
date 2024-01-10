Class {
	#name : #BlScaledForm,
	#superclass : #Form,
	#instVars : [
		'form',
		'scaleFactor'
	],
	#category : #'Bloc-Exporter'
}

{ #category : #'instance creation' }
BlScaledForm class >> form: aForm scaleFactor: aNumber [
	^ self basicNew
		setExtent: aForm extent
		depth: aForm nativeDepth
		bits: aForm bits;
		scaleFactor: aNumber
]

{ #category : #accessing }
BlScaledForm >> scaleFactor [
	^ scaleFactor ifNil: [ 1.0 ]
]

{ #category : #accessing }
BlScaledForm >> scaleFactor: aNumber [
	scaleFactor := aNumber
]
