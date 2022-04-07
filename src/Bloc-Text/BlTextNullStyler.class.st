Class {
	#name : #BlTextNullStyler,
	#superclass : #BlTextStyler,
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #testing }
BlTextNullStyler >> affectsText [
	^ false
]

{ #category : #private }
BlTextNullStyler >> privateStyle: aBlText [
	^ aBlText
]

{ #category : #private }
BlTextNullStyler >> style: aBlText [
	^ aBlText
]
