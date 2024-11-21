Class {
	#name : #BlSigmoidGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'from',
		'to',
		'sharpness',
		'bendingPoint',
		'fromControl',
		'toControl',
		'orientation'
	],
	#classVars : [
		'AutomaticOrientation',
		'HorizontalOrientation',
		'VerticalOrientation'
	],
	#category : #'Bloc-Basic'
}

{ #category : #'class initialization' }
BlSigmoidGeometry class >> initialize [
	AutomaticOrientation := #automatic.
	VerticalOrientation := #vertical.
	HorizontalOrientation := #horizontal
]
