Class {
	#name : #BlPluggableStyler,
	#superclass : #BlTextStyler,
	#instVars : [
		'block'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #accessing }
BlPluggableStyler >> block [
	^ block
]

{ #category : #accessing }
BlPluggableStyler >> block: anObject [
	block := anObject
]

{ #category : #'as yet unclassified' }
BlPluggableStyler >> privateStyle: aText [ 
	<return: #BlText>

	block value: aText.
	^ aText
]
