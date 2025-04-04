Class {
	#name : #BlShearTransformation,
	#superclass : #BlAffineTransformation,
	#instVars : [
		'coefficient'
	],
	#category : #'Bloc-Core-Transformations'
}

{ #category : #accessing }
BlShearTransformation >> angleX: anAngleInDegrees [
	self coefficient: (anAngleInDegrees degreesToRadians) tan negated @ self coefficient y
]

{ #category : #accessing }
BlShearTransformation >> angleY: anAngleInDegrees [
	self coefficient: self coefficient x @ (anAngleInDegrees degreesToRadians) tan negated
]

{ #category : #accessing }
BlShearTransformation >> coefficient [
	^ coefficient
]

{ #category : #accessing }
BlShearTransformation >> coefficient: anObject [
	coefficient := anObject
]

{ #category : #initialization }
BlShearTransformation >> initialize [
	super initialize.
	
	coefficient := 0.0@0.0
]

{ #category : #testing }
BlShearTransformation >> is2D [
	"Return true if transformation happens in x-y plane, hence 2D"
	<return: #Boolean>
	
	^ true
]

{ #category : #'mathematical functions' }
BlShearTransformation >> multiplyOn: aBlMatrix [

	aBlMatrix multiplyBy: (BlMatrix2D shear: self coefficient)
]

{ #category : #printing }
BlShearTransformation >> printOn: aStream [
	aStream
		nextPutAll: 'Shear by ';
		nextPutAll: self coefficient asString
]
